provider "signalfx" {
  # uncomment if you do not set the token from `SFX_AUTH_TOKEN` env var
  #auth_token = local.sfx_token
  # replace `eu0` by your SignalFx realm
  api_url = "https://api.eu0.signalfx.com"
}

