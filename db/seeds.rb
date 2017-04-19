# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
book_list_states_parameteres = [
    { name: "Want to read", country: "EN" },
    { name: "Reading", country: "EN" },
    { name: "Read", country: "EN" },
    { name: "Chcę przeczytać", country: "PL" },
    { name: "Czytam", country: "PL" },
    { name: "Przeczytane", country: "PL" }
]

book_list_states_parameteres.each do |parameters|
  BookListState.create(parameters) unless BookListState.where(parameters).first
end