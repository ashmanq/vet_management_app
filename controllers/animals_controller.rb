require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/animal')
require_relative('../models/vet')

also_reload('../models/*')


# LIST ALL
get '/animals' do
  @animals = Animal.find_all()
  erb(:"animals/index")
end

# GET NEW
get '/animals/new' do
  @vets = Vet.find_all()
  erb(:"animals/new")
end

# DELETE
get '/animals/remove/:id' do
  id = params['id'].to_i
  animal = Animal.find(id)
  animal.delete
  redirect '/animals'
end

# EDIT
get '/animals/:id/edit' do
  id = params['id'].to_i
  @animal = Animal.find(id)
  @vets = Vet.find_all()
  erb(:"animals/edit")
end

# SHOW DETAILS
get '/animals/:id' do
  id = params['id']
  @animal = Animal.find(id)
  erb(:"animals/show")
end

# POST NEW
post '/animals' do
  animal = Animal.new(params)
  animal.save()
  redirect '/animals'
end

# POST UPDATE
post '/animals/:id' do
  animal = Animal.new(params)
  animal.update()
  redirect '/animals'
end
