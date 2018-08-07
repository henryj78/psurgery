class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  after_action :set_customer_payment, only: [:index]
  after_action  :track_create_user, only: [:create ]
  after_action  :track_edit_user, only: [:update ]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all.order({first_name: :asc}, {last_name: :asc})
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    begin
     @salesperson_name = Sale.find(@customer.sale_id.to_i).full_name
     @role_name = Role.find(@customer.status_id.to_i).type_description
     Customer.hold_customer(@customer) if @customer.status_id == 3
   rescue
   end
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
    Customer.remove_zone(@customer)
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
    cusvaild = Customer.write_addtional_zone(params)
    flash[:notice] = 'This county is saved by another customer' if cusvaild == 0

    if cusvaild != 0
     screen = "County Add"
     command = "County Added"
     @customer = Customer.find(cusvaild.to_i)
     Customer.write_track_record(current_user, screen, command, @customer )
     flash[:notice] = 'This county has been saved'
    end

    redirect_to customers_url
  end

  def customer_device
   customer = Customer.find(params[:customer_id].to_i)
   @customers_name = customer.first_name + " " + customer.last_name
   @customers = customer.devices
  end

  def report_status
    @customer = Customer.report_calu
  end

  def customer_build
    Customer.retrieve_zone_id(@customer)
  end

  def validate
    screen = "Customer Validation"
    command = "Validated Customer"

   @customer = Customer.find_by_id(params[:customer_id].to_i)
   Customer.write_track_record(current_user, screen, command, @customer)
   Customer.write_customer_validation(params)
   redirect_to customers_url
  end


  def hold_validate
    screen = "Customer "
    command = "Remove Hold"

    @customer = Customer.find_by_id(params[:customer_id].to_i)
    Customer.write_track_record(current_user, screen, command, @customer)
    Customer.write_customer_validation(params)
    redirect_to customers_url
  end

  def deactivate
   @customer = Customer.find_by_id(params[:customer_id].to_i)
  end


  def deativate_note
   Customer.deativate_customer(params)
   Customer.remove_customer_zone(params)

   screen = "Customer"
   command = "Deativate Customer"
   @customer = Customer.find_by_id(params[:customer_id].to_i)
   Customer.write_track_record(current_user, screen, command, @customer )

   redirect_to customers_url
  end

  def remove_zone_id
     custid = params[:customer_id].to_i
     zone = Zone.find(custid)
     zone_custid = zone.customer_id

     screen = "County Delete"
     command = "County Deleted"
     @customer = Customer.find(zone_custid.to_i)
     Customer.write_track_record(current_user, screen, command, @customer )

     Customer.removecusid(params)
    redirect_to customers_url
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    def set_customer_payment
      @customer = Customer.all
      Customer.payment_inspect(@customer)
    end

    def track_create_user
      screen = "Customer Add New"
      command = "Created Customer"
      Customer.write_track_record(current_user, screen, command, @customer )
    end

    def track_edit_user
      screen = "Customer edit"
      command = "Edit Customer"
      Customer.write_track_record(current_user, screen, command, @customer )
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :address, :city, :state, :zip, :cell_number, :office_number, :description, :customer_url, :boardcertified, :status_id, :zone_id, :state_id, :sale_id, :validate_cus, :deactivate)
    end
end
