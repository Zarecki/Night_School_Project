require_relative('../db/sqlrunner.rb')
require_relative('./student.rb')
require('pry')

class Course

attr_reader :id, :title, :capacity, :day, :gender_requirement, :age_requirement
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @capacity = options['capacity'].to_i
    @day = options['day']
    @gender_requirement = options['gender_requirement']
    @age_requirement = options['age_requirement'].to_i
  end

  def save
    sql = 'INSERT INTO courses(title, capacity, day, gender_requirement, age_requirement)
          VALUES ($1, $2, $3, $4, $5)
          Returning *'
    values = [@title, @capacity, @day, @gender_requirement, @age_requirement]
    course = SqlRunner.run(sql, values)
    @id = course.first['id']
  end

  def self.find_all
    sql = 'SELECT * FROM courses'
    course_hash = SqlRunner.run(sql)
    course = course_hash.map { |course| Course.new(course) }
    return course
  end

  def self.find_by_id(id)
    sql = 'SELECT * FROM courses
          WHERE id = $1'
    values = [id]
    course = SqlRunner.run(sql, values)
    result = Course.new(course.first)
  end

  def update
    sql = 'UPDATE courses
          SET(title, capacity, day, gender_requirement, age_requirement)
          = ($1, $2, $3, $4, $5)
          WHERE id = $6'
    values = [@title, @capacity, @day, @gender_requirement, @age_requirement, @id]
    SqlRunner.run(sql, values)
  end

  def delete_course
    sql = 'DELETE FROM courses
          WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = 'DELETE FROM courses'
    SqlRunner.run(sql)
  end

def self.list_students_by_course(id)
  sql = 'SELECT students.*
        FROM students
        RIGHT JOIN bookings
        ON students.id = bookings.student_id
        WHERE bookings.course_id = $1'
  values = [id]
  student_hash = SqlRunner.run(sql, values)
  student = student_hash.map { |student| Student.new(student) }
  return student
end

def course_pop
  sql = 'SELECT COUNT(*)
        FROM bookings
        WHERE course_id = $1'
  values = [@id]
  result = SqlRunner.run(sql, values).first
  p result
  return result['count'].to_i
end

end
