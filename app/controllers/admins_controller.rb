class AdminsController < ApplicationController
  def new
    @admin = Admin.new
  end

  def index
    @customers = User.all
  end

  def create
     email = params[:admin][:email]
     password = params[:admin][:password]
     u = User.new(:email => email, :password => password, :password_confirmation => password)
     u.save
     redirect_to customers_url
  end

  def friend
  end

  def destroy
    User.find(params[:id]).destroy
    respond_to do |format|
      flash[:success] = 'User was successfully destroyed.'
      format.html { redirect_to customers_url }
      format.json { head :no_content }
    end
  end
end
