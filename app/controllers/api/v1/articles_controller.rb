class Api::V1::ArticlesController < Api::V1::ApplicationController
  def index
    articles = Article.all.page(params[:page]).per(params[:per_page])

    render json: articles
  end
end
