class CertApplyDetailsController < ApplicationController
  before_action :set_cert_apply_detail, only: [:show, :update, :destroy]

  # GET /cert_apply_details
  def index
    @cert_apply_details = CertApplyDetail.all

    render json: @cert_apply_details
  end

  # GET /cert_apply_details/1
  def show
    render json: @cert_apply_detail
  end

  # POST /cert_apply_details
  def create
    @cert_apply_detail = CertApplyDetail.new(cert_apply_detail_params)

    if @cert_apply_detail.save
      render json: @cert_apply_detail, status: :created, location: @cert_apply_detail
    else
      render json: @cert_apply_detail.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cert_apply_details/1
  def update
    if @cert_apply_detail.update(cert_apply_detail_params)
      render json: @cert_apply_detail
    else
      render json: @cert_apply_detail.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cert_apply_details/1
  def destroy
    @cert_apply_detail.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cert_apply_detail
      @cert_apply_detail = CertApplyDetail.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cert_apply_detail_params
      params.fetch(:cert_apply_detail, {})
    end
end
