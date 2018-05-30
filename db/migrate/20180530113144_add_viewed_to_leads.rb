class AddViewedToLeads < ActiveRecord::Migration[5.2]
  def change
    add_column :leads, :viewed, :boolean, default: false
  end
end
