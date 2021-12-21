require_relative 'corrector'

class Person
  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @correct_instance = Corrector.new
  end
  attr_reader :id
  attr_accessor :name, :age

  def can_use_services?
    of_age? || @parent_permission
  end

  def validate_name
    @name = @correct_instance.correct_name(@name)
  end

  private

  def of_age?
    age >= 18
  end
end
