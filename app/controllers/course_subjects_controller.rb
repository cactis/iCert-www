class CourseSubjectsController < ApplicationController
  before_action :set_course_subject, only: [:show, :edit, :update, :destroy]

  # GET /course_subjects
  def index
    @course_subjects = CourseSubject.all
  end

  # GET /course_subjects/1
  def show
  end

  # GET /course_subjects/new
  def new
    @course_subject = CourseSubject.new
  end

  # GET /course_subjects/1/edit
  def edit
  end

  # POST /course_subjects
  def create
    @course_subject = CourseSubject.new(course_subject_params)

    if @course_subject.save
      redirect_to @course_subject, notice: 'Course subject was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /course_subjects/1
  def update
    if @course_subject.update(course_subject_params)
      redirect_to @course_subject, notice: 'Course subject was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /course_subjects/1
  def destroy
    @course_subject.destroy
    redirect_to course_subjects_url, notice: 'Course subject was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_subject
      @course_subject = CourseSubject.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_subject_params
      params.fetch(:course_subject, {})
    end
end
