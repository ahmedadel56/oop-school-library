require_relative 'person'
require_relative 'book'
class Rental
  attr_accessor :date, :person, :book

  def initialize(date, book, person)
    @date = date
    @person = person
    @book = book
    person.rentals.push(self)
    book.rentals.push(self)
  end
end
