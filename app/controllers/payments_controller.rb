class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]
  def success

  end

  def webhook
    payment_id = params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_id)

    listing_id = payment.metadata.listing_id
    user_id = payment.metadata.user_id
    p "listing ID = " + listing_id
    p "user ID = " + user_id
    status 200
  end


end