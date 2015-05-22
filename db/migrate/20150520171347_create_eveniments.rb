class CreateEveniments < ActiveRecord::Migration
  def change
    create_table :eveniments do |t|
      t.string :title
      t.text :description
      t.date :date
      t.time :timestart
      t.time :timeend
      t.string :category
      t.float :price
      t.string :location

      t.timestamps
    end
  end
end
