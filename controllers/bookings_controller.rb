require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../models/course.rb')
require_relative('../models/student.rb')
require_relative('../models/bookings.rb')
also_reload('../models/*')

get '/bookings/new' do
  @students = Student.find_all
  @courses = Course.find_all

  erb(:"bookings/new_bookings")
end

post '/bookings' do
  booking = Booking.new(params)
  student = Student.find_by_id(params['student_id'])
  course = Course.find_by_id(params['course_id'])
  p course
  if course.gender_requirement == ""
    booking.save
    redirect to '/courses'
  elsif student.gender == course.gender_requirement
    booking.save
    redirect to '/courses'
  else
    redirect to '/courses/error'
  end
end

# post '/bookings' do
#   booking = Booking.new(params)
#   booking.save
#   redirect to '/courses'
# end
