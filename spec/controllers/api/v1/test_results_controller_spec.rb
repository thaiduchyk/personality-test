require 'rails_helper'

RSpec.describe Api::V1::TestResultsController, type: :controller do

  before(:each) do
    load "#{Rails.root}/db/seeds.rb"
    @user = FactoryGirl.create(:user)
    allow(controller).to receive_messages(:current_user => @user)
    @result_hash = { 1 => {'a': 5, 'b': 7}, 2 => {'a': 5, 'b': 7}, 3 => {'a': 5, 'b': 7}, 4 => {'a': 5, 'b': 7}, 5 => {'a': 5, 'b': 7}, 6 => {'a': 5, 'b': 7}, 7 => {'a': 4, 'b': 7}, 8 => {'a': 5, 'b': 7}, 9 => {'a': 5, 'b': 7}, 10 => {'a': 5, 'b': 7}, 11 => {'a': 5, 'b': 8}, 12 => {'a': 5, 'b': 7}, 13 => {'a': 5, 'b': 7}, 14 => {'a': 5, 'b': 7}, 15 => {'a': 5, 'b': 7}, 16 => {'a': 6, 'b': 7}, 17 => {'a': 5, 'b': 7}, 18 => {'a': 5, 'b': 7}, 19 => {'a': 5, 'b': 7}, 20 => {'a': 5, 'b': 7}, 21 => {'a': 5, 'b': 2}, 22 => {'a': 5, 'b': 7}, 23 => {'a': 7, 'b': 7}, 24 => {'a': 5, 'b': 7}, 25 => {'a': 5, 'b': 7}, 26 => {'a': 5, 'b': 7}, 27 => {'a': 5, 'b': 7}, 28 => {'a': 5, 'b': 7}, 29 => {'a': 5, 'b': 7}, 30 => {'a': 5, 'b': 7}, 31 => {'a': 5, 'b': 7}, 32 => {'a': 5, 'b': 7},33 => {'a': 5, 'b': 7}, 34 => {'a': 9, 'b': 7}, 35 => {'a': 5, 'b': 7}, 36 => {'a': 5, 'b': 7}, 37 => {'a': 5, 'b': 10}, 38 => {'a': 5, 'b': 7}, 39 => {'a': 5, 'b': 7}, 40 => {'a': 14, 'b': 7}, 41 => {'a': 5, 'b': 7}, 42 => {'a': 5, 'b': 7}, 43 => {'a': 5, 'b': 7}, 44 => {'a': 9, 'b': 7}, 45 => {'a': 5, 'b': 7}, 46 => {'a': 5, 'b': 7}, 47 => {'a': 8, 'b': 7}, 48 => {'a': 5, 'b': 8}, 49 => {'a': 5, 'b': 7}, 50 => {'a': 2, 'b': 7}, 51 => {'a': 5, 'b': 7}, 52 => {'a': 5, 'b': 7}, 53 => {'a': 7, 'b': 7}, 54 => {'a': 5, 'b': 7}, 55 => {'a': 5, 'b': 7}, 56 => {'a': 5, 'b': 7}, 57 => {'a': 5, 'b': 7}, 58 => {'a': 1, 'b': 7}, 59 => {'a': 5, 'b': 7}, 60 => {'a': 5, 'b': 10}, 61 => {'a': 5, 'b': 7}, 62 => {'a': 6, 'b': 7}, 63 => {'a': 5, 'b': 7}, 64 => {'a': 5, 'b': 7}, 65 => {'a': 5, 'b': 7}, 66 => {'a': 5, 'b': 7}, 67 => {'a': 5, 'b': 4}, 68 => {'a': 11, 'b': 7}, 69 => {'a': 5, 'b': 7}, 70 => {'a': 3, 'b': 7} }
  end

  describe '#own_result' do

    it 'saves user personalities' do
      expect{ post :own_result, @result_hash }.to change{@user.personalities.count}.by(3)
    end

    it 'responds with status 200' do
      post :own_result, @result_hash
      expect(response.status).to eq(200)
    end

    it 'renders user personalities' do
      post :own_result, @result_hash
      binding.pry
      expect((JSON.parse(response.body))['data'].map { |p| p['name'] }).to eq(@user.personalities.map{ |p| p['name']})
    end

  end
end


#{ "1" : {"a": "5", "b": "7"}, "2" : {"a": "5", "b": "7"}, "3" : {"a": "5", "b": "7"}, "4" : {"a": "5", "b": "7"}, "5" : {"a": "5", "b": "7"}, "6" : {"a": "5", "b": "7"}, "7" : {"a": "5", "b": "7"}, "8" : {"a": "5", "b": "7"}, "9" : {"a": "5", "b": "7"}, "10" : {"a": "5", "b": "7"}, "11" : {"a": "5", "b": "7"}, "12" : {"a": "5", "b": "7"}, "13" : {"a": "5", "b": "7"}, "14" : {"a": "5", "b": "7"}, "15" : {"a": "5", "b": "7"}, "16" : {"a": "5", "b": "7"}, "17" : {"a": "5", "b": "7"}, "18" : {"a": "5", "b": "7"}, "19" : {"a": "5", "b": "7"}, "20" : {"a": "5", "b": "7"}, "21" : {"a": "5", "b": "7"}, "22" : {"a": "5", "b": "7"}, "23" : {"a": "5", "b": "7"}, "24" : {"a": "5", "b": "7"}, "25" : {"a": "5", "b": "7"}, "26" : {"a": "5", "b": "7"}, "27" : {"a": "5", "b": "7"}, "28" : {"a": "5", "b": "7"}, "29" : {"a": "5", "b": "7"}, "30" : {"a": "5", "b": "7"}, "31" : {"a": "5", "b": "7"}, "32" : {"a": "5", "b": "7"}, "33" : {"a": "5", "b": "7"}, "34" : {"a": "5", "b": "7"}, "35" : {"a": "5", "b": "7"}, "36" : {"a": "5", "b": "7"}, "37" : {"a": "5", "b": "7"}, "38" : {"a": "5", "b": "7"}, "39" : {"a": "5", "b": "7"}, "40" : {"a": "5", "b": "7"}, "41" : {"a": "5", "b": "7"}, "42" : {"a": "5", "b": "7"}, "43" : {"a": "5", "b": "7"}, "44" : {"a": "5", "b": "7"}, "45" : {"a": "5", "b": "7"}, "46" : {"a": "5", "b": "7"}, "47" : {"a": "5", "b": "7"}, "48" : {"a": "5", "b": "7"}, "49" : {"a": "5", "b": "7"}, "50" : {"a": "5", "b": "7"}, "51" : {"a": "5", "b": "7"}, "52" : {"a": "5", "b": "7"}, "53" : {"a": "5", "b": "7"}, "54" : {"a": "5", "b": "7"}, "55" : {"a": "5", "b": "7"}, "56" : {"a": "5", "b": "7"}, "57" : {"a": "5", "b": "7"}, "58" : {"a": "5", "b": "7"}, "59" : {"a": "5", "b": "7"}, "60" : {"a": "5", "b": "7"}, "61" : {"a": "5", "b": "7"}, "62" : {"a": "5", "b": "7"}, "63" : {"a": "5", "b": "7"}, "64" : {"a": "5", "b": "7"}, "65" : {"a": "5", "b": "7"}, "66" : {"a": "5", "b": "7"}, "67" : {"a": "5", "b": "7"}, "68" : {"a": "5", "b": "7"}, "69" : {"a": "5", "b": "7"}, "70" : {"a": "5", "b": "7"} }

