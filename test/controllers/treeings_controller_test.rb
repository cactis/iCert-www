require 'test_helper'

class TreeingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @treeing = treeings(:one)
  end

  test "should get index" do
    get treeings_url, as: :json
    assert_response :success
  end

  test "should create treeing" do
    assert_difference('Treeing.count') do
      post treeings_url, params: { treeing: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show treeing" do
    get treeing_url(@treeing), as: :json
    assert_response :success
  end

  test "should update treeing" do
    patch treeing_url(@treeing), params: { treeing: {  } }, as: :json
    assert_response 200
  end

  test "should destroy treeing" do
    assert_difference('Treeing.count', -1) do
      delete treeing_url(@treeing), as: :json
    end

    assert_response 204
  end
end
