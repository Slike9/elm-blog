require 'test_helper'

class Web::WelcomeControllerTest < ActionController::TestCase
  test 'GET #index' do
    get :index

    assert_response :success
  end
end
