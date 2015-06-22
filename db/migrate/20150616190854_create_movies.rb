class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.string :time
      t.string :location
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
