class CreateLeads < ActiveRecord::Migration[5.2]
  def change
    create_table :leads do |t|
      t.string :name
      t.string :company
      t.string :email
      t.string :phone
      t.text :message
      t.string :status

      t.timestamps
    end
  end
end
