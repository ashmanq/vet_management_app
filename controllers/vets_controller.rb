require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/animal')
require_relative('../models/vet')
also_reload('../models/*')

# LIST ALL
get '/vets' do
  @vets = Vet.find_all()
  erb(:"vets/index")
end

# GET NEW
get '/vets/new' do
  erb(:"vets/new")
end

# DELETE
get '/vets/remove/:id' do
  id = params['id'].to_i
  vet = Vet.find(id)
  vet.delete
  redirect '/vets'
end

# EDIT
get '/vets/:id/edit' do
  id = params['id'].to_i
  @vet = Vet.find(id)
  erb(:"vets/edit")
end

# SHOW
get '/vets/:id' do
  id = params['id']
  @vet = Vet.find(id)
  @animals = @vet.animals()
  erb(:"vets/show")
end

get '/vets/appointments/:vet_id' do
  vet_id = params['vet_id'].to_i
  @vet = Vet.find(vet_id)
  @animals = @vet.animals()
  @appointments = @vet.appointments()
  # @treatments = animal.treatments()
  erb(:"vets/appointments")
end

# POST NEW
post '/vets' do
  vet = Vet.new(params)
  vet.save()
  redirect '/vets'
end

# POST UPDATE
post '/vets/:id' do
  vet = Vet.new(params)
  vet.update()
  redirect '/vets'
end
