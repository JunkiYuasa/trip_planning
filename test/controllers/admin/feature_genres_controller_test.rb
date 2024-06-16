require "test_helper"

class Admin::FeatureGenresControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_feature_genres_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_feature_genres_edit_url
    assert_response :success
  end
end
