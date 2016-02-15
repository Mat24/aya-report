module UtilsHelper
  class NumCompiler
    # Accesores
    private
    attr_accessor :numero

    public
    attr_accessor :flag
    attr_accessor :importe_parcial
    attr_accessor :num
    attr_accessor :num_letra
    attr_accessor :num_letras
    attr_accessor :num_letram
    attr_accessor :num_letradm
    attr_accessor :num_letracm
    attr_accessor :num_letramm
    attr_accessor :num_letradmm

    def initialize(num)
      @numero = num
      @flag = 0
    end

    # private
    def unidad(numero)
      case numero
        when 9 then "nueve"
        when 8 then "ocho"
        when 7 then "siete"
        when 6 then "seis"
        when 5 then "cinco"
        when 4 then "cuatro"
        when 3 then "tres"
        when 2 then "dos"
        when 1 then (@flag == 0) ? "uno" : "un"
        when 0 then ""
        else ""
      end
    end

    def decena(numero)
      case numero
        when (90..99) then
          @num_letra = "noventa "
          @num_letra = @num_letra.concat("y ").concat(unidad(numero - 90)) if (numero > 90)
        when (80..89) then
          @num_letra = "ochenta "
          @num_letra = @num_letra.concat("y ").concat(unidad(numero - 80)) if (numero > 80)
        when (70..79) then
          @num_letra = "setenta "
          @num_letra = @num_letra.concat("y ").concat(unidad(numero - 70)) if (numero > 70)
        when (60..69) then
          @num_letra = "sesenta "
          @num_letra = @num_letra.concat("y ").concat(unidad(numero - 60)) if (numero > 60)
        when (50..59) then
          @num_letra = "cincuenta "
          @num_letra = @num_letra.concat("y ").concat(unidad(numero - 50)) if (numero > 50)
        when (40..49) then
          @num_letra = "cuarenta "
          @num_letra = @num_letra.concat("y ").concat(unidad(numero - 40)) if (numero > 40)
        when (30..39) then
          @num_letra = "treinta "
          @num_letra = @num_letra.concat("y ").concat(unidad(numero - 30)) if (numero > 30)
        when (20..29) then
          @num_letra = (numero == 20) ? "veinte " : "veinti".concat(unidad(numero - 20))
        when (10..19) then
          @num_letra = case numero
                         when 10 then @num_letra = "diez "
                         when 11 then @num_letra = "once "
                         when 12 then @num_letra = "doce "
                         when 13 then @num_letra = "trece "
                         when 14 then @num_letra = "catorce "
                         when 15 then @num_letra = "quince "
                         when 16 then @num_letra = "dieciseis "
                         when 17 then @num_letra = "diecisiete "
                         when 18 then @num_letra = "dieciocho "
                         when 19 then @num_letra = "diecinueve "
                       end
        else
          @num_letra = unidad(numero)
      end
      @num_letra
    end

    def centena(numero)
      case numero
        when (900..999) then
          @num_letra = "novecientos "
          @num_letra = @num_letra.concat(decena(numero - 900)) if ( numero > 900 )
        when (800..899) then
          @num_letra = "ochocientos "
          @num_letra = @num_letra.concat(decena(numero - 800)) if ( numero > 800 )
        when (700..799) then
          @num_letra = "setecientos "
          @num_letra = @num_letra.concat(decena(numero - 700)) if ( numero > 700 )
        when (600..699) then
          @num_letra = "setecientos "
          @num_letra = @num_letra.concat(decena(numero - 600)) if ( numero > 600 )
        when (500..599) then
          @num_letra = "quinientos "
          @num_letra = @num_letra.concat(decena(numero - 500)) if ( numero > 500 )
        when (400..499) then
          @num_letra = "cuatrocientos "
          @num_letra = @num_letra.concat(decena(numero - 400)) if ( numero > 400 )
        when (300..399) then
          @num_letra = "trescientos "
          @num_letra = @num_letra.concat(decena(numero - 300)) if ( numero > 300 )
        when (200..299) then
          @num_letra = "doscientos "
          @num_letra = @num_letra.concat(decena(numero - 200)) if ( numero > 200 )
        when (100..199) then
          @num_letra = ( numero == 100) ? "cien" : "ciento ".concat( decena( numero - 100 ) )
        else
          @num_letra = decena(numero)
      end
      @num_letra
    end
  end
end