class AddUserToPostsAndComments < ActiveRecord::Migration[7.1]
  def up
    add_reference :posts, :user, null: true, foreign_key: true
    add_reference :comments, :user, null: true, foreign_key: true

    first_user_id = select_value('SELECT id FROM users ORDER BY id ASC LIMIT 1')
    if first_user_id
      execute("UPDATE posts SET user_id = #{connection.quote(first_user_id)} WHERE user_id IS NULL")
    end
  end

  def down
    remove_reference :comments, :user, foreign_key: true
    remove_reference :posts, :user, foreign_key: true
  end
end
