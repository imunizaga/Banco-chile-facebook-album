if Rails.env == 'development' || Rails.env == 'test'
  APP_ID='438204562857972'
  APP_SECRET='73c7a6460975064295113e316e6560c6'
  SITE_URL = 'http://127.0.0.1:3000'
else
  APP_ID='127174043311'
  APP_SECRET='0305f7cb7bf84888cc313e9f163ab118'
  SITE_URL = 'bancochilealbum.herokuapp.com'
end
