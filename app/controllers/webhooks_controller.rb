class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    log(params['webhook'])
    render nothing: true, head: :ok
  end

  def log(data)
    Rails.logger.info("request: #{data}")
  end
end