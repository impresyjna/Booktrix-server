# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


reserved = BookListState.create(name: "reserved") unless BookListState.where(name: "reserved").first
borrowed = BookListState.create(name: "borrowed") unless BookListState.where(name: "borrowed").first
returned = BookListState.create(name: "returned") unless BookListState.where(name: "returned").first
destroyed = BookListState.create(name: "destroyed") unless BookListState.where(name: "destroyed").first

book_list_states_parameteres = [
    { name: "Want to read", country: "EN" },
    { name: "Reading", country: "EN" },
    { name: "Read", country: "EN" },
    { name: "Chcę przeczytać", country: "PL" },
    { name: "Czytam", country: "PL" },
    { name: "Przeczytane", country: "PL" }
]

book_list_states_parameteres.each do |parameters|
  BookListStateTranslation.create(parameters) unless BookListStateTranslation.where(parameters).first
end