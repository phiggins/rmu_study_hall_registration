class StudyHall < Sinatra::Base
  set :views, File.join(APP_ROOT, "lib", "views")

  get '/' do
    redirect "/new"
  end

  get '/new' do
    @reg = Registration.new
    haml :new
  end

  post '/create' do
    @reg = Registration.new(params)

    if @reg.save
      haml :success
    else
      haml :new
    end
  end

  get '/style.css' do
    sass :style
  end
end
