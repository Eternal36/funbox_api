require 'rails_helper'

describe Visits::VisitLinksRedis, type: :service do
  let(:links) { ['http://yandex.ru/test', 'http://google.com/testtest', 'http://yandex.ru'] }
  it 'set value from array to Redis' do
    expect(Visits::VisitLinksRedis.set(links, Time.now.to_i)).to eq(links)
  end

  it 'get uniq domains from Redis' do
    expect(Visits::VisitLinksRedis.get_uniq_domains(1.minute.ago.to_i, Time.now.to_i)).to contain_exactly('yandex.ru', 'google.com')
  end
end