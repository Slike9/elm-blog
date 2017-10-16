require 'test_helper'

class Api::V1::ArticlesControllerTest < ActionController::TestCase
  test 'GET #index' do
    create_list :article, 3

    get :index

    assert_response :success
  end

  test 'POST #create' do
    article_attrs = attributes_for :article

    post :create, params: { article: article_attrs }

    assert_response :success
    article = Article.first
    assert_equal article_attrs[:title], article.title
  end
end
