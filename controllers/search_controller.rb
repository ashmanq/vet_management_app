require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/search')
require_relative( '../models/owner')
also_reload('../models/*')


get '/search' do
  erb(:"search/index")
end

#POST
post '/search' do
  @query = params['query'].to_s
  @type = params['type'].to_s
  @results = Search.search_by_name(@query, @type)
  erb(:"search/result")
end
