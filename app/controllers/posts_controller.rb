class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_blog_post, only: %i[show edit destroy update]

  def index
    scope = user_signed_in? ? Post.all.sorted : Post.published.sorted

    @posts = if params[:tag].present?
               scope.tagged_with(params[:tag])
             else
               scope
             end
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :published_at, :tag_list)
  end

  def set_blog_post
    @post = user_signed_in? ? Post.find(params[:id]) : Post.published.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
