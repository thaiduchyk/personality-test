require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :controller do

  before(:each) do
    @questions = Array.new
    @question = FactoryGirl.create(:question).as_json
    @questions.push(@question)
    @question = FactoryGirl.create(:question).as_json
    @questions.push(@question)
  end

  context 'GET#index' do
     it 'returns all questions' do
       get :index
       expect(JSON.parse(response.body)['data']).to eq(@questions)
      end
    it 'responds with status 200' do
      get :index
      expect(response.status).to eq(200)
    end
  end


end
