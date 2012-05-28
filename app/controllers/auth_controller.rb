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
    redirect_to '/'
  end

  def facebook_callback
    if params[:code]
      # acknowledge code and get access token from FB :
      session[:access_token] = authenticator.get_access_token(params[:code])
      @api = Koala::Facebook::API.new(session[:access_token])
      @user = @api.get_object("me")
      if  saved_user = User.find_by_facebook_id(@user['id'])
        session[:id] = saved_user.id
      else
        newUser=User.create(name:@user['name'],facebook_id:@user['id'])
        session[:id] = newUser.id
      end
      if session[:return]
        redirect=session[:return]
        session[:return] = nil
        redirect_to redirect and return
      end
    end		
    respond_to do |format|
      format.html {   }			 
    end

    if session['return'] == nil
      redirect_to '/' and return
    else
      red = session['return']
      session['return'] = nil
      redirect_to red and return
    end
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
