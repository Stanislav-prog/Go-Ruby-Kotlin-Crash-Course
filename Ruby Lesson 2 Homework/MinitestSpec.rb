require 'minitest/spec'
require 'minitest/reporters'
require_relative 'lesson-2-homework'

Minitest::Reporters.use! Minitest::Reporters::HtmlReporter.new(
  reports_dir: 'test/Spec_reports',
)

class StudentSpecTest < Minitest::Spec
  before(:each) do
     Student.class_variable_set(:@@students, [])
  end

  describe "#test-parsing" do
     it "raises an error if the date is in the past" do
        expect { Student.new('Kuznetsov', 'Stanislav', '2100-10-02') }.must_raise ArgumentError
     end
  end

  describe "#test-checking-student" do 
     it "raises an error if the student already exists" do
        Student.add_student('Kovalenko', 'Vladislav', '2006-06-04')
        expect { Student.add_student('Kovalenko', 'Vladislav', '2006-06-04') }.must_raise ArgumentError
     end
  end

  describe "#test-age-calculation" do 
     it "checks whether actual student's age is equal to expected student's age" do 
        student = Student.new('Mykytenko', 'Igor', '2005-10-26')
        expected_age = ((Date.today - Date.new(2005, 10, 26)).to_i / 365.25).floor
        expect(student.calculate_age).must_equal expected_age
     end
  end

  describe "#test-adding-student" do 
     it "checks whether a student was really added" do 
        student = Student.add_student("Kuznetsov", "Stanislav", "2005-10-02")
        expect(Student.all_students).include? student
     end
  end

  describe "#test-removing-student" do 
     it "checks whether a student was really removed" do
        student = Student.add_student("Kovalenko", "Vladislav", "2006-06-04")
        Student.remove_student("Kovalenko", "Vladislav", "2006-06-04")
        expect(Student.all_students).include? student
     end
  end

  describe "#test-getting-by-age" do 
     it "checks whether fetching students by age goes well" do 
        @@students = []
        student1 = Student.add_student("Kovalenko", "Vladislav", "2006-06-04")
        student2 = Student.add_student("Mykytenko", "Igor", "2006-10-26")
        result = Student.get_students_by_age(student1.calculate_age)
        expect(result).include? @@students
     end
  end

  describe "#test-getting-by-name" do 
     it "checks whether fetching students by name goes well" do
        @@students = []
        student1 = Student.add_student("Kuznetsov", "Stanislav", "2005-10-02")
        student2 = Student.add_student("Shpak", "Stanislav", "2005-10-07")
        result = Student.get_students_by_name("Stanislav")
        expect(result).include? @@students
     end
  end
end

