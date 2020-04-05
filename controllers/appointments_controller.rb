require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/animal')
require_relative('../models/vet')

also_reload('../models/*')

#SHOW all appointments
get '/appointments' do
  @appointments = Appointment.find_all()
  erb(:"appointments/index")
end

#ADD new appointment
get '/appointments/new' do
  erb(:"appointments/new")
end
