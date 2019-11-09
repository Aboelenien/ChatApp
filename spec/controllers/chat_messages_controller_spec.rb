require 'rails_helper'

RSpec.describe Api::V1::ChatMessagesController, type: :controller do
  let(:application) { create(:application) }
  let(:chat) { create(:chat, application: application, number: 1) }
  let(:message) { create(:message, chat: chat, number: 1) }
  describe "GET #index" do
    context 'when fetching all chats' do
        before do
          application
          chat
          message
          get :index, params: { token: application.token, number: chat.number }
        end
        it 'returns success' do
          expect(response).to(be_successful)
        end
    end
  end

  describe 'POST #create' do
    context 'when creating message' do
        before do
          post :create, params: { token: application.token, number: chat.number, message:{message: 'message' }}
        end
        it 'returns success' do
          expect(response).to(be_successful)
        end
        it 'changes database by 1' do
          expect do
            post :create, params: { token: application.token, number: chat.number,message:{message: 'message' }}
          end.to change(Message, :count).by(1)
        end
    end
  end

  describe 'GET #show' do
    context 'when chat is found' do
        before do
          chat
          message
          get :show, params: { token: application.token, number: chat.number, message_number: message.number }
        end

        it 'returns success' do
          expect(response).to(be_successful)
        end
        it 'returns the correct message' do
          expect(json[:message][:number]).to eq(message.number)
        end
      end
  end
end
