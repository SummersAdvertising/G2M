class CreateSignups < ActiveRecord::Migration
  def change
    create_table :signups do |t|
      t.string :name
      t.string :company
      t.string :title
      t.string :email
      t.string :tel
      t.string :reason
      t.string :pc_interested
      t.string :pc_os
      t.integer :having_pc
      t.string :office_interested
      t.string :office_version
      t.string :update_need

      t.timestamps
    end
  end
end
