gem 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/photo_service'
require 'vcr'
require 'webmock'

VCR.configure do |c|
  c.cassette_library_dir = './test/cassettes'
  c.hook_into :webmock
end

class PhotoServiceTest < Minitest::Test
  def test_it_gets_the_image_url_for_a_given_id
    100.times do
      VCR.use_cassette('photo_service_test-get_image_url_given_id') do
        photo_service = PhotoService.new
        id = 55376408
        expected = "http://ppcdn.500px.org/55376408/b534fe0ad2361a34c1194d48817eebe149739a2a/4.jpg"
        result = photo_service.get_url_for(id)
        assert_equal expected, result
      end
    end
  end
end