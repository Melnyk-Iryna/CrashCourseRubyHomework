require 'date'

class Student
  # Змінна класу для зберігання всіх студентів
  @@students = []

  attr_accessor :surname, :name, :date_of_birth

  # Ініціалізуємо студента з ім'ям, прізвищем та датою народження
  def initialize(surname, name, date_of_birth)
    @surname = surname
    @name = name
    @date_of_birth = Date.parse(date_of_birth)

    # Перевірка, що дата народження у минулому
    if @date_of_birth > Date.today
      raise ArgumentError, 'Дата народження має бути в минулому'
    end

    # Додаємо студента до списку, якщо його ще немає
    add_student
  end

  # Метод для обчислення віку
  def calculate_age
    today = Date.today
    age = today.year - @date_of_birth.year
    # Якщо день народження ще не пройшов цього року, зменшуємо вік на 1
    age -= 1 if today < Date.new(today.year, @date_of_birth.month, @date_of_birth.day)
    age
  end

  # Метод для додавання студента до загального списку
  def add_student
    unless @@students.any? { |student| student.surname == @surname && student.name == @name && student.date_of_birth == @date_of_birth }
      @@students << self
    end
  end

  # Метод для видалення студента зі списку
  def remove_student
    @@students.delete(self)
  end

  # Метод для отримання студентів за віком
  def self.get_students_by_age(age)
    @@students.select { |student| student.calculate_age == age }
  end

  # Метод для отримання студентів за ім'ям
  def self.get_students_by_name(name)
    @@students.select { |student| student.name == name }
  end

  # Метод для отримання всіх студентів
  def self.all_students
    @@students
  end

  # Метод для виведення інформації про всіх студентів
  def self.display_all_students
    if @@students.empty?
      puts "Список студентів порожній"
    else
      @@students.each do |student|
        student.display_student_info
      end
    end
  end

  # Метод для виведення інформації про конкретного студента
  def display_student_info
    puts "Ім'я: #{@name}"
    puts "Прізвище: #{@surname}"
    puts "Дата народження: #{@date_of_birth}"
    puts "Вік: #{calculate_age}"
    puts "-" * 20
  end
end

# Приклад використання:
student1 = Student.new("Коваль", "Андрій", "2000-05-15")
student2 = Student.new("Іваненко", "Марія", "1995-11-23")
student3 = Student.new("Коваль", "Андрій", "2000-05-15") # Цей студент не додасться, бо він дублікат

# Вивести всіх студентів
Student.display_all_students
