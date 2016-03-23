class Api::V1::Auth::OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController

  attr_reader :auth_params
  skip_before_action :set_user_by_token
  skip_after_action :update_auth_header

  def omniauth_success

    get_resource_from_auth_hash
    create_token_info
    set_token_on_resource
    create_auth_params

    if resource_class.devise_modules.include?(:confirmable)
      # don't send confirmation email!!!
      @resource.skip_confirmation!
    end

    sign_in(:user, @resource, store: false, bypass: false)

    @resource.skip_password_validation = true
    @resource.save!

    yield if block_given?
    binding.pry
    render_data_or_redirect('deliverCredentials', @auth_params.as_json, @resource.as_json)
  end

  protected

  # break out provider attribute assignment for easy method extension
  def assign_provider_attrs(user, auth_hash)

    if auth_hash['provider'] == 'facebook'

      user.assign_attributes({
                                 name:     auth_hash['info']['name'].split(' ')[0],
                                 surname:     auth_hash['info']['name'].split(' ')[1],
                                 email:    auth_hash['info']['email']
                             })
    else

      user.assign_attributes({
                               name:     auth_hash['info']['first_name'],
                               surname:     auth_hash['info']['last_name'],
                               email:    auth_hash['info']['email']
                           })
    end
  end

  def get_resource_from_auth_hash
    # find or create user by provider and provider uid
    @resource = resource_class.where({
                                         email:      auth_hash['info']['email'],
                                       }).first_or_initialize

    if @resource.new_record?
      @oauth_registration = true
      set_random_password
    end

    # sync user info with provider, update/generate auth token
    assign_provider_attrs(@resource, auth_hash)

    # assign any additional (whitelisted) attributes
    extra_params = whitelisted_params
    @resource.assign_attributes(extra_params) if extra_params

    @resource
  end

end
