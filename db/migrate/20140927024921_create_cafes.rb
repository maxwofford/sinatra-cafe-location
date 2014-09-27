class CreateCafes < ActiveRecord::Migration
	def self.up
		create_table :cafes do |t|
			t.string :name
			t.timestamps
		end
	end

	def self.down
		drop_table :cafes
	end
end