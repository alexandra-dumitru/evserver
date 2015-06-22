class ChangeMovieColumnType < ActiveRecord::Migration
  def change
	change_column :movies, :time, :text, :limit => nil
	change_column :movies, :latitude, :text, :limit => nil
	change_column :movies, :longitude, :text, :limit => nil
	
  end
end
