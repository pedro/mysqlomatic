class HerokuController < DatabasesController
  before_filter :authenticate_heroku

  protected
    def authenticate_heroku
      authenticate_or_request_with_http_basic do |user, password|
        user == 'heroku' && password == '46c0e8c38cdf72f4'
      end
    end
end
