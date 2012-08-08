($ "a.comenzar").live 'click', (e) ->
  if typeof _gaq isnt 'undefined'
    console.log "'Landing Page', 'Sign up', 'El usuario se registra'"
    console.log _gaq.push(['_trackEvent', 'Landing Page', 'Sign up', 'El usuario se registra']);

($ "a.ingresar").live, 'click' (e) ->
  if typeof _gaq isnt 'undefined'
    console.log "'Landing Page', 'Sign in', 'El usuario ingresa con su cuenta'"
    console.log _gaq.push(['_trackEvent', 'Landing Page', 'Sign in', 'El usuario ingresa con su cuenta']);


# Info
# como jugar
# bases

# Login

# Album
# lamina

# Consigue Laminas
# login twitter


