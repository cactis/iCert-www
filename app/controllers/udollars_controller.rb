class UdollarsController < ApplicationController
  before_action :set_udollar, only: [:show, :update, :destroy]

  # GET /udollars
  def index
    resources = Udollar.all
    render json: resources
  end

  # GET /udollars/1
  def show
    render json: resource
  end

  # POST /udollars
  def create
    resource = Udollar.new(udollar_params)

    if resource.save
      render json: resource, status: :created, location: resource
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /udollars/1
  def update
    if resource.update(udollar_params)
      render json: resource
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end

  # DELETE /udollars/1
  def destroy
    resource.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_udollar
      resource = Udollar.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def udollar_params
      params.fetch(:udollar, {})
    end
  end
