class CertDetailsController < ActionController::Base
  before_action :set_cert_detail, only: [:show, :update, :destroy]

  layout "application"

  def index
    # if name = params[:name]
    #   CertDetail.first.update_attributes!(STUD_NAME: name)
    # end
    @cert_details = CertDetail.page(params[:page])
    render json: {callback: "(Any url you want to callback)", result: Cert.limit(10).map{|cert| CertSerializer.new(cert)}, data: @cert_details}
  end

  # GET /cert_details/1
  def show
    gon.resource = @cert_detail
    # render json: @cert_detail
  end

  # POST /cert_details
  def create
    @cert_details = CertDetail.page(params[:page])
    render json: {result: Cert.limit(10).map{|cert| CertSerializer.new(cert)} }
    # @cert_detail = CertDetail.new(cert_detail_params)

    # if @cert_detail.save
    #   render json: @cert_detail, status: :created, location: @cert_detail
    # else
    #   render json: @cert_detail.errors, status: :unprocessable_entity
    # end
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
    def set_cert_detail
      if @cert_detail = CertDetail.find_by_id(params[:id])
      else
        @cert_detail = CertDetail.seed
      end
    end

    # Only allow a trusted parameter "white list" through.
    def cert_detail_params
      params.fetch(:cert_detail, {})
    end
end
