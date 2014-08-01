class BraintreeAddressesController < ApplicationController
  before_filter :find_user, :find_customer
  before_filter :find_braintree_address, except: [:new, :create]

  def index
    @braintree_addresses = @customer.braintree_addresses
  end

  def new
    @braintree_address = @customer.braintree_addresses.build(country_code_alpha2: 'US', region: 'California')
  end

  def edit; end

  def show; end

  def create
    @braintree_address = @customer.braintree_addresses.build(params[:braintree_address])
    if @braintree_address.save
      flash[:notice] = "Address has been successfully created."
      redirect_to user_customer_braintree_address_path(@user, @braintree_address)
    else
      flash[:alert] = @braintree_address.errors.full_messages.join(".\n")
      render :new
    end
  end

  def update
    if @braintree_address.update_attributes(params[:braintree_address])
      flash[:notice] = "Address has been successfully updated."
      redirect_to user_customer_braintree_address_path(@user, @braintree_address) and return
    else
      flash[:alert] = @braintree_address.errors.full_messages.join(".\n")
      render :edit
    end
  end

  def destroy
    @braintree_address.destroy
    flash[:notice] = "Address has been successfully deleted."
    redirect_to user_customer_braintree_addresses_path(@user)
  end

  protected
  def find_user
    @user = User.find(params[:user_id])
  end

  def find_customer
    @customer = @user.customer
    redirect_to user_path(@user) and return if @customer.nil?
  end

  def find_braintree_address
    @braintree_address = @braintree_customer.addresses.find(params[:id])
  end
end