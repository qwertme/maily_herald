MailyHerald::Engine.routes.draw do
  get ":token",             to: "tokens#get",   as: :token
  get "tokens/:token/open", to: "tokens#open",  as: :token_open, format: :gif
end

MailyHerald::Engine.routes.url_helpers.class.module_eval do
  def maily_unsubscribe_url(subscription, *args)
    options = args.extract_options! || {}
    options = options.reverse_merge(
      {controller: "/maily_herald/tokens", action: "get", token: subscription.token}.
      merge(Rails.application.routes.default_url_options).
      merge(Rails.application.config.action_mailer.default_url_options)
    )

    MailyHerald::Engine.routes.url_helpers.url_for(options)
  end

  def maily_open_url(token, *args)
    options = args.extract_options! || {}
    options = options.reverse_merge(
      {controller: "/maily_herald/tokens", action: "open", token: token, format: "gif"}.
      merge(Rails.application.routes.default_url_options).
      merge(Rails.application.config.action_mailer.default_url_options)
    )

    MailyHerald::Engine.routes.url_helpers.url_for(options)
  end
end
