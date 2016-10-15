# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Profile.destroy_all
TodoList.destroy_all
TodoItem.destroy_all

users = Hash[ "Carly Fiorina" => 1954, "Donald Trump" => 1946, "Ben Carson" => 1951, "Hillary Clinton" => 1947 ]
gender_determiner = Hash[ "Carly" => "female", "Donald" => "male", "Ben" => "male", "Hillary" => "female" ]

users.each do |name, year|
	array = name.split(' ')
	first_name = array[0]
	last_name = array[1]
	password = year.to_s

	user = User.create!( username: last_name, password_digest: password )
	Profile.create!( gender: gender_determiner[first_name], birth_year: year, first_name: first_name, last_name: last_name, user_id: user.id )
	todo_list = TodoList.create!( list_name: "#{last_name}_list", list_due_date: (Date.today + 1.year), user_id: user.id )
	5.times do
		TodoItem.create!( due_date: (Date.today + 1.year), title: "foo_title", description: "foo_description", todo_list_id: todo_list.id )
	end
end
