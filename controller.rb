require('sinatra')
require('sinatra/contrib/all')
require_relative('./models/course.rb')
require_relative('./models/student.rb')
also_reload('./models/*')
