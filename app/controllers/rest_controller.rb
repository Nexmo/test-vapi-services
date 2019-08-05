require 'json'
require 'byebug'

class RestController < ApplicationController
  skip_before_action :verify_authenticity_token

  @@conversation_uuid = ''

  def index
  end
  
  def answer
    render json:
    [
      {
        'action': 'talk',
        'text': 'Please wait while we connect you'
      },
      # named conversation
      # {
      #   'action': 'conversation',
      #   'name': 'rest-conversation'
      # },
      # ephemeral conversation, keeping it open
      {
        'action': 'stream',
        'streamUrl': ['http://chimetunes.nexmodev.com/silence.mp3'],
        'loop': 0
      }
    ]
  end

  def record
    params[:record] == 'start' ? recording_call(@@conversation_uuid, 'start') : recording_call(@@conversation_uuid, 'stop')
    head :no_content
  end

  def event
    # capture the new conversation UUID after the transfer or the original UUID if there is no transfer
    @@conversation_uuid = params[:conversation_uuid_to] ? params[:conversation_uuid_to] : params[:conversation_uuid]
    puts params
    head :no_content
  end

  private

  def recording_call(conv_uuid, action) 
    require 'net/https'
    require 'json'

    claims = {
      application_id: Rails.application.credentials.nexmo[:application_id]
    }
    private_key = File.read(Rails.application.credentials.nexmo[:private_key])
    token = Nexmo::JWT.generate(claims, private_key)
    begin
        puts "THIS IS THE CONVERSATION ID: #{@@conversation_uuid}"
        uri = URI("https://api-us.nexmo.com/v1/conversations/#{conv_uuid}/record")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        req = Net::HTTP::Put.new(uri.path, {
          'Content-Type' =>'application/json',  
          'Authorization' => "Bearer #{token}"
        })
        req.body = {
          'action' => action,
          'eventUrl' => 'http://bengreenberg.ngrok.io/webhooks/event',
          'eventMethod' => 'POST',
          'split' => 'conversation',
          'format' => 'wav'
        }.to_json
        res = http.request(req)
        res.code == '204' ? return_msg = "Successful HTTP Status #{res.code}" : return_msg = "Response #{res.code}: #{res.body}" 
        puts return_msg
        puts JSON.parse(res.body) unless res.code == '204'
    rescue => e
        puts "failed #{e}"
    end
  end
end
