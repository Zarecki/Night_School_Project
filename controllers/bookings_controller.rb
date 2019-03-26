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
  booking.save
  redirect to '/courses'
end
