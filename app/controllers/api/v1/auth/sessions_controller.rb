class Api::V1::Auth::SessionsController < DeviseTokenAuth::SessionsController
  #skip_before_filter  :verify_authenticity_token

  swagger_controller :sessions, "User Management"

  swagger_api :create do
    summary "Creates new user"
    param :header, :token, :string, :required, "token to be passed as a header" , :in =>'header'
    param :form, :email, :string, :required, "Email"
    param :form, :password, :string, :required, "Password"
    response :unauthorized
  end

  swagger_api :destroy do
    summary "Deletes an existing User item"
    param :path, :id, :integer, :optional, "User Id"
    response :unauthorized
    response :not_found
  end

  def create

    # Check
    field = (resource_params.keys.map(&:to_sym) & resource_class.authentication_keys).first

    @resource = nil
    if field
      q_value = resource_params[field]

      if resource_class.case_insensitive_keys.include?(field)
        q_value.downcase!
      end

      q = "#{field.to_s} = ? AND provider='email'"

      if ActiveRecord::Base.connection.adapter_name.downcase.starts_with? 'mysql'
        q = "BINARY " + q
      end

      @resource = resource_class.where(q, q_value).first
    end

    if @resource and valid_params?(field, q_value) and @resource.valid_password?(resource_params[:password]) and (!@resource.respond_to?(:active_for_authentication?) or @resource.active_for_authentication?)
      # create client id
      @client_id = SecureRandom.urlsafe_base64(nil, false)
      @token     = SecureRandom.urlsafe_base64(nil, false)

      @resource.tokens[@client_id] = {
          token: BCrypt::Password.create(@token),
          expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
      }

      @resource.skip_password_validation = true
      @resource.save

      sign_in(:user, @resource, store: false, bypass: false)

      yield if block_given?

      #update_auth_header

      render_create_success

    else
      render_create_error_bad_credentials
    end
  end


end
