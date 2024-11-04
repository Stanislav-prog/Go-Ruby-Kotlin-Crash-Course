require 'minitest/autorun'
require 'minitest/reporters'
require_relative 'lesson-2-homework'

Minitest::Reporters.use! Minitest::Reporters::HtmlReporter.new(
  reports_dir: 'Ruby Lesson 2 Homework/test/Unit_reports',
)

class StudentUnitTest < Minitest::Test
  def setup
     Student.class_variable_set(:@@students, [])
  end

  def test_parsing
     assert_raises(ArgumentError, "The date should be in the past") do
        Student.new('Kuznetsov', 'Stanislav', '2100-10-02')
     end
  end

  def test_checking_student
     Student.add_student('Kovalenko', 'Vladislav', '2006-06-04')
     assert_raises(ArgumentError, 'This student already exists') do
        Student.add_student('Kovalenko', 'Vladislav', '2006-06-04')
     end
  end

  def test_age_calculation
     student = Student.new('Mykytenko', 'Igor', '2005-10-26')
     expected_age = ((Date.today - Date.new(2005, 10, 26)).to_i / 365.25).floor
     assert_equal expected_age, student.calculate_age
  end

  def test_adding_student
     student = Student.add_student("Kuznetsov", "Stanislav", "2005-10-02")
     assert_includes Student.all_students, student
  end

  def test_removing_student
     student = Student.add_student("Kovalenko", "Vladislav", "2006-06-04")
     Student.remove_student("Kovalenko", "Vladislav", "2006-06-04")
     refute_includes Student.all_students, student
  end

  def test_getting_by_age
     student1 = Student.add_student("Kovalenko", "Vladislav", "2006-06-04")
     student2 = Student.add_student("Mykytenko", "Igor", "2006-10-26")
     result = Student.get_students_by_age(student1.calculate_age)
     assert_includes result, student1
     assert_includes result, student2
  end

  def test_getting_by_name
     student1 = Student.add_student("Kuznetsov", "Stanislav", "2005-10-02")
     student2 = Student.add_student("Shpak", "Stanislav", "2005-10-07")
     result = Student.get_students_by_name("Stanislav")
     assert_includes result, student1
     assert_includes result, student2
  end
end