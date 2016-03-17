require 'rails_helper'

RSpec.describe Api::V1::Overrides::SessionsController, type: :controller do
  include Devise::TestHelpers
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]

  end

  context 'with valid parameters' do
    let(:user_attributes){ FactoryGirl.attributes_for(:user) }

    it 'signs in user' do
       post :create, {email:'', password:''}
      binding.pry
      expect(subject.current_user).to_not eq(nil)
    end

    it 'responds status with status 200' do
       post :create, { email: user_attributes.email ,password: user_attributes.password }
       expect(response.status).to eq(200)
    end

  end
end