require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/animal')
require_relative('../models/vet')
require_relative('../models/owner')
also_reload('../models/*')

# LIST ALL
get '/owners' do
  @owners = Owner.find_all()
  erb(:"owners/index")
end

# GET NEW
get '/owners/new' do
  erb(:"owners/new")
end

# DELETE
get '/owners/remove/:id' do
  id = params['id'].to_i
  owner = Owner.find(id)
  owner.delete
  redirect '/owners'
end

# EDIT
get '/owners/:id/edit' do
  id = params['id'].to_i
  @owner = Owner.find(id)
  erb(:"owners/edit")
end

# SHOW
get '/owners/:id' do
  id = params['id']
  @owner = Owner.find(id)
  @animals = @owner.animals()
  erb(:"owners/show")
end

# POST NEW
post '/owners' do
  owner = Owner.new(params)
  owner.save()
  redirect '/owners'
end

# POST UPDATE
post '/owners/:id' do
  owner = Owner.new(params)
  owner.update()
  redirect '/owners'
end
