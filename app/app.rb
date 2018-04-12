require 'sinatra/base'

class ObstacleConcourse < Sinatra::Base

  get '/' do
    'hello world'
  end

  get '/:text/:format' do
    # matches "GET /hello/reversed" and "GET /goodbye"

    case params['format']
      when 'upcase'
        "#{params['text'].upcase}"
      when 'reversed'
        "#{params['text'].reverse}"
      else
        "#{params['text']}"
    end

  end

end

