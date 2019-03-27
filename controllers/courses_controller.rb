require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../models/course.rb')
require_relative('../models/student.rb')
require_relative('../models/bookings.rb')
also_reload('../models/*')

get '/courses/error' do
  erb(:"courses/error")
end

get '/courses' do #index
  @courses = Course.find_all
  erb(:"courses/index_courses")
end

get '/courses/new' do #new
  erb(:"courses/new_courses")
end


get '/courses/full' do #full
  return "full :D"
  # erb(:"courses/new_courses")
end

get '/courses/:id' do #show
  @course = Course.find_by_id(params['id'])
  erb(:"courses/show_courses")
end

post '/courses' do #create
  Course.new(params).save
  redirect to '/courses'
end

get '/courses/:id/edit' do #edit
  @course = Course.find_by_id(params['id'])
  erb(:"courses/edit_courses")
end

post '/courses/:id' do #update
  course = Course.new(params)
  course.update
  redirect to "/courses/#{params['id']}"
end

get '/courses/:id/studentlist' do
  @students = Course.list_students_by_course(params['id'])
  erb(:"courses/studentlist_courses")
end

post '/courses/:id/delete' do #destroy
  course = Course.find_by_id(params['id'])
  course.delete_course
  redirect to '/courses'
end
