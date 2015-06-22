class AddDateColumnToMovie < ActiveRecord::Migration
  def change
	 add_column :movies, :date, :string
  end
end
