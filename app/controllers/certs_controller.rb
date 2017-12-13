class CertsController < ApplicationController
  before_action :set_cert, only: [:show, :update, :destroy]


  def index
    #@certs = Cert.all
    #render json: @certs
    render json: {
      draft: Cert.draft.map{|cert| CertSerializer.new(cert)},
      unconfirmed: Cert.unconfirmed.map{|cert| CertSerializer.new(cert)},
      confirmed: Cert.confirmed.map{|cert| CertSerializer.new(cert)},
    }
  end

  def confirm!
    resource.confirm!
    render json: resource
  end

  def show
    render json: @cert
  end


  def create
    @cert = Cert.new(cert_params)
    if @cert.save
      render json: @cert, status: :created, location: @cert
    else
      render json: @cert.errors, status: :unprocessable_entity
    end
  end


  def update
    if @cert.update(cert_params)
      render json: @cert
    else
      render json: @cert.errors, status: :unprocessable_entity
    end
  end

  # DELETE /certs/1
  def destroy
    @cert.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cert
      @cert = Cert.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cert_params
      params.fetch(:cert, {})
    end
  end
