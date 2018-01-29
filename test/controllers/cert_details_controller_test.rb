require 'test_helper'

class CertDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cert_detail = cert_details(:one)
  end

  test "should get index" do
    get cert_details_url, as: :json
    assert_response :success
  end

  test "should create cert_detail" do
    assert_difference('CertDetail.count') do
      post cert_details_url, params: { cert_detail: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show cert_detail" do
    get cert_detail_url(@cert_detail), as: :json
    assert_response :success
  end

  test "should update cert_detail" do
    patch cert_detail_url(@cert_detail), params: { cert_detail: {  } }, as: :json
    assert_response 200
  end

  test "should destroy cert_detail" do
    assert_difference('CertDetail.count', -1) do
      delete cert_detail_url(@cert_detail), as: :json
    end

    assert_response 204
  end
end
