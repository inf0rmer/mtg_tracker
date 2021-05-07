class CardListImportJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Card.upsert_all(
      Scryfall.new.bulk_data(:default_cards).map { |card|
        {
          oracle_id: card[:oracle_id],
          name: card[:name],
          set: card[:set],
          price_usd: card[:prices][:usd],
          price_usd_foil: card[:prices][:usd_foil],
          price_eur: card[:prices][:eur],
          price_eur_foil: card[:prices][:eur_foil],
          price_tix: card[:prices][:tix],
          created_at: Time.zone.now,
          updated_at: Time.zone.now,
        }
    }, unique_by: [:oracle_id])
  end
end
