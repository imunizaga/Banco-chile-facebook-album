FACEBOOK_SCOPE = 'client_credentials'
class AuthController < ApplicationController
  protect_from_forgery
  def facebook
    session[:access_token] = nil
    @auth_url =  authenticator.url_for_oauth_code(:permissions=>params[:permissions])
    if @auth_url['localhost']
      @auth_url['localhost']='127.0.0.1'
    end
    respond_to do |format|
      format.html {  }
    end
    redirect_to @auth_url
  end

  def logout
    session[:access_token] = nil
    session[:id] = nil
    redirect_to '/'
  end

  def facebook_callback
    if params[:code]
      # acknowledge code and get access token from FB :
      session[:access_token] = authenticator.get_access_token(params[:code])
      @api = Koala::Facebook::API.new(session[:access_token])
      @user = @api.get_object("me")
      this_user = User.where(facebook_id:@user['id']).first_or_create(name:@user['name'])
      session[:id] = this_user.id
      end
    respond_to do |format|
      format.html {   }			 
    end

    if session[:return] == nil
      redirect_to '/' and return
    else
      red = session[:return]
      session[:return] = nil
      redirect_to red and return
    end
  end

  def twitter
    oauth = OAuth::Consumer.new(TW_KEY, TW_SECRET, {:site => 'https://twitter.com'})
    url = 'http://127.0.0.1:3000/auth/twitter/callback'  # TODO get dynamic domain
    request_token = oauth.get_request_token(:oauth_callback => url)
    # this values will be used during the callback
    session[:tw_token] = request_token.token
    session[:tw_secret] = request_token.secret

    # redirect to twitter
    redirect_to request_token.authorize_url

  end

  def twitter_callback
    oauth = OAuth::Consumer.new(TW_KEY, TW_SECRET, {:site => 'https://twitter.com'})

    request_token = OAuth::RequestToken.new(oauth, session[:tw_token], session[:tw_secret])
    # TODO this value should be stored on the database
    session[:tw_access_token] = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])

    redirect_to root_url  # TODO return to the calling url
  end

  def twitter_retweet
    oauth = OAuth::Consumer.new(TW_KEY, TW_SECRET, {:site => 'https://twitter.com'})
    
    # Perform action through a post call to the Twitter API
    # See https://dev.twitter.com/docs/api/1/post/statuses/retweet/%3Aid
    response = oauth.request(:post, '/statuses/retweet/213379847861436417.json',
                             session[:tw_access_token], { :scheme => :query_string })
    # The response can be parsed to confirm the retweeted id
    retweet_info = JSON.parse(response.body)
    print "retweet_info: #{retweet_info['retweeted_status']['id_str']}\n"

    redirect_to root_url  # TODO return to the calling url
  end

  def twitter_follow
    oauth = OAuth::Consumer.new(TW_KEY, TW_SECRET, {:site => 'https://twitter.com'})
    
    # Perform action through a post call to the Twitter API
    # See https://dev.twitter.com/docs/api/1/post/friendships/create
    response = oauth.request(:post, '/friendships/create.json',
                             session[:tw_access_token], { :scheme => :query_string },
                             { :user_id => '602411091' })
    # The response can be parsed to confirm the followed account
    follow_info = JSON.parse(response.body)
    print "follow_info: #{follow_info['id']}\n"

    redirect_to root_url  # TODO return to the calling url
  end

  def host
    request.env['HTTP_HOST']
  end

  def scheme
    request.scheme
  end

  def url_no_scheme(path = '')
    "//#{host}#{path}"
  end

  def url(path = '')
    "#{scheme}://#{host}#{path}"
  end

  def authenticator
    @authenticator ||= Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, url("/auth/facebook/callback"))
  end
end
