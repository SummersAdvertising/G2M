class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name
      t.string :company
      t.string :title
      t.string :email
      t.string :phone
      t.string :activation
      t.text :interesting_product
      t.text :interesting_brand
      t.integer :computer_num
      t.text :existing_os
      t.text :office_version
      t.string :updating
      t.string :working

      t.timestamps
    end
  end
end
