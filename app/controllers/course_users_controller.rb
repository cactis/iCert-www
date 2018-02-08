class CourseUsersController < ApplicationController
  before_action :set_course_user, only: [:show, :edit, :update, :destroy]

  # GET /course_users
  def index
    @course_users = CourseUser.all
  end

  # GET /course_users/1
  def show
  end

  # GET /course_users/new
  def new
    @course_user = CourseUser.new
  end

  # GET /course_users/1/edit
  def edit
  end

  # POST /course_users
  def create
    @course_user = CourseUser.new(course_user_params)

    if @course_user.save
      redirect_to @course_user, notice: 'Course user was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /course_users/1
  def update
    if @course_user.update(course_user_params)
      redirect_to @course_user, notice: 'Course user was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /course_users/1
  def destroy
    @course_user.destroy
    redirect_to course_users_url, notice: 'Course user was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_user
      @course_user = CourseUser.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def course_user_params
      params.fetch(:course_user, {})
    end
end
