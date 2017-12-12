class UdollarsController < ApplicationController
  before_action :set_udollar, only: [:show, :update, :destroy]

  # GET /udollars
  def index
    @udollars = Udollar.all

    render json: @udollars
  end

  # GET /udollars/1
  def show
    render json: @udollar
  end

  # POST /udollars
  def create
    @udollar = Udollar.new(udollar_params)

    if @udollar.save
      render json: @udollar, status: :created, location: @udollar
    else
      render json: @udollar.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /udollars/1
  def update
    if @udollar.update(udollar_params)
      render json: @udollar
    else
      render json: @udollar.errors, status: :unprocessable_entity
    end
  end

  # DELETE /udollars/1
  def destroy
    @udollar.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_udollar
      @udollar = Udollar.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def udollar_params
      params.fetch(:udollar, {})
    end
end
