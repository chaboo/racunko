require 'rails_helper'

RSpec.describe WebhooksController, type: :request do

  describe 'POST #create' do
    let(:message_attributes) do
      load_fixture("messages")
    end

    context 'with proper authentication' do
      let(:env) { valid_auth }
      let(:subject) { post '/webhooks', params: messages["message_card"], env: env }

      context 'with valid attributes' do
        it 'returns 200' do
          subject
          expect(response.status).to eq(200)
        end

        it "creates new message" do
          expect { subject }.to change(Message, :count).by 1
        end
      end
    end

    context 'with invalid authentication' do
      context 'due to invalid username or password' do
        let(:env) { invalid_auth }
        let(:subject) { post '/webhooks', params: messages["message_card"], env: env }

        it 'returns 401' do
          subject
          expect(response.status).to eq(401)
        end
      end

      context 'due to missing authentication information' do
        let(:subject) { post '/webhooks', params: messages["message_card"] }

        it 'returns 401' do
          subject
          expect(response.status).to eq(401)
        end
      end
    end
  end

  def messages
    @messages ||= load_fixture("messages")
  end

  def valid_auth
    env ||= {}
    username = ENV["ADMIN_USERNAME"]
    password = ENV["ADMIN_PASSWORD"]
    env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
    env
  end

  def invalid_auth
    env ||= {}
    username = ENV["ADMIN_USERNAME"]
    password = "incorrect_password"
    env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
    env
  end
end
