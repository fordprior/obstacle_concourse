# This is the generic spec test that is part of the base Docker image stored in Docker Hub
#   It's generic insofar as no specific tests are written against its functionality
#   The exception to this is a basic check for a 500 from the server, featured below
#   All new services should configure this test spec to pass

require 'rspec'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

require './app/app'

RSpec.describe "The ObstacleConcourse application" do
  include Rack::Test::Methods

  def app
    ObstacleConcourse
  end

  describe 'a generic test for all my apps' do
    it "doesn't return 500" do
      get '/'
      expect(last_response).to be_ok
    end
  end

end
