require_relative('../db/sqlrunner.rb')
require_relative('./student.rb')

class Course

attr_reader :id, :title, :capacity, :day, :session, :level, :number_of_students

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @capacity = options['capacity'].to_i
    @day = options['day']
    @session = options['session'] if options['session']
    @level = options['level'].to_i if options['level']
    @number_of_students = 0
  end




end
