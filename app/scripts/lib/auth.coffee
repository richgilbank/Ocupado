window.Ocupado.Auth =
  isAuthenticated: false

  handleAuthResult: (authResult) ->
    if authResult and not authResult.error
      # Auth failed
      Ocupado.Auth.isAuthenticated = false
    else
      # Success
      Ocupado.Auth.isAuthenticated = true
      Ocupado.trigger 'ocupado:auth:success'

