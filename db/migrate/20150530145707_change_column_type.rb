class ChangeColumnType < ActiveRecord::Migration
def change
	def up
		change_column :events, :description, :text
	end
	
	def down
		change_column :events, :description, :text
	end
end


