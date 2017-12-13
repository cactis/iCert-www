require 'test_helper'

class PapersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @paper = papers(:one)
  end

  test "should get index" do
    get papers_url, as: :json
    assert_response :success
  end

  test "should create paper" do
    assert_difference('Paper.count') do
      post papers_url, params: { paper: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show paper" do
    get paper_url(@paper), as: :json
    assert_response :success
  end

  test "should update paper" do
    patch paper_url(@paper), params: { paper: {  } }, as: :json
    assert_response 200
  end

  test "should destroy paper" do
    assert_difference('Paper.count', -1) do
      delete paper_url(@paper), as: :json
    end

    assert_response 204
  end
end
