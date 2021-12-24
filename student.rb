require_relative 'person'
require_relative 'classroom'

class Student < Person
  attr_accessor :classroom

  def initialize(age, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = ''
  end

  def play_hooky
    "¯\(ツ)/¯"
  end

  def add_classroom(classroom)
    @classroom = classroom.label
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end

Student_1 = Student.new(15, 'Ahmed')
Classroom_1 = Classroom.new('Math')
Classroom_1.add_student(Student_1)

p Classroom_1
