require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/animal')
require_relative('../models/vet')
require_relative('../models/treatment')
also_reload('../models/*')

# LIST ALL
get '/treatments' do
  @treatments = Treatments.find_all()
  erb(:"treatments/index")
end

# GET NEW
get '/treatments/new' do
  erb(:"treatments/new")
end

# DELETE
get '/treatments/remove/:id' do
  id = params['id'].to_i
  treatment = Treatments.find(id)
  treatment.delete
  redirect '/treatments'
end

# SHOW
get '/treatments/animal/:animal_id' do
  id = params['animal_id']
  @animal = Animal.find(id)
  @treatments = @animal.treatments()
  erb(:"treatments/show")
end

# EDIT
# get '/treatments/:id/edit' do
#   id = params['id'].to_i
#   @treatment = Treatment.find(id)
#   erb(:"treatments/edit")
# end



# POST NEW
post '/treatments' do
  treatment = Treatment.new(params)
  treatment.save()
  redirect '/treatments'
end

# POST UPDATE
post '/treatments/:id' do
  treatments = Treatment.new(params)
  treatments.update()
  redirect '/treatments'
end
