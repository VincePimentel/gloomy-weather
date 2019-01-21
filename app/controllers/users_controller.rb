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
      #OR SHOW ERROR
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

  post "/users" do
    form = validation_test(params, "registration")

    #binding.pry

    if form[:username][:valid] && form[:email][:valid] && form[:password][:valid]
      params.delete(:password?)

      user = User.create(params)

      session[:user_id] = user.id

      redirect "/users/#{user.slug}"

      #ADD WELCOME?
    else
      @validation = form

      erb :"/registrations/form"
    end
  end

  patch "/users" do
    form = validation_test(params, "account")

    if form[:username][:valid] && form[:email][:valid] && form[:password][:valid]
      params.delete(:password?)
      params.delete(:_method)

      current_user.update(params)

      redirect "/users/account"
    else
      @validation = form

      erb :"/users/account"
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

  delete "/users/:id" do
    if logged_in?
      #CHECK IF PASSWORD IS CORRECT FIRST

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
        email: {
          value: nil,
          valid: nil,
          test: {
            length: nil,
            format: nil,
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

      email_found = User.all.exists?(email: params[:email])

      form = validation_form

      form[:username][:value] = params[:username]
      form[:username][:test][:length] = params[:username].length >= 3

      case type
      when "registration", "account"
        form[:email][:value] = params[:email]
        form[:email][:test][:length] = params[:email].length >= 6
        form[:email][:test][:format] = !!params[:email].match(/\w+@\w+\.\w{2,}/)
        form[:password][:test][:length] = params[:password].length + params[:password?].length >= 12

        case type
        when "registration"
          form[:username][:test][:available] = !user_found
          form[:email][:test][:available] = !email_found
          form[:password][:test][:match] = params[:password] == params[:password?]
        when "account"
          form[:username][:test][:available] = !user_found || current_user.username == params[:username]
          form[:email][:test][:available] = !email_found || current_user.email == params[:email]
          form[:password][:test][:match] = params[:password] == params[:password?]
        end
      when "login"
        form[:username][:user] = user
        form[:username][:test][:available] = user_found
        form[:password][:test][:length] = params[:password].length >= 6
        form[:password][:test][:match] = user && user.authenticate(params[:password])
      end

      form[:username][:valid] = form[:username][:test].values.all?
      form[:email][:valid] = form[:email][:test].values.all?
      form[:password][:valid] = form[:password][:test].values.all?

      form
    end
  end
end
