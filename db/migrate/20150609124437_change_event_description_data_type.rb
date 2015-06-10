class ChangeEventDescriptionDataType < ActiveRecord::Migration
  def change
	def up
    change_table :events do |t|
      t.change :date, :string
	  t.change :timestart, :string
	  t.change :timeend, :string
    end
  end
 
  def down
    change_table :events do |t|
      t.change :date, :string
	  t.change :timestart, :string
	  t.change :timeend, :string
    end
  end
  end
end
