require 'sinatra'

get '/' do
  'hello world'
end

get '/*/:format?' do
  # matches "GET /hello/reversed" and "GET /goodbye"
  
  case params['format']
    when 'upcase'
      "#{params[0].upcase}"
    when 'reversed'
      "#{params[0].reverse}"
    else
      "#{params[0]}"
  end
  
end
