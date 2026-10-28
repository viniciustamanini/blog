class CommentsController < ApplicationController
  RATE_LIMIT_STORE = ActiveSupport::Cache::MemoryStore.new
  MAX_COMMENTS_PER_MINUTE = 5

  before_action :authenticate_user!, only: %i[destroy]
  before_action :set_post
  before_action :check_rate_limit, only: %i[create]

  invisible_captcha only: %i[create], honeypot: :subtitle, timestamp_threshold: 1

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user if user_signed_in?

    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to @post, notice: 'Comment posted.' }
      else
        format.html do
          redirect_to @post, alert: @comment.errors.full_messages.to_sentence
        end
      end
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @post, notice: 'Comment removed.' }
    end
  end

  private

  def set_post
    @post = user_signed_in? ? Post.find(params[:post_id]) : Post.published.find(params[:post_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Post not found.'
  end

  def comment_params
    params.require(:comment).permit(:author_name, :body, :parent_id)
  end

  def check_rate_limit
    return if user_signed_in?

    key = "comment_rate:#{request.remote_ip}"
    count = RATE_LIMIT_STORE.read(key).to_i

    if count >= MAX_COMMENTS_PER_MINUTE
      redirect_to @post, alert: 'Rate limit exceeded. Please wait a minute before commenting again.'
    else
      RATE_LIMIT_STORE.write(key, count + 1, expires_in: 1.minute)
    end
  end
end
