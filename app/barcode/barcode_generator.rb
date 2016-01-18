require 'barby'
require 'barby/barcode/gs1_128'
require 'barby/outputter/prawn_outputter'

class BarcodeGenerator < Barby::GS1128
  attr_accessor :codigo_ean
  attr_accessor :gs1_indentifier
  attr_accessor :codigo_ia
  attr_accessor :referencia_de_pago
  attr_accessor :codigo_valor
  attr_accessor :valor_a_pagar
  attr_accessor :codigo_fecha
  attr_accessor :anno
  attr_accessor :mes
  attr_accessor :dia
  attr_reader :code
  attr_reader :code_text
  def initialize(params)
    @codigo_ean = '415'
    @gs1_indentifier = '7709998263833'#'77071769660178' # Codigo unico de la empresa
    @codigo_ia = '8020'
    @referencia_de_pago = ((params[:no_libranza].length % 2) == 0) ? params[:no_libranza] : "0#{params[:no_libranza]}"#"22516572"
    # FNC1
    @codigo_valor = '3900'
    @valor_a_pagar = ((params[:saldo_numeros].length % 2) == 0) ? params[:saldo_numeros] : "0#{params[:saldo_numeros]}"   #"0000170687" # Se uliliza de 2 hasta 14 digitos(Poscisiones)
    # FNC1
    @codigo_fecha = '96'
    @anno = params[:anno]#'2015'
    @mes = params[:mes]#'12'
    @dia = params[:dia]#'02'
    @code = "#{@codigo_ean}#{@gs1_indentifier}#{@codigo_ia}#{@referencia_de_pago}#{FNC1}#{@codigo_valor}#{@valor_a_pagar}#{FNC1}#{@codigo_fecha}#{@anno}#{@mes}#{@dia}"
    puts "***************************************************"
    puts "***************************************************"
    puts @code
    puts "***************************************************"
    puts "***************************************************"
    @code_text = "(#{@codigo_ean})#{@gs1_indentifier}(#{@codigo_ia})#{@referencia_de_pago}(#{@codigo_valor})#{@valor_a_pagar}(#{@codigo_fecha})#{@anno}#{@mes}#{@dia}"
    # @code = "415770999826383380201111111111111111111111113900000000000"
    #codigo = "415770999826383380201111111111111111111111113900000000000"
    #pago = 170687
    #cuenta = 22516572
    #fecha = 201611
  end
  def make_code
    Barby::GS1128.new(@code,'C','')
  end
end










