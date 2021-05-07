require 'httparty'

class Downloader
  class DownloadError < StandardError; end

  def self.download(uri)
    begin
      response = HTTParty.get(uri, format: :plain)
      JSON.parse response, symbolize_names: true
    rescue => e
      raise DownloadError e.message
    end
  end
end