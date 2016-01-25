ENV['RACK_ENV'] = 'test'
require 'rspec'
require 'pg'
require 'sinatra/activerecord'

RSpec.configure do |config|
  config.after(:each) do
    Dancer.all().each() do |dancer|
      dancer.destroy()
    end
    Team.all().each() do |team|
      team.destroy()
    end
  end
end
