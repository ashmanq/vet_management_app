require('sinatra')
require('sinatra/contrib/all')
require_relative('controllers/animals_controller')
require_relative('controllers/vets_controller')
require_relative('controllers/owners_controller')
require_relative('controllers/checkings_controller')
require_relative('controllers/treatments_controller')
require_relative('controllers/appointments_controller')
require_relative('controllers/search_controller')
also_reload('./models/*')


get '/' do
    erb(:index)
end

get '/sitemap' do
  redirect '/sitemap.xml'
end
