require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/animal')

also_reload('../models/*')


# GET NEW
# Get new for specific animal id
get '/checkings/new/:animal_id' do
  id = params['animal_id']
  @animal = Animal.find(id)
  erb(:"checkings/new")
end


# DELETE
get '/checkings/remove/:id' do
  id = params['id'].to_i
  checking = Checking.find(id)
  checking.delete
  redirect "/animals/#{id}"
end

# EDIT
get '/checkings/:id/edit' do
  id = params['id'].to_i
  @animal = Animal.find(id)
  erb(:"checkings/edit")
end
#
# # SHOW DETAILS
# get '/checkings/:id' do
#   id = params['id']
#   @animal = Animal.find(id)
#   @checking = @animal.checking()
#   erb(:"checkings/show")
# end

# POST NEW
post '/checkings' do
  checking = Checking.new(params)
  checking.save()
  redirect "/animals/#{checking.id}"
end

# POST UPDATE
post '/checkings/:id' do
  checking = Checking.new(params)
  checking.update()
  redirect "/animals/#{checking.id}"
end
