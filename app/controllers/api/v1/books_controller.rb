class Api::V1::BooksController < ApplicationController
  respond_to :json

  def found_by_isbn
    isbn = "9788387463472"
    link_to_open = "https://www.worldcat.org/isbn/" + isbn
    page = Nokogiri::HTML(open(link_to_open))
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
    book.title = page.css('.title').text

    #ISBN details
    book.isbn = isbn

    #Image details
    book.image = page.css('#cover').css('img').attr('src').to_s.gsub('//', '')

    #Description details
    book.description = page.css('#summary').text

    #Page count details
    page_description = page.css('#details-description').css("td").text
    page_counts_split =  page_description.to_s.split(',')
    if /^(?<num>\d+)$/ =~ page_counts_split[0]
      book.page_count = num.to_i # => 123
    end

    respond_with book
  end
end
