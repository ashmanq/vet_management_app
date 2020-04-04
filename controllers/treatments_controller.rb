require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/animal')
require_relative('../models/vet')
require_relative('../models/treatment')
also_reload('../models/*')

# LIST ALL
get '/treatments' do
  @treatments = Treatment.find_all()
  erb(:"treatments/index")
end

# GET NEW
get '/treatments/new/:animal_id' do
  animal_id = params['animal_id'].to_i
  @animal = Animal.find(animal_id)
  # @treatments = animal.treatments()
  erb(:"treatments/new")
end

# DELETE
get '/treatments/remove/:id' do
  id = params['id'].to_i
  treatment = Treatment.find(id)
  treatment.delete
  animal_id = treatment.animal_id
  redirect "/treatments/animal/#{animal_id}"
end

# SHOW
get '/treatments/animal/:animal_id' do
  id = params['animal_id']
  @animal = Animal.find(id)
  @treatments = @animal.treatments()
  erb(:"treatments/show")
end

#EDIT
get '/treatments/:id/edit' do
  id = params['id'].to_i
  @treatment = Treatment.find(id)
  erb(:"treatments/edit")
end



# POST NEW
post '/treatments' do
  treatment = Treatment.new(params)
  treatment.save()
  animal_id = treatment.animal_id
  redirect "/treatments/animal/#{animal_id}"
end

# POST UPDATE
post '/treatments/:id' do
  treatments = Treatment.new(params)
  treatments.update()
  animal_id = treatments.animal_id
  redirect "/treatments/animal/#{animal_id}"
end
