class Api::CardsController < ApplicationController

  CURRENCY_DEFAULT = "eur"

  before_action :validate_params

  def index
    @cards    = Card.all
    @currency = currency_params.fetch(:currency)

    fresh_when last_modified: @cards.maximum(:updated_at), public: true

    respond_to do |format|
      format.json       { render :json => @cards }
      format.prometheus { render :prometheus => @cards }
    end
  end

  private

  ActionController::Parameters.action_on_unpermitted_parameters = :raise

  rescue_from(ActionController::UnpermittedParameters) do |pme|
    render json: { error:  { unknown_parameters: pme.params } }, status: :bad_request
  end

  def validate_params
    currency = Validations::Currency.new(currency_params)

    unless currency.valid?
      render json: { error: currency.errors } and return
    end
  end

  def currency_params
    params.with_defaults(currency: CURRENCY_DEFAULT)
  end

end
