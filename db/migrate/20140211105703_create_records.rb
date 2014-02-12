class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :user_fbid
      t.string :user_type
      t.text :answer
      t.string :fbshare_id

      t.timestamps
    end
  end
end
