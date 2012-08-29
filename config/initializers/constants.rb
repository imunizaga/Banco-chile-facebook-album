if Rails.env == 'development' || Rails.env == 'test'
  APP_ID='438204562857972'
  APP_SECRET='73c7a6460975064295113e316e6560c6'
  FB_SITE_URL = 'http://127.0.0.1:3000'
  SITE_URL = 'http://127.0.0.1:3000'
#heroku
elsif true
  APP_ID='127174043311'
  APP_SECRET='0305f7cb7bf84888cc313e9f163ab118'
  SITE_URL = 'http://bancochilealbum.herokuapp.com/'
  FB_SITE_URL = 'http://bancochilealbum.herokuapp.com/'
else
  APP_ID='446490652062870'
  APP_SECRET='bd7f578368ec1f015a4acbfcb85ac7f4'
  SITE_URL = 'http://www.elequipodetodos.cl/'
  FB_SITE_URL = 'http://www.elequipodetodos.cl/'
end

BCHFB_ID='57173152417'
BCHTW_ID='bancoodechile'
BJFB_ID=''
BJTW_ID='bancajoven'

# Twitter OAuth
if false #heroku
  TW_KEY = 'OVhry6VGCZBqhLYXfn6U4g'  # Consumer key
  TW_SECRET = 'n3k9f06TVbwqygfajfpthb4kb0f3tPWKDWS2v2iw'  # Consumer secret
else
  TW_KEY = 'K4SOSyW8pCTqMoamsT4w'  # Consumer key
  TW_SECRET = 'gzZKbTbbFXUqcYtfwSMFkby5ymmE95Nl8iBMI'  # Consumer secret
end
