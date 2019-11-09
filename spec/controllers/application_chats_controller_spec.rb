require 'rails_helper'

RSpec.describe Api::V1::ApplicationChatsController, type: :controller do

  let(:application) { create(:application) }
  let(:chat) { create(:chat, application: application, number: 1) }
  describe "GET #index" do
    context 'when fetching all chats' do
        before do
          application
          chat
          get :index, params: { token: application.token }
        end
        it 'returns success' do
          expect(response).to(be_successful)
        end
    end
  end

  describe 'GET #show' do
    context 'when chat is found' do
        before do
          chat
          get :show, params: { token: application.token, number: 1 }
        end

        it 'returns success' do
          expect(response).to(be_successful)
        end
        it 'returns the correct chat' do
          expect(json[:chat][:number]).to eq(chat.number)
        end
      end
  end


end
