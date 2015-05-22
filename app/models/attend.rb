class Attend < ActiveRecord::Base
	has_one :userid
	has_one :eventid
end
