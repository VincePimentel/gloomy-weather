class UsersController < ApplicationController
  get "/users/account" do
    if logged_in?
      @user = User.find(session[:user_id])

      erb :"/users/account"
    else
      session[:previous_location] = "/users/account"

      redirect "/login"
    end
  end

  get "/users/:slug" do
    if logged_in?
      @user = User.find_by_slug(params[:slug])

      if @user
        erb :"/users/profile"
      else
        redirect "/"
      end
    else
      session[:previous_location] = "/users/#{params[:slug]}"

      redirect "/login"
    end
  end

  patch "/users" do

  end

  get "/signup" do
    if logged_in?
      erb :"/users/profile"
    else
      erb :"/registrations/form"
    end
  end

  post "/users" do
    username = User.all.exists?(username: params[:username])
    email = User.all.exists?(email: params[:email])
    password = params[:password] != params[:password?] || (params[:password].length < 6 || params[:password?].length < 6)

    #CHECK IF THERE ARE ANY ISSUES WITH USER INPUTS
    if username || email || password
      if username
        @user_error = "Username already taken. Please try again!"

        @email = params[:email] unless email
      end

      if email
        @email_error = "E-mail address already in use. Please use a different one."

        @username = params[:username] unless username
      end

      if password
        if params[:password].length + params[:password?].length < 12
          @password_error = "Password is less than 6 characters. Please try again."
        else
          @password_error = "Passwords do not match. Please try again."
        end

        @username = params[:username] unless username
        @email = params[:email] unless email
      end

      erb :"/registrations/form"
    elsif !params.any?{ |key, value| value.empty? }
    #IF NO USER INPUTS ARE EMPTY, DELETE PASSWORD CONFIRMATION KEY-VALUE PAIR AND CREATE USER
      params.delete(:password?)

      @user = User.create(params)

      session[:user_id] = @user.id

      erb :"/users/profile"
    else
      erb :"/registrations/form"
    end
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
