class CertsController < ApplicationController
  before_action :set_cert, only: [:html, :show, :update, :destroy]
  respond_to :json, :html

  def qrcode
    resource.qrcode_token!
    render json: resource
  end

  def index
    render json: all_aasm_state
  end

  def paper
    send_file resource.file, type: "image/jpeg", disposition: "inline"
  end

  # def html    
  #   render json: resource.html
  # end

  def confirm!
    resource.confirm!
    render json: resource
  end

  def show
    css = "body{font-size: 1em}
    h1{ text-align: center; font-size: 1.2em;}
    table{margin: 1em auto;}
    img{width: 100%}
    "
    body = "<h1>#{resource.title}</h1>
    <img src='#{resource.photo.file_url}'/>
    #{resource.info}
    "
    html = "<html><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><style>#{css}</style></head><body>#{body}</body></html>"
    render json: html
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
