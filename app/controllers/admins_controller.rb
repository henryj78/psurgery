class AdminsController < ApplicationController
  def new
    @admin = Admin.new
  end

  def index
  end

  def create
     email = params[:admin][:email]
     password = params[:admin][:password]
     u = User.new(:email => email, :password => password, :password_confirmation => password)
     u.save
     redirect_to customers_url
  end
end
