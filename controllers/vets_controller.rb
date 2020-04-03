require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/pet')
require_relative('../models/vet')
also_reload('../models/*')


get '/vets' do
  @vets = Vet.find_all()
  erb(:"vets/index")
end

get '/vets/new' do
  erb(:"vets/new")
end


get '/vets/:id' do
  id = params['id']
  @vet = Vet.find(id)
  @pets = @vet.pets()
  erb(:"vets/show")
end
