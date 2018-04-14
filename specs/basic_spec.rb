require 'rspec'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

require './app/app'

RSpec.describe "The ObstacleConcourse application" do
  include Rack::Test::Methods

  def app
    ObstacleConcourse
  end

  describe 'a specific test case for this app' do

    it "returns the correct reversed phrase" do
      get '/greg/reversed'
      expect(last_response.body).to eq('gerg')
    end

end
