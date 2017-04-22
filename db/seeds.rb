# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


want_to_read = BookListState.create(state: 0) unless BookListState.want_to_read.first
reading = BookListState.create(state: 1) unless BookListState.reading.first
read = BookListState.create(state: 2) unless BookListState.read.first

if !want_to_read.present?
  want_to_read = BookListState.want_to_read.first
end
if !reading.present?
  reading = BookListState.reading.first
end
if !read.present?
  read = BookListState.read.first
end

book_list_states_parameteres = [
    { translation: "Want to read", country: "EN" , book_list_state_id: want_to_read.id},
    { translation: "Reading", country: "EN", book_list_state_id: reading.id },
    { translation: "Read", country: "EN",book_list_state_id: read.id },
    { translation: "Chcę przeczytać", country: "PL", book_list_state_id: want_to_read.id },
    { translation: "Czytam", country: "PL", book_list_state_id: reading.id },
    { translation: "Przeczytane", country: "PL", book_list_state_id: read.id }
]

book_list_states_parameteres.each do |parameters|
  BookListStateTranslation.create(parameters) unless BookListStateTranslation.where(parameters).first
end