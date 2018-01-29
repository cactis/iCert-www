require 'test_helper'

class CertAppliesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cert_apply = cert_applies(:one)
  end

  test "should get index" do
    get cert_applies_url, as: :json
    assert_response :success
  end

  test "should create cert_apply" do
    assert_difference('CertApply.count') do
      post cert_applies_url, params: { cert_apply: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show cert_apply" do
    get cert_apply_url(@cert_apply), as: :json
    assert_response :success
  end

  test "should update cert_apply" do
    patch cert_apply_url(@cert_apply), params: { cert_apply: {  } }, as: :json
    assert_response 200
  end

  test "should destroy cert_apply" do
    assert_difference('CertApply.count', -1) do
      delete cert_apply_url(@cert_apply), as: :json
    end

    assert_response 204
  end
end
