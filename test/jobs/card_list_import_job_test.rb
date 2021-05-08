require "test_helper"

class CardListImportJobTest < ActiveJob::TestCase
  test "inserts cards returned from Scryfall bulk_data" do
    cards = [
      {
        id: "test-id",
        oracle_id: "test-oracle-id",
        name: "test",
        set: "test",
        collector_number: 1,
        prices: {
          usd: 0.5,
          usd_foil: 1.2,
          eur: 0.2,
          eur_foil: 1,
          tix: 0.1,
        }
      }
    ]

    scryfall = Minitest::Mock.new
    scryfall.expect :bulk_data, cards, [:default_cards]

    Scryfall.stub :new, scryfall do
      CardListImportJob.perform_now

      assert Card.exists?("test-id")
    end
  end

  test "updates cards returned from Scryfall bulk_data" do
    Card.create({
      id: "test-id",
      oracle_id: "test-oracle-id",
      name: "test",
      set: "test",
      collector_number: 1,
      price_usd: 0.5,
      price_usd_foil: 1.2,
      price_eur: 0.2,
      price_eur_foil: 1,
      price_tix: 0.1,
    })

    cards = [
      {
        id: "test-id",
        oracle_id: "test-oracle-id",
        name: "test",
        set: "test",
        collector_number: 1,
        prices: {
          usd: 1.5,
          usd_foil: 2.2,
          eur: 1.2,
          eur_foil: 3,
          tix: 0.3,
        }
      }
    ]

    scryfall = Minitest::Mock.new
    scryfall.expect :bulk_data, cards, [:default_cards]

    Scryfall.stub :new, scryfall do
      CardListImportJob.perform_now

      assert_equal Card.find("test-id").price_eur, 1.2
    end
  end
end
