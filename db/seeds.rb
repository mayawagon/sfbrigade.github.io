# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless Rails.env.test?
  admin = Admin.new
  admin.email = "default@codeforamerica.org"
  admin.password = "12345678"
  admin.password_confirmation = "12345678"
  admin.save
end