require 'blanket'

class Scryfall

  def initialize(cache: true)
    @client = Blanket.wrap("https://api.scryfall.com")
  end

  def bulk_data(type = :default_cards)
    bulk = @client.send("bulk-data")

    dump_id = bulk
                .get
                .data
                .find { |o| o.type == type.to_s }
                .uri
                .split("/")[-1]

    uri = "http://localhost:3000/example/#{bulk.get(dump_id).download_uri.split("/")[-1]}"
      
    Downloader.download(uri)
  end

end
