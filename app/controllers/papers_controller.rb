class PapersController < ApplicationController

  def new
    if cert = Cert.find_by_qrcode_token(params[:token])
      log cert, 'cert'
      if cert.qrcode_token_at > Time.now - 30.minutes
        cert.papers.create!
        # respond_to do |format|
        #   format.html: {js: "abrr"}
        #   format.json: cert.papers.create!
        # end
        log 111
        alert = "<script>alert('請求成功。您將收到推播訊息，引導您到 iCert 付款。')</script>"
        render js: alert
        # respond_to do |format|
        #   format.html { render :js => alert }
        #   format.js   { render :js => alert }
        # end
        return
      end
    end
    title = "本條碼已過期。"
    body = "請在產生列印條碼後， 3 分鐘內在證照印刷機掃描完成。"
    state = ""
    render json: title
    User.first.push!({title: title, body: body}, {state: "unpaid"})
  end

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
