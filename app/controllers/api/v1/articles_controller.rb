class Api::V1::ArticlesController < Api::V1::ApplicationController
  def index
    articles = Article.order(id: :desc).page(params[:page]).per(params[:per_page])

    render json: articles
  end

  def create
    article = Article.new(article_params)

    if article.save
      render json: article
    else
      render json: { errors: article.errors }, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
