class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.date :date
      t.time :timestart
      t.time :timeend
      t.string :location

      t.timestamps
    end
  end
end
