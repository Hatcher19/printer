class BraintreeCustomersController < InheritedResources::Base
  before_filter :find_user
  before_filter :find_braintree_customer, except: [:new, :create]
  skip_before_filter :trial_expired

  def new
    @braintree_customer = BraintreeRails::Customer.new(email: @user.email, first_name: @user.first_name, last_name: @user.last_name, phone: @user.phone_number)
  end

  def create
    @braintree_customer = BraintreeRails::Customer.new(params[:customer])
    if @braintree_customer.save
      @user.update_attribute(:braintree_customer_id, @braintree_customer.id)
      flash[:notice] = "braintree_Customer has been successfully created."
      redirect_to new_user_braintree_customer_credit_card_path and return
    else
      flash[:alert] = @braintree_customer.errors.full_messages.join(".\n")
      render :new
    end
  end

  def show
    
  end

  def edit; end

  def update
    if @braintree_customer.update_attributes(params[:braintree_customer].merge(params.slice(:device_data)))
      flash[:notice] = "Customer has been successfully updated."
      redirect_to user_braintree_customer_path(@user) and return
    else
      flash[:alert] = @braintree_customer.errors.full_messages.join(".\n")
      render :edit
    end
  end

  def destroy
    @braintree_customer.destroy
    @user.update_attribute(:braintree_customer_id, nil)
    flash[:notice] = "Customer has been successfully deleted."
    redirect_to user_path(@user)
  end

  protected
  def find_user
    @user = User.find(params[:user_id])
  end 

  def find_braintree_customer
    @customer = @user.braintree_customer
  end
end