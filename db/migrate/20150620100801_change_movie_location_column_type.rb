class ChangeMovieLocationColumnType < ActiveRecord::Migration
  def change
	change_column :movies, :location, :text, :limit => nil
  end
end
