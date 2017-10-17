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
      render_model_errors(article)
    end
  end

  def update
    if article.update(article_params)
      render json: article
    else
      render_model_errors(article)
    end
  end

  private

  def article
    @article ||= Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def render_model_errors(model)
    render json: { errors: model.errors }, status: :unprocessable_entity
  end
end
