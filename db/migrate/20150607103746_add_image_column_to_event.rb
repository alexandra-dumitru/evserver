class AddImageColumnToEvent < ActiveRecord::Migration
  def change
	add_column :events, :imagesource, :string
  end
end
