# encoding: utf-8
class CoursesController < ApplicationController
  # before_action :set_course, only: [:show, :update, :destroy, :go]

  # GET /courses
  def index
    # alert "abc已完成中文abc"
    resources = Course.page(params[:page])
    # resources = CertDetail.page(params[:page])
    render json: resources
  end

  def show
    render json: resource
  end

  def create
    resource = Course.seed!
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

  def reset
    Course.destroy_all
    log Udollar.count
  end

  private
    def course_params
      params.fetch(:course, {})
    end
  end
