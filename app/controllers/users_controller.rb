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

  post "/login" do
    form = validation_test(params, "login")

    if form[:username][:valid] && form[:password][:valid]
      user = User.find_by(username: params[:username])

      session[:user_id] = user.id

      referrer = session[:referrer]

      if referrer
        session.delete(:referrer)

        redirect "#{referrer}"
      else
        redirect "/users/#{user.slug}"
      end
    else
      @validation = form

      erb :"/sessions/login"
    end
  end

  get "/logout" do
    if logged_in?
      flash[:message] = "Logged out successfully."

      @message = "Logged out successfully."

      session.clear

      erb :"sessions/login"
    else
      redirect "/login"
    end
  end

  post "/users" do
    form = validation_test(params, "register")

    if form[:username][:valid] && form[:password][:valid]
      user = User.create(params.except(:password?))

      session[:user_id] = user.id

      redirect "/users/#{user.slug}"

      #ADD WELCOME
    else
      @validation = form

      erb :"/registrations/form"
    end
  end

  patch "/users" do
    form = validation_test(params, "edit")

    if form[:username][:valid] && form[:password][:valid]
      if params[:password].length == 0
        current_user.update(params.except(:_method, :password, :password?))
      else
        current_user.update(params.except(:_method, :password?))
      end

      flash[:message] = "Updated account successfully."

      @message = "Updated account successfully."

      erb :"/users/account"
    else
      @validation = form

      erb :"/users/account"
    end
  end

  delete "/users/:id" do
    form = validation_test(params, "delete")

    if form[:password][:valid]
      User.delete(params[:id])

      session.clear

      redirect "/"
    end
    #ADD CONFIRMATION
  end

  helpers do
    def validation_form
      # Nil values for when views load without any user inputs yet to avoid errors
      # To be filled out when a user submits a form via #validation_test
      # And used to build an invalid feedback to user
      {
        username: {
          value: nil,
          valid: nil,
          test: {
            length: nil,
            available: nil
          }
        },
        password: {
          valid: nil,
          test: {
            length: nil,
            match: nil
          }
        }
      }
    end

    def validation_test(params, type)
      user_found = User.all.exists?(username: params[:username])
      user = User.find_by(username: params[:username])

      form = validation_form

      case type
      when "register", "edit"
        form[:password][:test][:match] = params[:password] == params[:password?]
        # If both passwords match then it is valid

      when "login", "delete"
        form[:password][:test][:length] = params[:password].length >= 6
        # If password is at least 6 characters then it is valid
      end

      case type
      when "register"
        form[:username][:test][:available] = !user_found
        # If username is not found then it is available for use

        form[:password][:test][:length] = params[:password].length + params[:password?].length >= 12
        # If both passwords are at least 6 characters each then it is valid

      when "edit"
        form[:username][:test][:available] = !user_found || current_user.username == params[:username]
        # If username is not found then it is available for use OR username is not current user's username

        form[:password][:test][:length] = params[:password].length + params[:password?].length == 0 || params[:password].length + params[:password?].length >= 12
        # If user has not change their password OR both passwords are at least 6 characters each

      when "login"
        form[:username][:test][:available] = user_found
        # If username exists then it is a valid/registered user

        form[:password][:test][:match] = user&.authenticate(params[:password])
        # If user(name) and password match then it is valid

      when "delete"
        form[:password][:test][:match] = current_user.authenticate(params[:password])
        # If current user enters correct password then it is valid (for account deletion)

      end

      form[:username][:valid] = form[:username][:test].values.all?
      form[:password][:valid] = form[:password][:test].values.all?
      # If all tests return true then proceed with registration/edit/login/delete

      form
      # Return the filled out form (hash) for use on their respective views
    end
  end
end
