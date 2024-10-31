require 'date'

class Student
   @@students = []

   attr_accessor :surname, :name, :date_of_birth

   def initialize(surname, name, date_of_birth)
      @surname = surname
      @name = name
      @date_of_birth = parse_date_of_birth(date_of_birth)
      check_student
   end

   def parse_date_of_birth(date_of_birth)
      parsed_date = Date.parse(date_of_birth)
      raise ArgumentError, 'The date should be in the past' if parsed_date >= Date.today 
      parsed_date
   end

   def check_student
      if @@students.any? { |student| student.name == @name && student.surname == @surname && student.date_of_birth == @date_of_birth }
        raise ArgumentError, "Student with same surname, name and date of birth already exists."
      end
   end

   def calculate_age
      ((Date.today - @date_of_birth).to_i / 365.25).floor
   end

   def self.add_student(surname, name, date_of_birth)
      student = Student.new(surname, name, date_of_birth)
      @@students << student
      student
   end

   def self.remove_student(surname, name, date_of_birth)
      @@students.reject! { |student| student.surname == surname && student.name == name && student.date_of_birth == Date.parse(date_of_birth) }
   end

   def self.all_students
      @@students
   end

   def self.get_students_by_age(age)
      @@students.select { |student| student.calculate_age == age }
   end

   def self.get_students_by_name(name)
      @@students.select { |student| student.name == name }
   end
end

# TEST
begin
   Student.add_student('Kuznetsov', 'Stas', '2005-10-02')
   Student.add_student('Mykytenko', 'Igor', '2005-10-26')
   Student.add_student('Kovalenko', 'Vlad', '2006-06-04')
rescue ArgumentError => e
   puts e.message
end

first_student = Student.all_students.first
puts "#{first_student.surname} #{first_student.name} is #{first_student.calculate_age}"

students_aged_19 = Student.get_students_by_age(19)
students_aged_19.each { |s| puts "#{s.surname} #{s.name} aged 19" }

students_Vlad = Student.get_students_by_name('Vlad')
students_Vlad.each { |s| puts "#{s.surname} #{s.name} named Vlad"}

Student.remove_student('Kuznetsov', 'Stas', '2005-10-02')
puts Student.all_students.map { |s| puts "#{s.surname} #{s.name} is in the list"}
