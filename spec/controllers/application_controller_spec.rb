require 'rails_helper'

RSpec.describe Api::V1::ApplicationsController, type: :controller do
  let(:application) { create(:application) }
  let(:application1) { create(:application) }
  describe "GET #index" do
    context 'when fetching all applications' do
        before do
          application
          application1
          get :index
        end
        it 'returns success' do
          expect(response).to(be_successful)
        end
    end
  end

  describe 'POST #create' do
    context 'when creating app' do
        before do
          post :create, params: { application:{ name: 'app' } }
        end
        it 'returns success' do
          expect(response).to(be_successful)
        end
        it 'changes database by 1' do
          expect do
            post :create, params: { application:{ name: 'second app' } }
          end.to change(Application, :count).by(1)
        end
    end
  end

  describe 'GET #show' do
    context 'when application is found' do
        before do
          application
          get :show, params: { token: application.token }
        end

        it 'returns success' do
          expect(response).to(be_successful)
        end
        it 'returns the correct token' do
          expect(json[:application][:token]).to eq(application.token)
        end
      end

  end
end
