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
      @message = "Logged out successfully."

      session.clear

      erb :"sessions/login"
    else
      redirect "/login"
    end
  end

  post "/users" do
    form = validation_test(params, "registration")

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
    form = validation_test(params, "account")

    if form[:username][:valid] && form[:password][:valid]
      if params[:password].length == 0
        current_user.update(params.except(:_method, :password, :password?))
      else
        current_user.update(params.except(:_method, :password?))
      end

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
      when "registration", "account", "login"
        form[:username][:value] = params[:username]
        form[:username][:test][:length] = params[:username].length >= 3
      end

      case type
      when "registration"
        form[:username][:value] = params[:username]
        form[:username][:test][:length] = params[:username].length >= 3
        form[:username][:test][:available] = !user_found

        form[:password][:test][:length] = params[:password].length + params[:password?].length >= 12
        form[:password][:test][:match] = params[:password] == params[:password?]

      when "account"
        form[:username][:value] = params[:username]
        form[:username][:test][:length] = params[:username].length >= 3
        form[:username][:test][:available] = !user_found || current_user.username == params[:username]

        form[:password][:test][:length] = params[:password].length + params[:password?].length == 0 || params[:password].length + params[:password?].length >= 12
        form[:password][:test][:match] = params[:password] == params[:password?]

      when "login"
        form[:username][:value] = params[:username]
        form[:username][:test][:length] = params[:username].length >= 3
        form[:username][:test][:available] = user_found

        form[:password][:test][:length] = params[:password].length >= 6
        form[:password][:test][:match] = user&.authenticate(params[:password])

      when "delete"
        form[:password][:test][:length] = params[:password].length >= 6
        form[:password][:test][:match] = current_user.authenticate(params[:password])
      end

      form[:username][:valid] = form[:username][:test].values.all?
      form[:password][:valid] = form[:password][:test].values.all?

      form
    end
  end
end
