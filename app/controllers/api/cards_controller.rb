class Api::CardsController < ApplicationController

  def index
    @cards = Card.all

    respond_to do |format|
      format.json       { render :json => @cards }
      format.prometheus { render :prometheus => @cards }
    end
  end

end
