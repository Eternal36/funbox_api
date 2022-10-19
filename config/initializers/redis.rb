unless Rails.env.test?
  $redis = Redis.new
else
  $redis = MockRedis.new
end
