require "test_helper"

class ApiCardsControllerTest < ActionDispatch::IntegrationTest
  fixtures :cards

  def test_prometheus_rendering_defaults_eur
    get "/api/cards.prometheus"
    
    assert_response :success
    assert_match "# HELP card_price_eur The price of cards in EUR", @response.body
    assert_match "# TYPE card_price_eur gauge", @response.body

    assert_match "card_price_eur{oracle_id=\"44623693-51d6-49ad-8cd7-140505caf02f\",set=\"tsp\",collector_number=\"157\"} 1.5", @response.body
    assert_match "card_price_eur{oracle_id=\"8ae3562f-28b7-4462-96ed-be0cf7052ccc\",set=\"zen\",collector_number=\"21\"} 0.5", @response.body
  end

  def test_prometheus_rendering_usd
    get "/api/cards.prometheus?currency=usd"
    
    assert_response :success
    assert_match "# HELP card_price_usd The price of cards in USD", @response.body
    assert_match "# TYPE card_price_usd gauge", @response.body

    assert_match "card_price_usd{oracle_id=\"44623693-51d6-49ad-8cd7-140505caf02f\",set=\"tsp\",collector_number=\"157\"} 3.4", @response.body
    assert_match "card_price_usd{oracle_id=\"8ae3562f-28b7-4462-96ed-be0cf7052ccc\",set=\"zen\",collector_number=\"21\"} 1.4", @response.body
  end

  def test_prometheus_rendering_tix
    get "/api/cards.prometheus?currency=tix"
    
    assert_response :success
    assert_match "# HELP card_price_tix The price of cards in TIX", @response.body
    assert_match "# TYPE card_price_tix gauge", @response.body

    assert_match "card_price_tix{oracle_id=\"44623693-51d6-49ad-8cd7-140505caf02f\",set=\"tsp\",collector_number=\"157\"} 0.5", @response.body
    assert_match "card_price_tix{oracle_id=\"8ae3562f-28b7-4462-96ed-be0cf7052ccc\",set=\"zen\",collector_number=\"21\"} 0.1", @response.body
  end

  def test_caching
    get "/api/cards.prometheus"

    assert @response.headers["Last-Modified"].present?
    assert_equal @response.headers["Cache-Control"], "public"
  end
end
