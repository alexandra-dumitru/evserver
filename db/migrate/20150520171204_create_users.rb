class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :facebookid
      t.string :googleid
      t.integer :calendaritem
      t.integer :favoriteitem

      t.timestamps
    end
  end
end
