require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../models/course.rb')
require_relative('../models/student.rb')
require_relative('../models/bookings.rb')
also_reload('../models/*')

get '/students' do #index
  @students = Student.find_all
  erb(:"students/index_students")
end

get '/students/new' do #new
  erb(:"students/new_students")
end

get '/students/:id' do #show
  @student = Student.find_by_id(params['id'])
  erb(:"students/show_students")
end


post '/students' do #create
  Student.new(params).save
  redirect to '/students'
end

get '/students/:id/edit' do #edit
  @student = Student.find_by_id(params['id'])
  erb(:"students/edit_students")
end

post '/students/:id' do #update
  student = Student.new(params)
  student.update
  redirect to "/students/#{params['id']}"
end

post '/students/:id/delete' do #destroy
  student = Student.find_by_id(params['id'])
  student.delete_student(params['id'])
  redirect to '/students'
end
