class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)
    respond_to do |format|
      if @customer.save
        flash[:success] = 'Customer was successfully created.'
        format.html { redirect_to @customer }
        format.json { render :show, status: :created, location: @customer }
      else
        flash[:danger] = 'There was a problem creating the customer.'
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        flash[:success] = 'Customer was successfully updated.'
        format.html { redirect_to @customer }
        format.json { render :show, status: :ok, location: @customer }
      else
        flash[:danger] = 'There was a problem updating the customer.'
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      flash[:success] = 'Customer was successfully destroyed.'
      format.html { redirect_to customers_url }
      format.json { head :no_content }
    end
  end

  def customer_county
    customer = Customer.find(params[:customer_id].to_i)
    @customers_name = customer.first_name + " " + customer.last_name
    @customers = Zone.where( customer_id: params[:customer_id].to_i)
  end

  def add_county
   @customer = Customer.new
  end

  def update_county
    Customer.write_addtional_zone(params)
    redirect_to customers_url
  end

  def customer_device
   customer = Customer.find(params[:customer_id].to_i)
   @customers_name = customer.first_name + " " + customer.last_name
   @customers = customer.devices
  end

  def customer_build
    Customer.retrieve_zone_id(@customer)
  end

  def validate
   #Customer.write_track_record(current_user)
   Customer.write_customer_validation(params)
   redirect_to customers_url
  end

  def deactivate
   @customer = Customer.find_by_id(params[:customer_id].to_i)
  end


  def deativate_note
   Customer.deativate_customer(params)
   Customer.remove_customer_zone(params)
   redirect_to customers_url
  end

  def remove_zone_id
    Customer.removecusid(params)
    redirect_to customers_url
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :address, :city, :state, :zip, :cell_number, :office_number, :description, :customer_url, :boardcertified, :status_id, :zone_id, :state_id, :sale_id, :validate_cus, :deactivate)
    end
end
