require 'test_helper'

class CertsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cert = certs(:one)
  end

  test "should get index" do
    get certs_url, as: :json
    assert_response :success
  end

  test "should create cert" do
    assert_difference('Cert.count') do
      post certs_url, params: { cert: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show cert" do
    get cert_url(@cert), as: :json
    assert_response :success
  end

  test "should update cert" do
    patch cert_url(@cert), params: { cert: {  } }, as: :json
    assert_response 200
  end

  test "should destroy cert" do
    assert_difference('Cert.count', -1) do
      delete cert_url(@cert), as: :json
    end

    assert_response 204
  end
end
