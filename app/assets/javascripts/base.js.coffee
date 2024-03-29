window.initSocialApps = (app_id) ->
  window.fb_app_id = app_id
  window.fbAsyncInit = ->
    site_url = "#{window.location.protocol}//#{window.location.host}"
    FB.init
      appId: app_id
      channelUrl: "#{site_url}/channel.html" # Channel File
      status: true # check login status
      cookie: true # enable cookies to allow the server to access the session
      xfbml: true # parse XFBML
      frictionlessRequests: true,

    console.log "Getting facebook login status"
    FB.getLoginStatus (response) ->
      console.log "reponse status: " + response.status
      if window.app
        user = window.app.user
        if response.status is "connected"
          unless user.get("login_status") is "connected"
            window.location = "/facebook/login"
          else
            userFacebookId = user.get "facebook_id"
            facebookId = parseInt(response.authResponse.userID)
            if userFacebookId and userFacebookId != facebookId
              window.location = "/facebook/login"
            else
              user.set "facebook_id", facebookId
        else
          user.set "login_status", response.status
          app.navigate('', trigger: true)

    setInterval (->
      FB.api "/me", (response) ->
        if response.name is undefined
          user = window.app.user
          if user.get("login_status") is "connected"
            window.location = "/facebook/login"

    ), 60000

  # Load the SDK Asynchronously
  ((d) ->
    js = undefined
    id = "facebook-jssdk"
    ref = d.getElementsByTagName("script")[0]
    return  if d.getElementById(id)
    js = d.createElement("script")
    js.id = id
    js.async = true
    js.src = "//connect.facebook.net/en_US/all.js"
    ref.parentNode.insertBefore js, ref
  ) document

  # Twitter events
  # First, load the widgets.js file asynchronously
  window.twttr = ((d, s, id) ->
    console.log "In twttr definition"
    t = undefined
    js = undefined
    fjs = d.getElementsByTagName(s)[0]
    return  if d.getElementById(id)
    js = d.createElement(s)
    js.id = id
    js.src = "//platform.twitter.com/widgets.js"
    fjs.parentNode.insertBefore js, fjs
    window.twttr or (t =
      _e: []
      ready: (f) ->
        t._e.push f
    )
  )(document, "script", "twitter-wjs")

  # Wait for the asynchronous resources to load
  twttr.ready (twttr) ->
    console.log("twttr ready!")
