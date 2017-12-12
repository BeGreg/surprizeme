class PaymentsController < ApplicationController
  before_action :set_surprise

  def new
  end

  def create
    customer = Stripe::Customer.create(
    source: params[:stripeToken],
    email:  params[:stripeEmail]
  )

  charge = Stripe::Charge.create(
    customer:     customer.id,   # You should store this customer id and re-use it.
    amount:       @surprise.amount_cents,
    description:  "Payment for #{@surprise.product[:name]} for surprise #{@surprise.id}",
    currency:     @surprise.amount.currency
  )

  @surprise.update(payment: charge.to_json, state: 'paid')
  redirect_to surprise_path(@surprise)

rescue Stripe::CardError => e
  flash[:alert] = e.message
  redirect_to new_surprise_payment_path(@surprise)
  end

private

  def set_surprise
    @surprise = Surprise.where(state: 'pending').find(params[:surprise_id])
  end
end
