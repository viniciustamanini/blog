class CreatePersons < ActiveRecord::Migration[7.1]
  def change
    create_table :persons do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :role
      t.text :summary

      t.timestamps
    end
  end
end
