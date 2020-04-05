require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/animal')
require_relative('../models/vet')

also_reload('../models/*')

# SHOW all appointments
get '/appointments' do
  @appointments = Appointment.find_all()
  erb(:"appointments/index")
end

# # SHOW all appointments for specific vet
# get '/appointments/vet/:vet_id' do
#   @appointments = Appointment.find_all()
#   erb(:"appointments/index")
# end

# ADD new for specific vet
get '/appointments/:vet_id/new' do
  vet_id = params['vet_id'].to_i
  @vet = Vet.find(vet_id)
  @animals = @vet.animals()
  # @treatments = animal.treatments()
  erb(:"appointments/new")
end

# ADD new appointment
get '/appointments/new' do
  @vets = Vet.find_all()
  erb(:"appointments/new")
end


#EDIT appointment details
get '/appointments/:id/edit' do
  id = params['id'].to_i
  @appointment = Appointment.find(id)
  erb(:"appointments/edit")
end

#DELETE appointment
get '/appointments/remove/:id' do
  id = params['id']
  appointment = Appointment.find(id)
  appointment.delete()
  redirect "/vets/appointments/#{appointment.vet_id}"
end

#SHOW appointment details
get '/appointments/:id' do
  id = params['id']
  @appointment = Appointment.find(id)
  erb(:"appointments/show")
end

# POST new
post '/appointments' do
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
