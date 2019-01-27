class UsersController < ApplicationController

  get "/users/account" do
    log_in_if_logged_out("/users/account")

    @message = session[:message]

    session.delete(:message)

    erb :"/users/account"
  end

  get "/users/:slug" do
    user = User.find_by_slug(params[:slug])

    if user
      log_in_if_logged_out("/users/#{params[:slug]}")

      @presets = user.presets

      erb :"/users/presets"
    else
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

  get "/login" do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
      @message = session[:message]

      session.delete(:message)

      erb :"/sessions/login"
    end
  end

  get "/logout" do
    if logged_in?
      session.clear

      session[:message] = "Logged out successfully."
    end

    redirect "/login"
  end

  post "/login" do
    @user = User.find_by(username: params[:username])

    if @user
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id

        referrer = session[:referrer]

        if referrer
          session.delete(:referrer)

          redirect "#{referrer}"
        else
          redirect "/users/#{@user.slug}"
        end
      else
        @user.generate_errors(params[:password].length)

        erb :"/sessions/login"
      end
    else
      @user_error = "Username does not exist"

      erb :"/sessions/login"
    end
  end

  post "/users" do
    @user = User.create(params)

    if @user.valid?
      session[:user_id] = @user.id

      redirect "/users/#{@user.slug}"
    else
      erb :"/registrations/form"
    end
  end

  patch "/users/account" do
    user = current_user

    last_username = user.username

    user.update(params.except(:_method))

    if user.valid?
      if last_username == params[:username] && params[:password].empty?
        session[:message] = "No changes made."
      else
        session[:message] = "Successfully updated account."
      end

      redirect "/users/account"
    else
      @errors = user.errors

      erb :"/users/account"
    end

  end

  delete "/users/account" do
    user = current_user

    if user.authenticate(params[:password_del])
      user.destroy

      session.clear

      redirect "/"
    else
      @delete_errors = user.generate_errors(params[:password_del].length)

      erb :"/users/account"
    end
  end
end
