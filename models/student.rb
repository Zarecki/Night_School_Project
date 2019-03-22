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


end
