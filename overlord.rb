require 'sinatra'
require 'json'
require 'haml'
require 'rubygems'
require 'rack-flash'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require_relative 'bomb'

class Overlord < Sinatra::Base
  register Sinatra::Flash
  helpers Sinatra::RedirectWithFlash
  enable :sessions
  bomb = Bomb.new

  get '/' do
    haml :index, :locals => {bomb: bomb}
  end

  post '/api/boot' do
    begin
      bomb.boot params
    rescue Bomb::BootError => e
      redirect "/", notice: e.message
    else
      redirect "/"
    end
  end

  post '/api/activate' do
    begin
      bomb.activate params['acode']
    rescue Bomb::ActivateError => e
      redirect "/", notice: e.message
    else
      redirect "/"
    end
  end

  post '/api/deactivate' do
    begin
      bomb.deactivate params['dcode']
    rescue Bomb::DeactivateError => e
      redirect "/", notice: e.message
    else
      redirect "/"
    end
  end
end
