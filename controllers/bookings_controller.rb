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
  if (course.course_pop >= course.capacity)
    redirect to '/courses/full'
  elsif (course.gender_requirement == "nil") && (course.age_requirement == 0)
    booking.save
    redirect to '/courses'
  elsif (student.gender == course.gender_requirement) && (student.age >= course.age_requirement)
    booking.save
    redirect to '/courses'
  elsif (student.gender == course.gender_requirement) && (course.age_requirement == 0)
    booking.save
    redirect to '/courses'
  elsif (student.age >= course.age_requirement) && (course.gender_requirement == "nil")
    booking.save
    redirect to '/courses'
  else
    redirect to '/courses/error'
  end
end

get '/bookings/delete' do
  @students = Student.find_all
  @courses = Course.find_all
  erb(:"bookings/delete_bookings")
end

post '/bookings/deleted' do
  booking = Booking.new(params)
  p booking
  booking.delete_booking
  redirect to '/courses'
end
