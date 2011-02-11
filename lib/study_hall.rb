class StudyHall < Sinatra::Base
  set :views, File.join(APP_ROOT, "lib", "views")

  # Taken from sinatra faq:
  # http://www.sinatrarb.com/faq.html#auth
  helpers do
    def protected!
      unless authorized?
        response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
        throw(:halt, [401, "Not authorized\n"])
      end
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      
      @auth.provided? && @auth.basic? && @auth.credentials && 
        @auth.credentials == [ADMIN_USER, ADMIN_PASS]
    end
  end

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
      haml :create
    else
      haml :new
    end
  end

  get '/create' do
    redirect '/new'
  end

  get '/admin' do
    protected!

    @registrations = Registration.all
    haml :index
  end

  get '/style.css' do
    sass :style
  end
end
