class CreateAttends < ActiveRecord::Migration
  def change
    create_table :attends do |t|
      t.integer :userid
      t.integer :eventid

      t.timestamps
    end
  end
end
