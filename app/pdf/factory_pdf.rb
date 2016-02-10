
class FactoryPDF < Prawn::Document
  include ActionView::Helpers::NumberHelper
  attr_accessor :person
  attr_accessor :time
  def initialize(certificate_data,membrete)
    super()
    @person = certificate_data
    @time = Time.now
    # stroke_axis
    if membrete
      bounding_box([0, 730], :width => 535, :height => 70) do
        image "#{Rails.root}/app/assets/images/cooperas/Encabezado.png", width: 535, height: 70 if @person.clase_cooperativa.downcase == "cooperas"
      end
    end
    bounding_box([20, 730], :width => 490, :height => 730) do
      titulo
      # stroke_axis
      move_down 200
      encabezado
      barcode
      fin
    end
    if membrete
      bounding_box([0, 35], :width => 535, :height => 35) do
        image "#{Rails.root}/app/assets/images/cooperas/Pie_de_pagina.png", width: 535, height: 35 if @person.clase_cooperativa.downcase == "cooperas"
      end
    end
  end

  def titulo
    draw_text("CERTIFICACION DE DEUDA", size: 20, :at => [110,600], character_spacing: 2)
    # draw_text(@person.inspect, size: 20, :at => [150,500])
  end

  def encabezado
    bounding_box([0, 550], :width => 490, :height => 250) do
      if person.clase_cooperativa == "cooperas"
        text("COOPERATIVA MULTIACTIVA DE AMIGOS SOLIDARIOS - COOPERAS,NIT 830.510.344-8, certifica que el ( la ) Señor (a) #{@person.nombre.upcase}, identificado (a) con cédula de ciudadanía No. #{number_with_delimiter(@person.cedula)} perteneciente a la pagaduría #{@person.pagaduria.upcase}; tiene un crédito con esta entidad mediante la libranza No.#{@person.no_libranza} con un saldo de #{@person.saldo_letras} PESOS M/CTE. ( #{convert_num(@person.saldo_numeros)} ). El valor de la cuota pactada es de #{@person.cuota_letras} PESOS M/CTE. ( #{convert_num(@person.cuota_numeros)} ).Se toma en cuenta como último descuento a favor de la Cooperativa la cuota del mes de #{@person.ultimo_descuento.upcase}.", :align => :justify, size: 10)
      elsif person.clase_cooperativa == "astv"
        text("As Televisión As Medios Ltda,NIT 860.509.357-0, certifica que el ( la ) Señor (a) #{@person.nombre.upcase}, identificado (a) con cédula de ciudadanía No. #{number_with_delimiter(@person.cedula)} perteneciente a la pagaduría #{@person.pagaduria.upcase}; tiene un crédito con esta entidad mediante la libranza No.#{@person.no_libranza} con un saldo de #{@person.saldo_letras} PESOS M/CTE. ( #{convert_num(@person.saldo_numeros)} ). El valor de la cuota pactada es de #{@person.cuota_letras} PESOS M/CTE. ( #{convert_num(@person.cuota_numeros)} ).Se toma en cuenta como último descuento a favor de la Cooperativa la cuota del mes de #{@person.ultimo_descuento.upcase}.", :align => :justify, size: 10)
      end
           pad_top(30) do
             text("Esta certificación tiene vigencia hasta el #{@person.fecha_vencimiento.day} del mes #{numero_mes(@person.fecha_vencimiento.month)} de #{@person.fecha_vencimiento.year}.", :align => :justify, size: 10)
           end
           pad(10) do
             text("Esta certificación se expide a petición del interesado (a), a los #{time.day} del mes de #{numero_mes(time.month)} de #{time.year}.", :align => :justify, size: 10)
           end
    end


  end

  def barcode
    params = {}
    params[:codigo_empresa] = (person.clase_cooperativa.downcase == "cooperas") ? '7709998263833' : '7709998716858' # Cooperas = 7709998263833
    params[:no_libranza] = person.no_libranza.to_s                                                                  # As Tv = 7709998716858
    params[:saldo_numeros] = person.saldo_numeros.to_s
    params[:anno] = person.fecha_vencimiento.year.to_s
    params[:mes] = (person.fecha_vencimiento.month < 10 ) ? "0#{person.fecha_vencimiento.month}" : person.fecha_vencimiento.month.to_s
    params[:dia] = (person.fecha_vencimiento.day < 10 ) ? "0#{person.fecha_vencimiento.day}" : person.fecha_vencimiento.day.to_s
    code = BarcodeGenerator.new(params)
    _barcode = code.make_code
    bounding_box([80, 380], :width => 350, :height => 50) do
      # stroke_axis
      _barcode.annotate_pdf(self)
    end
    bounding_box([90, 320], :width => 315, :height => 11) do
      text code.code_text, size: 10, :align => :center
    end


  end

  def fin
    bounding_box([0,260], :width => 490, :height => 200) do
      text "Banco autorizado para el pago: BANCO DE BOGOTA"
      pad(10) do
        text "ENVIAR LA CONSIGNACION O TRANSFERENCIA AL TELEFAX 3375394 Bogotá. Para tramitar el respectivo paz y salvo"
      end
      pad_top(40) do
        text "Atentamente,"
      end
      pad_top(20) do
        text "DPTO. DE CARTERA"
      end

      pad(10) do
        text "NOTA: DERECHO DE PEDIR ENMIENDA DE ERRORES ART.880 DEL CODIGO DE COMERCIO."
      end
    end

    bounding_box([350,55], :width => 130, :height => 20) do
      stroke_horizontal_rule
      pad(5) do
        text "FIRMA RECIBIDO", size: 10, :align => :center
      end
    end
  end
private
  def numero_mes(numero_mes)
    ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"][numero_mes-1]
  end

  def convert_num(num)
    number_to_currency(num, precision: 0)
  end
end
# "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre",
