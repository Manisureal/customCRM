class AddProductsToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :product, :string, array: true
  end
end
