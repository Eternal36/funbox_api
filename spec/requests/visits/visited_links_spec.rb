require 'rails_helper'

RSpec.describe "POST /visits/visited_links", type: :request do
  context 'when links are valid' do
    let(:params) { { links: ['http://yandex.ru', 'https://google.com/q?qwerty'] } }
    it 'write valid array of links to Redis' do
      post '/visits/visited_links', params: params
      expect(response.body).to eq(params.to_json)
      expect(response.status).to eq(200)
    end
  end

  context 'when links are valid' do
    it 'try write invalid array of links to Redis' do
      post '/visits/visited_links', params: { links: ['hp://yandex.ru', 'google.com/q?qwerty'] }
      expect(response.body).to eq({ error: 'one or more links are not valid' }.to_json)
      expect(response.status).to eq(400)
    end
  end

  context 'when there are no links' do
    it 'try write empty array of links to Redis' do
      post '/visits/visited_links', params: {}
      expect(response.body).to eq({ error: 'no params[:links]' }.to_json)
      expect(response.status).to eq(400)
    end
  end
end