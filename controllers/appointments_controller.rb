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

#EDIT appointment details
get '/appointments/:id/edit' do
  id = params['id'].to_i
  @appointment = Appointment.find(id)
  erb(:"appointments/edit")
end

#SHOW appointment details
get '/appointments/:id' do
  id = params['id']
  @appointment = Appointment.find(id)
  erb(:"appointments/show")
end

# POST new
post '/appointments/' do
  appointment = Appointment.new(params)
  appointment.save()
  redirect '/appointments'
end

# POST update
post '/appointments/:id' do
  appointment = Appointment.new(params)
  appointment.update
  redirect '/appointments'
end
