require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/animal')
require_relative('../models/vet')
require_relative('../models/owner')

also_reload('../models/*')


# LIST ALL
get '/animals' do
  @animals = Animal.find_all()
  erb(:"animals/index")
end

# GET NEW
get '/animals/new' do
  @vets = Vet.find_all()
  # We only list all registered owners
  @owners = Owner.find_registered()
  erb(:"animals/new")
end

# ADD new animal to specific owner
get '/animals/new/:customer_id' do
  customer_id = params['customer_id']
  @vets = Vet.find_all()
  # Using same erb file but with only one rowner result
  @owners = Owner.find(customer_id)
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
  @checking = @animal.checking()
  @treatments = @animal.treatments()
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
