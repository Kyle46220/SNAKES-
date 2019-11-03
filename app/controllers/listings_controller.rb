class ListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_listing, only:[ :show]
  before_action :set_user_listing, only: [:edit, :update, :destroy]

  def new
    @listing = Listing.new
  end

  def create
    
    # @listing = Listing.new(listing_params)
    @listing = current_user.listings.new(listing_params)
    if @listing.save
      redirect_to listings_path
    else
      render "new"
    end

  end

  # def create
    

    
  #   #second, create this thing. define the parameters.  
  #   # listing_params = params.require(:listing).permit(:title, :description, :breed_id, :sex, :price, :deposit, :city, :state, :date_of_birth, :diet)
  #   #create instance variable from this
  #   @listing = Listing.new(listing_params)
    
  #   #then save it
  #   @listing.save

  #   #first need a redirect
  #   redirect_to @listing
  # end

  def index
    @listings = Listing.all
  end



  def show
    session = Stripe::Checkout::Session.create(
      payment_method_types: [ 'card' ],
      customer_email: current_user.email,
      line_items: [{
        name: @listing.title,
        description: @listing.description,
        amount: @listing.deposit * 100,
        currency: 'aud',
        quantity: 1
      }],
      payment_intent_data: {
        metadata: {
          user_id: current_user.id,
          listing_id: @listing.id
        }
      },
      success_url: "#{root_url}payments/success?userId=#{current_user.id}&listingId=#{@listing.id}",
      cancel_url: "#{root_url}listings"
    )
    @session_id = session.id

  end

  def edit
  end

  def update 
    # listing_params = params.require(:listing).permit(:title, :description, :breed_id, :sex, :price, :deposit, :city, :state, :date_of_birth, :diet)
    @listing.update(listing_params)
    redirect_to @listing
  end

  def destroy
    @listing.destroy
    redirect_to listings_path
  end







  private

  def set_listing 
    @listing = Listing.find(params[:id])
  end

  def set_user_listing
    id = params[:id]
    @listing = current_user.listings.find_by_id(id)

    if @listing == nil
      redirect_to listings_path
    else
      if @listing.deposit == nil
        @listing.deposit =0
      end
    end
   


  end


  def listing_params
    params.require(:listing).permit(:title,:description, :breed_id, :sex,:price, :date_of_birth, :state, :deposit, :city, :diet, :picture)

  end



end

