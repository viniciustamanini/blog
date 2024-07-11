class CreateProfessionalExperiences < ActiveRecord::Migration[7.1]
  def change
    create_table :professional_experiences do |t|
      t.string :company_name
      t.string :role
      t.date :started_on
      t.date :ended_on
      t.text :description
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
