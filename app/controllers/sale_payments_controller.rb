class SalePaymentsController < ApplicationController
  def index
    paymentid = params[:format].to_i
    @salepayment_name = Sale.find(paymentid).full_name
    @salepayment = SalePayment.where(sale_id: paymentid)
    session[:sale_user_id] = paymentid
  end

  def new
    @sale_payment = SalePayment.new
  end

  def create
    db = SalePayment.new
    db.sale_id = session[:sale_user_id]
    db.payment_amount = sale_payment_params[:payment_amount]
    db.description = sale_payment_params[:description]
    db.save
    redirect_to customers_url
  end

  def destroy
  end

  def update
  end

  def edit
  end

  def show
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sale_payment_params
    params.require(:sale_payment).permit(:payment_amount, :description)
  end
end
