require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/students_controller')
require_relative('controllers/courses_controller')
require_relative('controllers/bookings_controller')

get '/' do
  erb( :index )
end
