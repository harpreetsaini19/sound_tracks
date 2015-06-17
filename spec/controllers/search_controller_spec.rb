require 'rails_helper'

RSpec.describe SearchController, :type => :controller do
  describe SearchController do
    describe 'GET #index' do
      before(:each) do
        @current_user = create(:user)
        sign_in @current_user
      end

      context 'with artist name' do
        it 'creates the search' do
          get :index, search: attributes_for(:search)
          expect(Search.count).to eq(1)
        end

        it 'redirects to the index action' do
          get :index, search: attributes_for(:search)
          expect(response).to render_template(:index)
        end
      end

      context 'without artist name' do
        it 'does not create the search' do
          get :index, search: attributes_for(:search, artist_name: nil)
          expect(Search.count).to eq(0)
        end

        it 'redirects to the index action' do
          get :index, search: attributes_for(:search)
          expect(response).to render_template(:index)
        end
      end
    end
  end
end
