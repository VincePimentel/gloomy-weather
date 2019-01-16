class UsersController < ApplicationController
  get "/users/account" do
    if logged_in?
      @user = current_user

      erb :"/users/account"
    else
      session[:previous_location] = "/users/account"

      erb :"/sessions/login"
      #redirect "/login"
    end
  end

  get "/users/:slug" do
    if logged_in?
      @user = User.find_by_slug(params[:slug])

      if @user
        erb :"/users/presets"
      else
        erb :index
      end
    else
      session[:previous_location] = "/users/#{params[:slug]}"
      session[:previous_message] = "To view #{params[:slug]}'s presets, please log in first."

      #erb :"/sessions/login"
      redirect "/login"
    end
  end

  get "/signup" do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
      erb :"/registrations/form"
    end
  end

  post "/users" do
    @username = params[:username]
    @email = params[:email]

    pass = true

    if @username.length < 3
      @username_error = "Username is less than 3 characters. Please try again."
      @username_border = "border-danger"

      pass = false
    elsif User.all.exists?(username: @username)
      @username_error = "Username already taken. Please try a different one!"
      @username_border = "border-danger"

      pass = false
    elsif @email.length < 5
      @email_error = "E-mail address is less than 5 characters. Please try again."
      @email_border = "border-danger"

      pass = false
    elsif !@email.match(/\w+@\w+\.\w{2,}/)
      @email_error = "Wrong e-mail address format. Please try again."
      @email_border = "border-danger"

      pass = false
    elsif User.all.exists?(email: @email)
      @email_error = "E-mail address already in use. Please use a different one."
      @email_border = "border-danger"

      pass = false
    elsif params[:password].length + params[:password?].length < 12
      @password_error = "Password is less than 6 characters. Please try again."
      @password_border = "border-danger"

      pass = false
    elsif params[:password] != params[:password?]
      @password_error = "Passwords do not match. Please try again."
      @password_border = "border-danger"

      pass = false
    elsif pass
      params.delete(:password?)

      user = User.create(params)

      session[:user_id] = user.id
    end

    if pass
      redirect "/users/#{user.slug}"
    else
      erb :"/registrations/form"
    end
  end

  patch "/users" do
    @username = params[:username]
    @email = params[:email]

    pass = true

    if @username.length < 3
      @username_error = "Username is less than 3 characters. Please try again."

      pass = false
    elsif User.all.exists?(username: @username) && current_user.username != @username
      @username_error = "Username already taken. Please try a different one!"

      pass = false
    elsif @email.length < 5
      @email_error = "E-mail address is less than 5 characters. Please try again."

      pass = false
    elsif !@email.match(/\w+@\w+\.\w{2,}/)
      @email_error = "Wrong e-mail address format. Please try again."

      pass = false
    elsif User.all.exists?(email: @email) && current_user.email != @email
      @email_error = "E-mail address already in use. Please use a different one."

      pass = false
    elsif params[:password].length + params[:password?].length < 12
      @password_error = "Password is less than 6 characters. Please try again."

      pass = false
    elsif params[:password] != params[:password?]
      @password_error = "Passwords do not match. Please try again."

      pass = false
    elsif pass
      params.delete(:password?)
      params.delete(:_method)

      current_user.update(params)
    end

    if pass
      redirect "/users/#{current_user.slug}"
    else
      erb :"/users/account"
    end
  end

  get "/login" do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
      @message = session[:previous_message]

      erb :"/sessions/login"
    end
  end

  post "/login" do
    previous = session[:previous_location]

    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:previous_location] = nil

        if previous
          redirect "#{previous}"
        else
          redirect "/users/#{user.slug}"
        end
    else
      @message = "Incorrect username/password. Please try again!"

      erb :"/sessions/login"
    end
  end

  get "/logout" do
    if logged_in?
      session.clear

      redirect "/"
    else
      erb :"/sessions/login"
    end
  end

  helpers do

  end
end
