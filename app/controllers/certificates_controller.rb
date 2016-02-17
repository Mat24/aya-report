class CertificatesController < ApplicationController
  before_action :set_certificate, only: [:show, :edit, :update, :destroy,:generate_pdf]

  # GET /certificates
  # GET /certificates.json
  def index
    @certificates = Certificate.all.order("created_at DESC").page(params[:page]).per(6)
  end

  # GET /certificates/1
  # GET /certificates/1.json
  def show
  end

  # GET /certificates/:id
  def generate_pdf
    membrete = (params.has_key?(:membrete)) ? true : false
    pdf = FactoryPDF.new(@certificate,membrete)
    send_data pdf.render, filename: "Certificado(#{@certificate.no_libranza}) #{@certificate.nombre} (#{Time.now.year}-#{Time.now.month}-#{Time.now.day}).pdf", type: 'application/pdf'
  end

  # GET /certificates/new
  def new
    @certificate = Certificate.new
  end

  # GET /certificates/1/edit
  def edit
  end

  # POST /certificates
  # POST /certificates.json
  def create
    @certificate = Certificate.new(certificate_params)

    respond_to do |format|
      if @certificate.save
        format.html { redirect_to @certificate, notice: 'Certificado creado exitosamente.' }
        format.json { render :show, status: :created, location: @certificate }
      else
        format.html { render :new }
        format.json { render json: @certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /certificates/1
  # PATCH/PUT /certificates/1.json
  def update
    respond_to do |format|
      if @certificate.update(certificate_params)
        format.html { redirect_to @certificate, notice: 'Certificado actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @certificate }
      else
        format.html { render :edit }
        format.json { render json: @certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /certificates/1
  # DELETE /certificates/1.json
  def destroy
    @certificate.destroy
    respond_to do |format|
      format.html { redirect_to certificates_url, notice: 'Certificado eliminado exitosamente' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_certificate
    @certificate = Certificate.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def certificate_params
    params.require(:certificate).permit(:nombre, :cedula, :pagaduria, :no_libranza, :saldo_numeros, :cuota_numeros, :fecha_vencimiento, :clase_cooperativa, :ultimo_descuento)
  end
end
