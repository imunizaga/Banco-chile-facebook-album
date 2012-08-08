($ "a.comenzar").live 'click', (e) ->
  if typeof _gaq isnt 'undefined'
    e.preventDefault()
    _gaq.push(['_trackEvent', 'Landing Page', 'Sign up', 'El usuario se registra']);
  return true

($ "a.ingresar").click (e) ->
  if typeof _gaq isnt 'undefined'
    e.preventDefault()
    _gaq.push(['_trackEvent', 'Landing Page', 'Sign in', 'El usuario ingresa con su cuenta']);
  return true

# Info
# como jugar
# bases

# Login

# Album
# lamina

# Consigue Laminas
# login twitter


