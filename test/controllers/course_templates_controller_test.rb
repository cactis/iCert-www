require 'test_helper'

class CourseTemplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_template = course_templates(:one)
  end

  test "should get index" do
    get course_templates_url
    assert_response :success
  end

  test "should get new" do
    get new_course_template_url
    assert_response :success
  end

  test "should create course_template" do
    assert_difference('CourseTemplate.count') do
      post course_templates_url, params: { course_template: {  } }
    end

    assert_redirected_to course_template_url(CourseTemplate.last)
  end

  test "should show course_template" do
    get course_template_url(@course_template)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_template_url(@course_template)
    assert_response :success
  end

  test "should update course_template" do
    patch course_template_url(@course_template), params: { course_template: {  } }
    assert_redirected_to course_template_url(@course_template)
  end

  test "should destroy course_template" do
    assert_difference('CourseTemplate.count', -1) do
      delete course_template_url(@course_template)
    end

    assert_redirected_to course_templates_url
  end
end
