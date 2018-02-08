class CourseUserSubjectsController < ApplicationController
  before_action :set_course_user_subject, only: [:show, :edit, :update, :destroy]

  # GET /course_user_subjects
  def index
    @course_user_subjects = CourseUserSubject.all
  end

  # GET /course_user_subjects/1
  def show
  end

  # GET /course_user_subjects/new
  def new
    @course_user_subject = CourseUserSubject.new
  end

  # GET /course_user_subjects/1/edit
  def edit
  end

  # POST /course_user_subjects
  def create
    @course_user_subject = CourseUserSubject.new(course_user_subject_params)

    if @course_user_subject.save
      redirect_to @course_user_subject, notice: 'Course user subject was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /course_user_subjects/1
  def update
    if @course_user_subject.update(course_user_subject_params)
      redirect_to @course_user_subject, notice: 'Course user subject was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /course_user_subjects/1
  def destroy
    @course_user_subject.destroy
    redirect_to course_user_subjects_url, notice: 'Course user subject was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_user_subject
      @course_user_subject = CourseUserSubject.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_user_subject_params
      params.fetch(:course_user_subject, {})
    end
end
