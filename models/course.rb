require_relative('../db/sqlrunner.rb')
require_relative('./student.rb')
require('pry')

class Course

attr_reader :id, :title, :capacity, :day, :session, :level, :course_type

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @capacity = options['capacity'].to_i
    @day = options['day'].downcase
    @session = options['session'] if options['session']
    @level = options['level'].to_i if options['level']
    @course_type = options['course_type'] if options['course_type']
  end

  def save
    sql = 'INSERT INTO courses(title, capacity, day)
          VALUES ($1, $2, $3)
          Returning *'
    values = [@title, @capacity, @day]
    course = SqlRunner.run(sql, values)
    @id = course.first['id']
  end

  def self.find_all
    sql = 'SELECT * FROM courses'
    course_hash = SqlRunner.run(sql)
    course = Course.mapping
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
          SET(title, capacity, day)
          = ($1, $2, $3)
          WHERE id - $4'
    values = [@title, @capacity, @day, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_course(id)
    sql = 'DELETE FROM courses
          WHERE id = $1'
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = 'DELETE FROM courses'
    SqlRunner.run(sql)
  end

  # def list_students_by_course
  #   sql = 'SELECT *
  #         FROM bookings
  #         WHERE course_id = $1'
  #   values = [@id]
  #   id_hash = SqlRunner.run(sql, values)
  #     id_hash.each do |id|
  #       return id['student_id'].to_i
  #     end
  #   student_id = id[student]
  #   sql = 'SELECT * FROM students
  #         WHERE id = $1'
  #   values = [student_id]
  #   student_hash = SqlRunner.run(sql, values)
  #   student = Student.mapping
  #   return student
  # end

#   def list_students_by_course
#     sql = 'SELECT *
#           FROM bookings
#           WHERE course_id = $1'
#     values = [@id]
#     id_hash = SqlRunner.run(sql, values)
#     for
#       id in id_hash
#       result = id['student_id']
#       student = list_student_by_id(result)
#     end
#     return student
#   end
#
# def list_student_by_id(id)
#   sql = 'SELECT * FROM students
#         WHERE id = $1'
#   values = [id]
#   student_hash = SqlRunner.run(sql, values)
#   student = Student.new(student_hash)
#   return student
#   binding.pry
# end


def list_students_by_course
  sql = 'SELECT *
        FROM students
        RIGHT JOIN bookings
        ON students.id = bookings.student_id
        WHERE bookings.course_id = $1'
  values = [@id]
  student_hash = SqlRunner.run(sql, values)
  student = student_hash.map { |student| Student.new(student) }
  p student
end

  def self.mapping
    return course_hash.map { |course| Course.new(course) }
  end


end
