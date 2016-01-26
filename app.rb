require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
also_reload('./**/*.rb')
require 'pg'
require './lib/dancer'
require './lib/team'
require "pry"

get '/' do
  @teams = Team.all
  @dancers = Dancer.all
  erb :index
end

get '/dancers/:id' do
  id = params[:id].to_i
  @teams = Team.all
  @dancer = Dancer.find(id)
  if @dancer.team
    @team = Team.find(@dancer.team)
  end
  erb :dancer
end

post '/dancers/new' do
  name = params[:dancer_name]
  Dancer.create({name: name})
  redirect '/'
end

patch '/dancers/:id/update' do
  id = params[:id].to_i
  team = params[:team].to_i
  @dancer = Dancer.find(id)
  if !params[:dancer_name].empty?
    name = params[:dancer_name]
  else
    name = @dancer.name
  end
  @dancer.update({name: name, team_id: team})
  redirect "/dancers/#{id}"
end

delete '/dancers/:id/delete' do
  id = params[:id].to_i
  Dancer.delete(id)
  redirect '/'
end

post '/teams/new' do
  name = params[:team_name]
  Team.create({name: name})
  redirect '/'
end

get '/teams/:id' do
  id = params[:id].to_i
  @team = Team.find(id)
  @dancers = @team.dancers()
  erb :team
end

delete '/teams/:id/delete' do
  id = params[:id].to_i
  Team.delete(id)
  redirect '/'
end

patch '/teams/:id/update' do
  Team.find(params[:id].to_i).update({name: params[:team_name]})
  redirect "/teams/#{params[:id].to_i}"
end

patch '/teams/:id/update_coordinator' do
  team = Team.find(params[:id].to_i)
  dancer = Dancer.find(params[:dancer_id].to_i)
  team.update({coordinator: dancer.id})
  dancer.update({coordinator: true})
  redirect "/teams/#{params[:id].to_i}"
end

delete '/teams/:id/remove_coordinator' do
  team = Team.find(params[:id].to_i)
  dancer = Dancer.find(params[:dancer_id].to_i)
  team.update({coordinator: nil})
  dancer.update({coordinator: false})
  redirect "/teams/#{params[:id].to_i}"
end
