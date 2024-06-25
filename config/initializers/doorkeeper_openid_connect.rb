# frozen_string_literal: true

Rails.application.config.to_prepare do
  Doorkeeper::OpenidConnect.configure do
    issuer do
      Rails.cache.fetch("#{Config.cache_key_with_version}/external_url", expires_in: 12.hours) do
        Config.external_url || "http://localhost:3000"
      end
    end

    signing_key do 
      Rails.cache.fetch("#{Config.cache_key_with_version}/oidc_signing_key", expires_in: 12.hours) do
        begin
          Config.oidc_key || "A signing key has not been provided"
        rescue
          "A signing key has not been provided"
        end
      end
    end

    subject_types_supported [:public]

    resource_owner_from_access_token do |access_token|
      Member.find(access_token.resource_owner_id)
    end

    auth_time_from_resource_owner do |resource_owner|
      resource_owner.keycode_imprint.coded_at
    end

    # reauthenticate_resource_owner do |resource_owner, return_to|
    # Example implementation:
    # store_location_for resource_owner, return_to
    # sign_out resource_owner
    # redirect_to new_user_session_url
    # end

    # Depending on your configuration, a DoubleRenderError could be raised
    # if render/redirect_to is called at some point before this callback is executed.
    # To avoid the DoubleRenderError, you could add these two lines at the beginning
    #  of this callback: (Reference: https://github.com/rails/rails/issues/25106)
    #   self.response_body = nil
    #   @_response_body = nil
    # select_account_for_resource_owner do |resource_owner, return_to|
    # Example implementation:
    # store_location_for resource_owner, return_to
    # redirect_to account_select_url
    # end

    subject do |resource_owner, application|
      # Example implementation:
      resource_owner.username

      # or if you need pairwise subject identifier, implement like below:
      # Digest::SHA256.hexdigest("#{resource_owner.id}#{URI.parse(application.redirect_uri).host}#{'your_secret_salt'}")
    end

    # Protocol to use when generating URIs for the discovery endpoint,
    # for example if you also use HTTPS in development
    # protocol do
    #   :https
    # end

    # Expiration time on or after which the ID Token MUST NOT be accepted for processing. (default 120 seconds).
    # expiration 600

    # Example claims:
    claims do
      claim :email, scope: :openid do |resource_owner|
        resource_owner.email
      end

      claim :name do |resource_owner|
        resource_owner.name
      end

      claim :preferred_username do |resource_owner|
        resource_owner.username
      end

      claim :email_verified do |resource_owner|
        false
      end

      claim :sub do |resource_owner|
        resource_owner.username
      end
    end
  end
end
