class AddAttrsToSignups < ActiveRecord::Migration
  def change
    add_column :signups, :industry, :string
    add_column :signups, :having_mobile_device, :string
    add_column :signups, :bring_pc_to_work, :string
    add_column :signups, :company_mobile_device, :string
  end
end
