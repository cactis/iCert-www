class TemplatesController < ActionController::Base
  before_action :set_template, only: [:show, :edit, :update, :destroy]
  layout 'application'

  def index
    render json: Template.all
  end

  def show
  end

  def new
    @template = Template.new
  end

  def edit
    @templates = Template.page(1)
    gon.template = @template
    gon.cert_detail = CertDetail.first
    gon.course = Course.first
    gon.fonts = Settings.fonts
  end

  # POST /templates
  def create
    @template = Template.new(template_params)
    if @template.save
      # redirect_to @template, notice: 'Template was successfully created.'
      redirect_to edit_template_path(@template)
    else
      render :new
    end
  end

  # PATCH/PUT /templates/1
  def update
    if @template.update(template_params)
      gon.abc = 'saved'
      render json: @template, notice: 'Template was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /templates/1
  def destroy
    @template.destroy
    redirect_to templates_url, notice: 'Template was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template
      Settings.reload!
      @template = Template.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def template_params
      params.fetch(:template, {}).permit([:title, :data])
    end
end
