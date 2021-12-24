require_relative 'person'
require_relative 'book'
class Rental
  attr_accessor :date
  attr_reader :person, :book

  def initialize(date, book, person)
    @date = date
    @person = person
    @book = book
    person.rentals.push(self)
    book.rentals.push(self)
  end
end

Book_1 = Book.new('Game of thrones', 'Denis')
Book_2 = Book.new("you don't know javascript", 'Mohamaaa mahrooooos')

Person_1 = Person.new(18, 'Zain')
Person_2 = Person.new(22, 'Z3ter')

Rental_1 = Rental.new('30-10-2008', Book_1, Person_1)
Rental_2 = Rental.new('20-05-2020', Book_2, Person_2)

p Rental_1
p Rental_2
