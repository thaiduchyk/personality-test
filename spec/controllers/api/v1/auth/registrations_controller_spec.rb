require 'rails_helper'

RSpec.describe Api::V1::Auth::RegistrationsController, type: :controller do

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  let(:user_attributes){ FactoryGirl.attributes_for(:user) }

  let(:invalid_attributes){ FactoryGirl.attributes_for(:user_not_valid) }

  context 'with valid parameters' do
    user = FactoryGirl.build(:user)

    it 'signs in user' do
      post :create, user_attributes
      expect(subject.current_user.email).to eq(user.email)
    end

    it 'responds with status 200' do
      post :create, user_attributes
      expect(response.status).to eq(200)
    end

    it 'saves user' do
      expect{ post :create, user_attributes }.to change(User, :count).by(1)
    end

    it 'renders correct json' do
    end
  end

  context 'with invalid parameters' do

    it 'doesnt save user' do
      expect{post :create, invalid_attributes}.to_not change(User, :count)
    end

    it 'responds with status 403' do
      post :create, invalid_attributes
      expect(response.status).to eq(403)
    end

    it 'responds with error message'

  end

  context 'with existing email' do
    before (:each) do
      @user = FactoryGirl.create(:user)
    end

    it 'doesnt save user' do
      expect{post :create, user_attributes}.to_not change(User, :count)
    end

    it 'responds with status 403' do
      post :create, user_attributes
      expect(response.status).to eq(403)
    end
  end


end