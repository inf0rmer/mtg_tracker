class Api::CardsController < ApplicationController

  def index
    @cards = Card.all

    fresh_when last_modified: @cards.maximum(:updated_at), public: true

    respond_to do |format|
      format.json       { render :json => @cards }
      format.prometheus { render :prometheus => @cards }
    end
  end

end
