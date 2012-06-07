get '/' do
    File.read File.join settings.public_folder, 'index.html'
end

get '/:id!' do
    id = params[:id]
    mustacho "stats.tpl", {:uurl => id, :base_url => settings.base_url}
end

get '/:id' do
    id = params[:id]
    id = id.base62_decode
    url_data = UURL.first :id => id
    halt 404 if url_data.nil?
    c = url_data.clicks
    url_data.update :clicks => c + 1
    url_data.save
    redirect url_data.url
end

get '/s/:id' do
    jc = params[:jsoncallback]
    id = params[:id]
    id = id.base62_decode
    url_data = UURL.first :id => id
    halt 404 if url_data.nil?
    if not jc.nil? 
        "#{jc}(#{url_data.to_json})"
    else 
        url_data.to_json
    end

end

post '/url' do
    url = params[:url]
    url = 'http://'+ url if not url.start_with?('http://') and not url.start_with?('https://')

    halt 401 if url.start_with? settings.base_url

    url_data  = UURL.first :url => url
    return url_data.to_json if not url_data.nil?

    counter = COUNTER.new
    counter.save

    u = UURL.create :id => counter.uuid, :url => url, :e_url=> counter.uuid.base62_encode, :created_at => Time.now.ctime, :clicks => 0, :base_url => settings.base_url
    u.save
    
    u.to_json
end

