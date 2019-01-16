class UsersController < ApplicationController
  get "/users/:slug" do
    if logged_in?
      user = User.find_by_slug(params[:slug])

      erb :"/users/profile"
    else
      session[:previous_location] = "/users/#{params[:slug]}"

      redirect "/login"
    end
  end

  get "/users/account" do
    if logged_in?
      @user = User.find(session[:user_id])

      erb :"/users/account"
    else
      session[:previous_location] = "/users/account"

      redirect "/login"
    end
  end

  patch "/users" do

  end

  get "/signup" do
    if logged_in?
      redirect "/"
    else
      erb :"/registrations/form"
    end
  end

  post "/users" do
    user = User.create(params)

    session[:user_id] = user.id

    redirect "/"
  end

  get "/login" do
    back = session[:previous_location]
    session[:previous_location] = nil

    if logged_in?
      if back
        redirect "#{back}"
      else
        redirect "/"
      end
    else
      erb :"/sessions/login"
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      redirect "/users/#{user.slug}"
    else
      @message = "Invalid username/password. Please try again!"

      erb :"/sessions/login"
    end
  end

  get "/logout" do
    if logged_in?
      session.clear

      redirect "/"
    else
      redirect "/login"
    end
  end

  helpers do

  end
end
