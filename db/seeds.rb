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

reserved = BorrowHistoryState.create(state: 0) unless BorrowHistoryState.reserved.first
borrowed = BorrowHistoryState.create(state: 1) unless BorrowHistoryState.borrowed.first
returned = BorrowHistoryState.create(state: 2) unless BorrowHistoryState.returned.first
demolished = BorrowHistoryState.create(state: 3) unless BorrowHistoryState.demolished.first

if !reserved.present?
  reserved = BorrowHistoryState.reserved.first
end
if !borrowed.present?
  borrowed = BorrowHistoryState.borrowed.first
end
if !returned.present?
  returned = BorrowHistoryState.returned.first
end
if !demolished.present?
  demolished = BorrowHistoryState.demolished.first
end

borrow_history_states_parameters = [
    { translation: "Reserved", country: "EN" , borrow_history_state_id: reserved.id},
    { translation: "Borrowed", country: "EN", borrow_history_state_id: borrowed.id },
    { translation: "Returned", country: "EN",borrow_history_state_id: returned.id },
    { translation: "Destroyed", country: "EN",borrow_history_state_id: demolished.id },
    { translation: "Zarezerwowana", country: "PL", borrow_history_state_id: reserved.id },
    { translation: "Pożyczona", country: "PL", borrow_history_state_id: borrowed.id },
    { translation: "Zwrócona", country: "PL", borrow_history_state_id: returned.id },
    { translation: "Zniszczona", country: "PL", borrow_history_state_id: demolished.id }
]

borrow_history_states_parameters.each do |parameters|
  BorrowHistoryStateTran.create(parameters) unless BorrowHistoryStateTran.where(parameters).first
end
