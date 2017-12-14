class PapersController < ApplicationController

  def index
    render json: all_aasm_state
  end

  # GET /papers/1
  def show
    render json: resource
  end

  Paper.aasm.events.each do |event|
    define_method (event.name.to_s + "!").to_sym do
      # eval("resource.#{event.name.to_s}!")
      resource.send "#{event.name.to_s}!"
      render json: resource
    end
  end

  def pay! 
    begin 
      resource.pay!
      render json: resource
    rescue => e
      render_error_message e, :unprocessable_entity
    end
  end



  # POST /papers
  def create
    resource = parent.papers.new(paper_params)
    if resource.save
      render json: resource, status: :created, location: resource
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /papers/1
  def update
    if resource.update(paper_params)
      render json: resource
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end

  # DELETE /papers/1
  def destroy
    resource.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paper
      resource = Paper.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def paper_params
      params.fetch(:paper, {})
    end
  end
