require 'f00px'
require 'faraday'
require 'json'

class PhotoService
  attr_reader :client

  def initialize
    @client = F00px::Client.new
    @client.consumer_key = ENV['FIVEHUNDREDPX_KEY']
  end 

  def get_url_for(id)
    photo(id)["image_url"]
  end

  def photo(id)
    JSON.parse(client.get("photos/#{id}").body)["photo"]
  end

  # def get_url_for(id)
  #   response = client.get("photos/#{id}")
  #   data = JSON.parse(response.body)
  #   data["photo"]["image_url"]
  # end

  def download(id)
    url = get_url_for(id)
    puts "Fetching photo from #{url}..."
    photo = Faraday.get(url).body
    filename = "image_#{id}.jpg"
    output = File.open(filename, "w")
    bytes = output.write(photo)
    puts "Wrote out #{bytes} bytes."
    output.close
    return filename
  end

  def download_and_open(id)
    filename = download(id)
    `open #{filename}`
  end

  def download_and_copy(id)
    filename = download(id)
    `open #{filename}`
  end
end

# require 'faraday'
# require 'json'

# class PhotoService
#   def get_url_for(id)
#     response = Faraday.get("https://api.500px.com/v1/photos/#{id}?consumer_key=#{ENV['FIVEHUNDREDPX_KEY']}")
#     data = JSON.parse(response.body)
#     data["photo"]["image_url"]
#   end

#   def download(id)
#     url = get_url_for(id)
#     puts "Fetching photo from #{url}..."
#     photo = Faraday.get(url).body
#     output = File.open("image_#{id}.jpg", "w")
#     bytes = output.write(photo)
#     puts "Wrote out #{bytes} bytes."
#     output.close
#   end
# end