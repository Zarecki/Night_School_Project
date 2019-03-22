require_relative('../db/sqlrunner.rb')

class Student

  attr_reader :id, :first_name, :last_name, :age, :ability, :gender, :course_id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @first_name = options['first_name']
  @last_name = options['last_name']
  @age = options['age'].to_i
  @ability = options['ability'].to_i if options['ability']
  @gender = options['gender'].to_i if options['gender']
  @course_id = options['course_id'].to_i if options['course_id']
end

def save
  sql = 'INSERT INTO students(first_name, last_name, age)
        VALUES ($1, $2, $3)
        Returning *'
  values = [@first_name, @last_name, @age]
  student = SqlRunner.run(sql, values)
  @id = student.first['id']
end

def self.find_all
  sql = 'SELECT * FROM students'
  student_hash = SqlRunner.run(sql)
  student = student_hash.map { |student| Student.new(student) }
end

def self.find_by_id(id)
  sql = 'SELECT * FROM students
        WHERE id = $1'
  values = [id]
  student = SqlRunner.run(sql, values)
  result = Student.new(student.first)
end






end
