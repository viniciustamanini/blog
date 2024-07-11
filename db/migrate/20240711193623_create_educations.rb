class CreateEducations < ActiveRecord::Migration[7.1]
  def change
    create_table :educations do |t|
      t.string :institution_name
      t.string :degree
      t.string :field_of_study
      t.date :started_on
      t.date :ended_on
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
