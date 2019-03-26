require_relative('../db/sqlrunner.rb')

class Booking

attr_reader :id, :student_id, :course_id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @student_id = options['student_id'].to_i
  @course_id = options['course_id'].to_i
end

def save
  sql = 'INSERT INTO BOOKINGS (student_id, course_id)
        VALUES ($1, $2)
        RETURNING id'
  values = [@student_id, @course_id]
  result = SqlRunner.run(sql, values)
  @id = result.first['id'].to_i
end


end
