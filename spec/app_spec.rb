require 'rspec'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

require '../app/app'

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