require 'test_helper'

class AssetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @asset = assets(:one)
  end

  test "should get index" do
    get assets_url, as: :json
    assert_response :success
  end

  test "should create asset" do
    assert_difference('Asset.count') do
      post assets_url, params: { asset: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show asset" do
    get asset_url(@asset), as: :json
    assert_response :success
  end

  test "should update asset" do
    patch asset_url(@asset), params: { asset: {  } }, as: :json
    assert_response 200
  end

  test "should destroy asset" do
    assert_difference('Asset.count', -1) do
      delete asset_url(@asset), as: :json
    end

    assert_response 204
  end
end
