# Be sure to restart your server when you modify this file.

# Cookie SameSite configuration for cross-site widget support
# When COOKIE_SAME_SITE=None, FORCE_SSL must be true
same_site_policy = ENV.fetch('COOKIE_SAME_SITE', 'Lax').downcase.to_sym
secure_cookie = ActiveModel::Type::Boolean.new.cast(ENV.fetch('FORCE_SSL', Rails.env.production?))

Rails.application.config.session_store :cookie_store,
                                       key: '_chatwoot_session',
                                       same_site: same_site_policy,
                                       secure: secure_cookie
