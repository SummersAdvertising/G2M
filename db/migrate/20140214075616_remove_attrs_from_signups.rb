class RemoveAttrsFromSignups < ActiveRecord::Migration
  def change
  	remove_column :signups, :office_interested
  	remove_column :signups, :pc_interested
  	remove_column :signups, :reason
  end
end
