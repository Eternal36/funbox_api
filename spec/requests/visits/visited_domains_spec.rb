require 'rails_helper'

RSpec.describe "GET /visits/visited_domains", type: :request do
  context 'when datetime interval valid' do
    before do
      $redis.zadd('visit_links', Time.now.to_i, 'https://yandex.ru/testetset')
      $redis.zadd('visit_links', Time.now.to_i, 'https://google.com/testetset')
    end
    it 'return all uniq domains for datetime interval' do
      get '/visits/visited_domains', params: { datetime_from: 1.minute.ago, datetime_to: Time.now }
      expect(JSON.parse(response.body)['domains']).to contain_exactly('yandex.ru', 'google.com')
      expect(response.status).to eq(200)
    end
  end

  context 'when datetime interval invalid' do
    it 'return error for invalid datetime interval' do
      get '/visits/visited_domains', params: { datetime_from: 'test', datetime_to: 'testtest' }
      expect(response.body).to eq({ error: 'incorrect datetime format' }.to_json)
      expect(response.status).to eq(400)
    end
  end

  context 'when datetime interval empty' do
    it 'return error for empty datetime interval' do
      get '/visits/visited_domains', params: {}
      expect(response.body).to eq({ error: 'no params[:datetime_from] or [:datetime_to]' }.to_json)
      expect(response.status).to eq(400)
    end
  end
end