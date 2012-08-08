$ ->
  if typeof _gaq isnt 'undefined'
    # Login
    ($ "a.comenzar").click (e) ->
      _gaq.push(['_trackEvent', 'Landing Page', 'Sign up', 'El usuario se registra']);

    ($ "a.ingresar").click (e) ->
      _gaq.push(['_trackEvent', 'Landing Page', 'Sign in', 'El usuario ingresa con su cuenta']);

  # Info
    # como jugar
    # bases

  # Login

  # Album
    # lamina

  # Consigue Laminas
    # login twitter


