require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/pet')
require_relative('../models/vet')

also_reload('../models/*')



get '/pets' do
  @pets = Pet.find_all()
  erb(:"pets/index")
end

get '/pets/new' do
  @vets = Vet.find_all()
  erb(:"pets/new")
end

get '/pets/:id' do
  id = params['id']
  @pet = Pet.find(id)
  erb(:"pets/show")
end

post '/pets' do
  pet = Pet.new(params)
  pet.save()
  redirect '/pets'
end
