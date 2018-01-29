class CertAppliesController < ApplicationController
  before_action :set_cert_apply, only: [:show, :update, :destroy]

  # GET /cert_applies
  def index
    @cert_applies = CertApply.page(params[:page])
    render json: @cert_applies
  end

  # GET /cert_applies/1
  def show
    render json: @cert_apply
  end

  # POST /cert_applies
  def create
    @cert_apply = CertApply.new(cert_apply_params)

    if @cert_apply.save
      render json: @cert_apply, status: :created, location: @cert_apply
    else
      render json: @cert_apply.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cert_applies/1
  def update
    if @cert_apply.update(cert_apply_params)
      render json: @cert_apply
    else
      render json: @cert_apply.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cert_applies/1
  def destroy
    @cert_apply.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cert_apply
      @cert_apply = CertApply.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cert_apply_params
      params.fetch(:cert_apply, {})
    end
  end
