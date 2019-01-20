class UsersController < ApplicationController
  get "/users/account" do
    if logged_in?
      # @user = current_user

      erb :"/users/account"
    else
      session[:previous] = "/users/account"

      redirect "/login"
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])

    #CHECK IF IT'S MY SLUG

    if @user
      if logged_in?
        erb :"/users/presets"
      else
        session[:previous] = "/users/#{params[:slug]}"

        redirect "/login"
      end
    else
      #OR SHOW 404

      redirect "/"
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
      @error_type = 1
      @error_message = 1

      pass = false
    elsif User.all.exists?(username: @username)
      @error_type = 1
      @error_message = 2

      pass = false
    elsif @email.length < 5
      @error_type = 2
      @error_message = 3

      pass = false
    elsif !@email.match(/\w+@\w+\.\w{2,}/)
      @error_type = 2
      @error_message = 4

      pass = false
    elsif User.all.exists?(email: @email)
      @error_type = 2
      @error_message = 5

      pass = false
    elsif params[:password].length + params[:password?].length < 12
      @error_type = 3
      @error_message = 6

      pass = false
    elsif params[:password] != params[:password?]
      @error_type = 3
      @error_message = 7

      pass = false
    elsif pass
      params.delete(:password?)

      user = User.create(params)

      session[:user_id] = user.id
    end

    if pass
      redirect "/users/#{user.slug}"

      #ADD WELCOME
    else
      erb :"/registrations/form"
    end
  end

  patch "/users" do
    @username = params[:username]
    @email = params[:email]
    @pass = true

    if @username.length < 3
      @error_type = 1
      @error_message = 1

      @pass = false
    elsif User.all.exists?(username: @username) && current_user.username != @username
      @error_type = 1
      @error_message = 2

      @pass = false
    elsif @email.length < 5
      @error_type = 2
      @error_message = 3

      @pass = false
    elsif !@email.match(/\w+@\w+\.\w{2,}/)
      @error_type = 2
      @error_message = 4

      @pass = false
    elsif User.all.exists?(email: @email) && current_user.email != @email
      @error_type = 2
      @error_message = 5

      @pass = false
    elsif params[:password].length + params[:password?].length < 12
      @error_type = 3
      @error_message = 6

      @pass = false
    elsif params[:password] != params[:password?]
      @error_type = 3
      @error_message = 7

      @pass = false
    elsif @pass
      params.delete(:password?)
      params.delete(:_method)

      current_user.update(params)
    end

    erb :"/users/account"
  end

  get "/login" do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
      @previous = session[:previous]

      erb :"/sessions/login"
    end
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    pass = true

    @username = params[:username]
    @email = params[:email]

    if @username.length < 3
      @error_type = 1
      @error_message = 1

      pass = false
    elsif !User.all.exists?(username: @username)
      @error_type = 1
      @error_message = 2

      pass = false
    elsif params[:password].length < 6
      @error_type = 2
      @error_message = 3

      pass = false
    elsif user && !user.authenticate(params[:password])
      @error_type = 2
      @error_message = 4

      pass = false
    elsif pass && user && user.authenticate(params[:password])
      session[:user_id] = user.id
    end

    if pass
      previous = session[:previous]
      session.delete(:previous)

      if previous
        redirect "#{previous}"
      else
        redirect "/users/#{user.slug}"
      end
    else
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

  delete "/users/:id" do
    if logged_in?
      user = User.find(params[:id])

      if user.id == session[:user_id]
        session.clear

        User.delete(params[:id])

        redirect "/"
      else
        redirect "/login"
      end
    else
      redirect "/login"
    end

    #ADD CONFIRM

  end

  helpers do

  end
end
