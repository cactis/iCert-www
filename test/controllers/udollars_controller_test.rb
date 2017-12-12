require 'test_helper'

class UdollarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @udollar = udollars(:one)
  end

  test "should get index" do
    get udollars_url, as: :json
    assert_response :success
  end

  test "should create udollar" do
    assert_difference('Udollar.count') do
      post udollars_url, params: { udollar: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show udollar" do
    get udollar_url(@udollar), as: :json
    assert_response :success
  end

  test "should update udollar" do
    patch udollar_url(@udollar), params: { udollar: {  } }, as: :json
    assert_response 200
  end

  test "should destroy udollar" do
    assert_difference('Udollar.count', -1) do
      delete udollar_url(@udollar), as: :json
    end

    assert_response 204
  end
end
