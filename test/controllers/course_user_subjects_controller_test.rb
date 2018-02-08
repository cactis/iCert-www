require 'test_helper'

class CourseUserSubjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_user_subject = course_user_subjects(:one)
  end

  test "should get index" do
    get course_user_subjects_url
    assert_response :success
  end

  test "should get new" do
    get new_course_user_subject_url
    assert_response :success
  end

  test "should create course_user_subject" do
    assert_difference('CourseUserSubject.count') do
      post course_user_subjects_url, params: { course_user_subject: {  } }
    end

    assert_redirected_to course_user_subject_url(CourseUserSubject.last)
  end

  test "should show course_user_subject" do
    get course_user_subject_url(@course_user_subject)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_user_subject_url(@course_user_subject)
    assert_response :success
  end

  test "should update course_user_subject" do
    patch course_user_subject_url(@course_user_subject), params: { course_user_subject: {  } }
    assert_redirected_to course_user_subject_url(@course_user_subject)
  end

  test "should destroy course_user_subject" do
    assert_difference('CourseUserSubject.count', -1) do
      delete course_user_subject_url(@course_user_subject)
    end

    assert_redirected_to course_user_subjects_url
  end
end
