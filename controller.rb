require('sinatra')
require('sinatra/contrib/all')
require_relative('./models/course.rb')
require_relative('./models/student.rb')
also_reload('./models/*')

get '/students' do #index
  @students = Student.find_all
  erb(:index)
end

get '/students/:id' do #show
  @student = Student.find_by_id(params['id'])
  erb(:show)
end

get '/students/new' do #new
  erb(:new)
end

post '/sudents' do #create
  Student.new(params).save
  redirect to '/students'
end

get '/students:id/edit' do #edit
  @student = Student.find_by_id(params['id'])
  erb(:edit)
end

post '/students/:id' do #update
  student = Student.new(params)
  student.update
  redirect to "/students/#{params['id']}"
end

post '/students/:id/delete' do #destroy
  student = Student.find(params['id'])
  student.delete_student
  redirect to '/students'
end 
