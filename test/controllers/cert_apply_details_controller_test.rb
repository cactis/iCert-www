require 'test_helper'

class CertApplyDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cert_apply_detail = cert_apply_details(:one)
  end

  test "should get index" do
    get cert_apply_details_url, as: :json
    assert_response :success
  end

  test "should create cert_apply_detail" do
    assert_difference('CertApplyDetail.count') do
      post cert_apply_details_url, params: { cert_apply_detail: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show cert_apply_detail" do
    get cert_apply_detail_url(@cert_apply_detail), as: :json
    assert_response :success
  end

  test "should update cert_apply_detail" do
    patch cert_apply_detail_url(@cert_apply_detail), params: { cert_apply_detail: {  } }, as: :json
    assert_response 200
  end

  test "should destroy cert_apply_detail" do
    assert_difference('CertApplyDetail.count', -1) do
      delete cert_apply_detail_url(@cert_apply_detail), as: :json
    end

    assert_response 204
  end
end
