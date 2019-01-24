class UsersController < ApplicationController

  get "/users/account" do
    if logged_in?
      erb :"/users/account"
    else
      session[:referrer] = "/users/account"

      redirect "/login"
    end
  end

  get "/users/:slug" do
    user = User.find_by_slug(params[:slug])

    if user
      if logged_in?
        @presets = user.presets

        erb :"/users/presets"
      else
        session[:referrer] = "/users/#{params[:slug]}"

        redirect "/login"
      end
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
      erb :"/sessions/login"
    end
  end

  get "/logout" do
    if logged_in?

      @message = "Logged out successfully."

      session.clear

      erb :"sessions/login"
    else
      redirect "/login"
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

  patch "/users" do
    previous_username = current_user.username
    @user = current_user
    @user.update(params.except(:_method))

    if @user.valid?
      if previous_username == params[:username] && params[:password].empty?
        @message = "No changes made."
      else
        @message = "Successfully updated account."
      end
    end

    erb :"/users/account"
  end

  delete "/users" do
    if current_user.authenticate(params[:password_del])
      current_user.destroy

      session.clear

      redirect "/"
    else
      @error = "Password is incorrect. Please try again."

      erb :"/users/account"
    end
  end
end
