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

  test 'PATCH #update' do
    article = create :article
    new_title = generate(:string)

    patch :update, params: { id: article.id, article: { title: new_title } }

    assert_response :success
    article.reload
    assert_equal new_title, article.title
  end
end
