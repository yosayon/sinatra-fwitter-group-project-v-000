class UsersController < ApplicationController
 
 get '/users/:slug' do
  @user = User.find_by_slug(params[:slug])
  erb :'users/show'
 end
 
 get '/' do
  erb :'/index'
 end
 
 get '/signup' do
  if logged_in?
   redirect to '/tweets'
  else
   erb :'/users/signup'
  end
 end
 
  post '/signup' do 
   if params[:username].empty? || params[:email].empty? || params[:password].empty?
     redirect to '/signup'
   else
    @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    session[:user_id] = @user.id
    redirect to '/tweets'
   end
  end
 
   get '/login' do
  if logged_in?
   redirect '/tweets'
  else
   erb :'/users/login'
  end
 end
 
 post '/login' do
  @user = User.find_by(:username => params[:username])
  if @user && @user.authenticate(params[:password])
   session[:user_id] = @user.id
   redirect to '/tweets'
  else
   redirect to '/login'
  end
 end
 
 get '/logout' do
  if logged_in?
   session.clear
   redirect '/login'
  else
   redirect '/'
  end
 end

 
 
end