class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :company
      t.string :email
      t.string :phone
      t.text :address
      t.string :city
      t.string :postcode
      t.references :lead, foreign_key: true

      t.timestamps
    end
  end
end
