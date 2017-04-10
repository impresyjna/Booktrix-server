class Api::V1::BooksController < ApplicationController
  respond_to :json

  def found_by_isbn
    page = Nokogiri::HTML(open("https://www.worldcat.org/isbn/9780451196712"))
    book = Book.new

    #Publisher details
    publisher = page.css('#bib-publisher-cell').text
    publisher_to_save = publisher.to_s.split(', ')
    publisher_details = publisher_to_save[0].to_s.split(' : ')
    book.publisher = publisher_details[1]
    book.publish_date = publisher_to_save[1].to_s.gsub(/\./mi, '')
    book.publisher_city = publisher_details[0]

    #Author details
    authors = page.css('#bib-author-cell').css("a")
    book.author = ""
    authors.each{|author| book.author = book.author + author + ";"}

    #Title details

    #ISBN details

    #Image details

    #Description details

    #Page count details

    puts page.css('#bib-publisher-cell').text
    respond_with book
  end
end
