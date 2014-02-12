class AddRecordIdToSignups < ActiveRecord::Migration
  def change
    add_column :signups, :record_id, :integer
  end
end
