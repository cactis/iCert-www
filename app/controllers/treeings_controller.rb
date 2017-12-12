class TreeingsController < ApplicationController
  before_action :set_treeing, only: [:show, :update, :destroy]

  # GET /treeings
  def index
    @treeings = Treeing.all

    render json: @treeings
  end

  # GET /treeings/1
  def show
    render json: @treeing
  end

  # POST /treeings
  def create
    @treeing = Treeing.new(treeing_params)

    if @treeing.save
      render json: @treeing, status: :created, location: @treeing
    else
      render json: @treeing.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /treeings/1
  def update
    if @treeing.update(treeing_params)
      render json: @treeing
    else
      render json: @treeing.errors, status: :unprocessable_entity
    end
  end

  # DELETE /treeings/1
  def destroy
    @treeing.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_treeing
      @treeing = Treeing.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def treeing_params
      params.fetch(:treeing, {})
    end
end
