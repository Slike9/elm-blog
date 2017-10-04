require 'test_helper'

class Api::V1::ArticlesControllerTest < ActionController::TestCase
  test 'GET #index' do
    create_list :article, 3

    get :index

    assert_response :success
  end
end
