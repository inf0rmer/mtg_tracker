module Validations
  class Currency
    include ActiveModel::Validations

    attr_accessor :currency

    validates :currency, presence: true, inclusion: { in: %w(eur usd tix) }

    def initialize(params={})
      @currency = params.fetch(:currency)
    end
  end
end
