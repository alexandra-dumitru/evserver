class AddColumnToEvent < ActiveRecord::Migration
  def change
	add_column :events, :category_name, :string
  end
end
