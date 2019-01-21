class UsersController < ApplicationController
  get "/users/account" do
    if logged_in?
      @validation = validation_form

      erb :"/users/account"
    else
      session[:previous] = "/users/account"

      redirect "/login"
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])

    if @user
      if logged_in?
        erb :"/users/presets"
      else
        session[:previous] = "/users/#{params[:slug]}"

        redirect "/login"
      end
    else
      #SHOW ERROR
      redirect "/"
    end
  end

  get "/signup" do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
      @validation = validation_form

      erb :"/registrations/form"
    end
  end

  get "/login" do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
      @validation = validation_form

      @previous = session[:previous]

      erb :"/sessions/login"
    end
  end

  post "/login" do
    form = validation_test(params, "login")

    if form[:username][:valid] && form[:password][:valid]
      user = form[:username][:user]

      session[:user_id] = user.id

      if session[:previous]
        previous = session[:previous]

        session.delete(:previous)

        redirect "#{previous}"
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
      session.clear

      redirect "/"
    else
      redirect "/login"
    end
  end

  post "/users" do
    form = validation_test(params, "registration")

    if form[:username][:valid] && form[:password][:valid]
      params.delete(:password?)

      user = User.create(params)

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
      params.delete(:password?)
      params.delete(:_method)

      current_user.update(params)

      redirect "/users/account"
    else
      @validation = form

      erb :"/users/account"
    end
  end

  delete "/users/:id" do
    form = validation_test(params, "delete")

    if form[:password][:valid]
      User.delete(session[:user_id])

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
          user: nil,
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

      form[:username][:value] = params[:username]
      form[:username][:test][:length] = params[:username].length >= 3

      case type
      when "registration", "account"
        form[:password][:test][:length] = params[:password].length + params[:password?].length >= 12

        case type
        when "registration"
          form[:username][:test][:available] = !user_found
          form[:password][:test][:match] = params[:password] == params[:password?]
        when "account"
          form[:username][:test][:available] = !user_found || current_user.username == params[:username]
          form[:password][:test][:match] = params[:password] == params[:password?]
        end
      when "login", "delete"
        form[:password][:test][:length] = params[:password].length >= 6


        case type
        when "login"
          form[:username][:user] = user
          form[:username][:test][:available] = user_found
          form[:password][:test][:match] = user && user.authenticate(params[:password])
        when "delete"
          form[:password][:test][:match] = current_user.authenticate(params[:password])
        end
      end

      form[:username][:valid] = form[:username][:test].values.all?
      form[:password][:valid] = form[:password][:test].values.all?

      form
    end
  end
end
