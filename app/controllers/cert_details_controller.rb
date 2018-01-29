class CertDetailsController < ApplicationController
  before_action :set_cert_detail, only: [:show, :update, :destroy]

  # GET /cert_details
  def index
    @cert_details = CertDetail.all

    render json: @cert_details
  end

  # GET /cert_details/1
  def show
    render json: @cert_detail
  end

  # POST /cert_details
  def create
    @cert_detail = CertDetail.new(cert_detail_params)

    if @cert_detail.save
      render json: @cert_detail, status: :created, location: @cert_detail
    else
      render json: @cert_detail.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cert_details/1
  def update
    if @cert_detail.update(cert_detail_params)
      render json: @cert_detail
    else
      render json: @cert_detail.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cert_details/1
  def destroy
    @cert_detail.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cert_detail
      @cert_detail = CertDetail.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cert_detail_params
      params.fetch(:cert_detail, {})
    end
end
