class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :post, null: false, foreign_key: true
      t.references :parent, null: true, foreign_key: { to_table: :comments }
      t.string :author_name, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
