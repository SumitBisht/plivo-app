require 'sinatra'
require 'plivo'
include Plivo

base_url = 'http://localhost:4567/'
AUTH_ID = "SAZGE1Y2QXNDI5MWFMOW"
AUTH_TOKEN = "SAZGE1Y2QXNDI5MWFMOW"

configure do
	# The Rest API uses the default values for url and version numbers
	set :restAPI, RestAPI.new(AUTH_ID, AUTH_TOKEN)
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
	'call made with following response: '+ response.to_s
end

get '/call' do
	erb :call
end

get '/' do
	redirect '/details'
end

get '/dialxml/' do
	caller_id = ''
	dial_no = ''
	res = Response.new()

	dial = res.addDial({'caller_id' => caller_id})
	d.addNumber(dial_number)
	conent_type 'text/xml'
	res.to_xml()
end

get '/transcribe' do
	erb :transcribe
end

post '/transcribe' do
	record_url = params[:url]
	res = Response.new()

	res.addSpeak(params[:message]) #('Leave the message after the beep')
	res.addRecord( {'action' => record_url, 'maxLength' => 300, 'playBeep' => true} )
	content_type 'text/xml'
	res.to_xml()
end

