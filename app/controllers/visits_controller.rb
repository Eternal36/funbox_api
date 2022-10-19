class VisitsController < ApplicationController

  def visited_links
    return render json: { error: 'no params[:links]' }, status: :bad_request if params[:links].nil?
    return render json: { error: 'one or more links are not valid' },
                  status: :bad_request unless params[:links].all?{ |link| valid_link?(link) }

    Visits::VisitLinksRedis.set(params[:links], Time.now.to_i)
    render json: { links: params[:links] }, status: :ok
  end

  def visited_domains
    if params[:datetime_from].nil? || params[:datetime_to].nil?
      return render json: { error: 'no params[:datetime_from] or [:datetime_to]' }, status: :bad_request
    end

    datetime_from = Time.parse(params[:datetime_from]).in_time_zone('Moscow').to_i rescue nil
    datetime_to = Time.parse(params[:datetime_to]).in_time_zone('Moscow').to_i rescue nil
    if datetime_from.nil? || datetime_to.nil?
      return render json: { error: 'incorrect datetime format' }, status: :bad_request
    end

    uniq_domains = Visits::VisitLinksRedis.get_uniq_domains(datetime_from, datetime_to)
    render json: { domains: uniq_domains }, status: :ok
  end

  private

  def valid_link?(link)
    uri = URI.parse(link)
    uri.is_a?(URI::HTTP) && uri.host.present?
  end
end
