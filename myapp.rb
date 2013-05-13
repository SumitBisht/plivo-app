require 'sinatra'
require 'plivo'

base_url = ''
AUTH_ID = ""
AUTH_TOKEN = ""

configure do
	# The Rest API uses the default values for url and version numbers
	set :restAPI, Plivo::RestAPI.new(AUTH_ID, AUTH_TOKEN)
end

get '/details' do
	@details = ""
	 settings.restAPI.methods.each do |setting|
	 	@details += setting.to_s + '<br />'
	 end

	 erb :details
end

#get '/authorize' do

post '/call/' do
	to_num = params[:to]
	from_no = params[:from]
	answer = params[:answer_url]

	api_obj = settings.restAPI
	call_params = {'to' => to_num, 'from' => from_no, 'answer' => answer, 'answer_method' => 'GET'}
	response = api_obj.make_call(call_params)
	'call made'
end

get '/call' do
	erb :call
end

get '/*' do
	redirect '/details'
end