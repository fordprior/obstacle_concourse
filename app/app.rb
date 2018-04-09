require 'sinatra'

get '/' do
  'hello world'
end

get '/*/:format?' do
  # matches "GET /hello/reversed" and "GET /goodbye"
  
  case format['format']
    when 'upcase'
      "#{param[0].upcase}"
    when 'reversed'
      "#{param[0].reverse}"
    else
      "#{param[0]}"
  end
  
end
