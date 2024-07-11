class CreateCertificates < ActiveRecord::Migration[7.1]
  def change
    create_table :certificates do |t|
      t.string :name
      t.string :issuing_organization
      t.date :issued_on
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
