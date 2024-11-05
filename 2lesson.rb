require 'minitest/autorun'

require_relative '1lesson'  # Убедитесь, что этот путь правильный

class StudentTest < Minitest::Test
  def setup
    Student.class_variable_set(:@@students, [])
    @student1 = Student.new('Fedorenko', 'Yelyzaveta', "2004-09-12")
    @student2 = Student.new('Surname', 'Yelyzaveta', "2004-09-12")
  end

  def teardown
    Student.class_variable_set(:@@students, [])
  end

  def test_for_invalid_date
    assert_raises(ArgumentError) do
      Student.new('Some', 'Thing', '3000-01-01') # Дата в майбутньому
    end
  end

  def test_add_duplicate_student
    assert_equal 2, Student.all_students.size # Всього має бути 2 студенти спочатку
    Student.new('Fedorenko', 'Yelyzaveta', "2004-09-12") # Дублікат не додасться
    assert_equal 2, Student.all_students.size # Перевіряємо, що студенти не дублюються
  end

  def test_get_by_name
    result = Student.get_students_by_name('Yelyzaveta')
    assert_equal [@student1, @student2], result
  end

  def test_remove_student
    @student1.remove_student
    @student2.remove_student
    assert_equal [], Student.get_students_by_name('Yelyzaveta')
  end

  def test_get_by_age
    result = Student.get_students_by_age(20) # Вік студентів залежить від поточної дати
    assert_includes result, @student1
    assert_includes result, @student2
  end

  def test_calculate_age
    assert_equal 20, @student1.calculate_age # Тест може залежати від поточної дати
  end

  def test_initialize
    student = Student.new("Will", "William", "2004-07-07")
    assert_equal "Will", student.surname
    assert_equal "William", student.name
    assert_equal Date.parse("2004-07-07"), student.date_of_birth
    assert_equal 20, student.calculate_age # Тест може залежати від поточної дати
  end
end


