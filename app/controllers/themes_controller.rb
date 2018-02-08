class ThemesController < ActionController::Base
  before_action :set_theme, only: [:edit, :show, :update, :destroy]
  layout 'application'
  def new
    @resource = Theme.new
  end

  # GET /themes
  def index
    @themes = Theme.all
  end

  def edit
    gon.theme = @theme
    gon.course = Course.first
  end

  # GET /themes/1
  def show
    render
  end

  # POST /themes
  def create
    @theme = Theme.new(theme_params)

    if @theme.save
      # render json: @theme, status: :created, location: @theme
    else
      # render json: @theme.errors, status: :unprocessable_entity
    end
    redirect_to edit_theme_path(@theme)
  end

  # PATCH/PUT /themes/1
  def update
    if @theme.update(theme_params)
      render json: @theme
    else
      render json: @theme.errors, status: :unprocessable_entity
    end
  end

  # DELETE /themes/1
  def destroy
    @theme.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theme
      @theme = Theme.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def theme_params
      params.fetch(:theme, {}).permit([:title])
    end
end
