class UsersController < ApplicationController
  get "/signup" do
    if logged_in?
      redirect "/"
    else
      erb :"/registrations/form"
    end
  end

  post "/users" do

    username = params[:username]
    email = params[:email]
    password = params[:password]

    @user = User.create(params)

    binding.pry

    redirect "/"
  end

  get "/login" do
    if logged_in?
      redirect "/"
    else
      erb :"/sessions/login"
    end
  end

  helpers do
    def method_name

    end
  end
end
