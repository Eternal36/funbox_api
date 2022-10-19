module Visits
  class VisitLinksRedis
    KEY = 'visit_links'

    class << self
      def set(array_links, datetime)
        array_links.each{ |link| $redis.zadd(KEY, datetime, link) }
      end

      def get_uniq_domains(datetime_from, datetime_to)
        links = get_links(datetime_from, datetime_to)
        links.map{ |link| URI.parse(link).host }.uniq
      end

      private

      def get_links(datetime_from, datetime_to)
        $redis.zrangebyscore(KEY, datetime_from, datetime_to)
      end
    end
  end
end
