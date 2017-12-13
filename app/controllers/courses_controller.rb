# encoding: utf-8
class CoursesController < ApplicationController
  # before_action :set_course, only: [:show, :update, :destroy, :go]

  # GET /courses
  def index
    # alert "abc已完成中文abc"
    resources = Course.all
    render json: resources
  end

  # GET /courses/1
  def show
    render json: resource
  end

  # POST /courses
  def create
    resource = Course.new(course_params)
    if resource.save
      render json: resource, status: :created, location: resource
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end

  def update
    if resource.update(course_params)
      render json: resource
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end

  def go
    resource.plus!
    render json: resource
  end

  def destroy
    resource.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_course
    #   resource = Course.find(params[:id])
    # end

    # Only allow a trusted parameter "white list" through.
    def course_params
      params.fetch(:course, {})
    end
  end
