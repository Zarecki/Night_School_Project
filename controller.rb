require('sinatra')
require('sinatra/contrib/all')
require_relative('./models/course.rb')
require_relative('./models/student.rb')
also_reload('./models/*')

get '/students' do #index
  @students = Student.find_all
  erb(:index_students)
end

get '/students/new' do #new
  erb(:new_students)
end

get '/students/:id' do #show
  @student = Student.find_by_id(params['id'])
  erb(:show_students)
end


post '/students' do #create
  Student.new(params).save
  redirect to '/students'
end

get '/students/:id/edit' do #edit
  @student = Student.find_by_id(params['id'])
  erb(:edit_students)
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

get '/courses' do #index
  @course = Course.find_all
  erb(:index_courses)
end

get '/courses/new' do #new
  erb(:new_courses)
end

get '/courses/:id' do #show
  @course = Course.find_by_id(params['id'])
  erb(:show_courses)
end

post '/courses' do #create
  Course.new(params).save
  redirect to '/courses'
end

get '/courses/:id/edit' do #edit
  @course = Course.find_by_id(params['id'])
  erb(:edit_courses)
end

post '/courses/:id' do #update
  course = Course.new(params)
  course.update
  redirect to "/courses/#{params['id']}"
end

post '/courses/:id/delete' do #destroy
  course = Course.find_by_id(params['id'])
  course.delete_course
  redirect to '/courses'
end
