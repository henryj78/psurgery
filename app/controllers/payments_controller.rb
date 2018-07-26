class PaymentsController < ApplicationController
  def index
    @payments = Payment.all
  end

  def new
    @payment = Payment.new
  end

  def create
    db = Payment.new
    db.custid = session[:current_user_id]
    db.payment_amount = payment_params[:payment_amount]
    db.save
    redirect_to customers_url
  end

  def add_payment
    @payment = Payment.new
    session[:current_user_id] = params[:payment_id].to_i
  end

  def retrieve_pay
    @custid = params[:payment_id].to_i
    customer = Customer.find(@custid)
    @customers_name = customer.first_name + " " + customer.last_name
    @payments = Payment.where( custid: @custid)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def payment_params
    params.require(:payment).permit(:custid, :payment_amount)
  end
end
