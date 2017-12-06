require 'test_helper'

class DeveloppeursControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get developpeurs_index_url
    assert_response :success
  end

  test "should get show" do
    get developpeurs_show_url
    assert_response :success
  end

  test "should get new" do
    get developpeurs_new_url
    assert_response :success
  end

  test "should get create" do
    get developpeurs_create_url
    assert_response :success
  end

  test "should get edit" do
    get developpeurs_edit_url
    assert_response :success
  end

  test "should get update" do
    get developpeurs_update_url
    assert_response :success
  end

  test "should get destroy" do
    get developpeurs_destroy_url
    assert_response :success
  end

end
