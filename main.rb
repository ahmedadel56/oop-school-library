require_relative 'person'
require_relative 'classroom'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'

class App
  def initialize(books = [], persons = [], rentals = [])
    @books = books
    @persons = persons
    @rentals = rentals
  end

  def list_books
    if @books.length.positive?
      @books.each do |book|
        puts book[:basic_info]
      end
    else
      puts 'No books found'
    end
    show_options
  end

  def list_people
    if @persons.length.positive?
      @persons.each do |person|
        puts person[:basic_info]
      end
    else
      puts 'No people found'
    end
    show_options
  end

  def create_student
    puts('Age: ')
    age = gets.chomp.to_i
    puts('Name: ')
    name = gets.chomp
    puts('Has parent permission? [ Y | N ]')
    parental_permission = gets.chomp
    parental_permission =
      case parental_permission.downcase
      when 'y'
        true
      else
        false
      end
    student = Student.new(age, name, parent_permission: parental_permission)
    @persons.push({ basic_info: "[Student] Name: #{name}, ID: #{student.id} Age: #{age}",
                    object: student })
    puts('Person created successfully!')
    show_options
  end

  def create_teacher
    puts('Age: ')
    age = gets.chomp
    puts('Name: ')
    name = gets.chomp
    puts('Specialization: ')
    specialization = gets.chomp
    teacher = Teacher.new(specialization, age, name)
    @persons.push(
      { basic_info: "[Teacher] Name: #{name}, ID: #{teacher.id} Age: #{age}",
        object: teacher }
    )
    puts('Person created successfully!')
    show_options
  end

  def create_person
    puts 'Do you want to create a student(1) or a teacher(2)? [Input the number]: '
    person_kind = gets.chomp.to_i
    case person_kind
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'invalid information'
      show_options
    end
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    @books.push({ basic_info: "Title: #{title}, Author: #{author}",
                  object: book })
    puts 'Book created successfully'
    show_options
  end

  def add_rental(book, person, date)
    rental = Rental.new(date, @books[book][:object], @persons[person][:object])
    @rentals << rental
  end

  def create_rental
    if @books.length.positive? and @persons.length.positive?
      puts 'Select a book from the following list by number'
      @books.each { |book| puts "#{@books.find_index(book)}) #{book[:basic_info]}" }
      book = gets.chomp.to_i
      puts('Select a person from the following list by number (not id)')
      @persons.each { |person| puts "#{@persons.find_index(person)}) #{person[:basic_info]}" }
      person = gets.chomp.to_i
      puts 'Data'
      date = gets.chomp
      add_rental(book, person, date)
      puts 'Rental created successfully'
    else
      puts 'Invalid data please try again'
    end
    show_options
  end

  def list_rentals
    print 'ID of person: '
    id = gets.chomp.to_i
    puts 'Rintals: '
    if @rentals.length.positive?
      @rentals.each do |rental|
        puts("Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}") if rental.person.id == id
      end
    else
      puts 'No rental found'
    end
    show_options
  end

  def options(option)
    case option
    when 1
      list_books
    when 2
      list_people
    when 3
      create_person
    when 4
      create_book
    when 5
      create_rental
    when 6
      list_rentals
    else
      puts 'invalid choice please try again'
      show_options
    end
  end

  def show_options
    puts 'Please choose an option by enterin a number'
    puts '1 - List all of books '
    puts '2 - List all of people'
    puts '3 - Create a person '
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals fo a given person id'
    puts '7 - Exit'
    order = gets.chomp.to_i
    options(order) if order != 7
  end
end

def main
  puts 'Welcome to School Library App!'

  app = App.new
  app.show_options
  puts('Thank you for using this app!')
end

main
