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

    private
    def unidad(numero)
      case numero
        when 9 then @num = "nueve"
        when 8 then @num = "ocho"
        when 7 then @num = "siete"
        when 6 then @num = "seis"
        when 5 then @num = "cinco"
        when 4 then @num = "cuatro"
        when 3 then @num = "tres"
        when 2 then @num = "dos"
        when 1 then @num = (@flag == 0) ? "uno" : "un"
        when 0 then @num = ""
        else @num = ""
      end
      @flag = 0
      @num
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
          @num_letra = "seiscientos "
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

    def miles(numero)
      case numero
        when (1000...2000) then
          @num_letram = "mil ".concat( centena( numero % 1000 ))
        when (2000...10000) then
          @flag = 1
          @num_letram = unidad( numero / 1000 ).concat(" mil ").concat( centena( numero % 1000 ))
      end
      @num_letram = centena( numero ) if ( numero < 1000 )
      @num_letram
    end

    def dec_miles(numero)
      @num_letradm = "diez mil" if (numero == 10000 )
      if numero > 10000 and numero < 20000
        @flag = 1
        @num_letradm = decena( numero / 1000 ).concat("mil ").concat( centena( numero % 1000 ) )
      end
      if numero >= 20000 and numero < 100000
        @flag = 1
        @num_letradm = decena( numero / 1000 ).concat(" mil ").concat( miles( numero % 1000 ) )
      end
      @num_letradm = miles( numero ) if ( numero < 10000 )
      @num_letradm
    end

    def cien_miles(numero)
      @num_letracm = "cien mil" if (numero == 100000 )
      if numero > 100000 and numero < 1000000
        @flag = 1
        @num_letracm = centena( numero / 1000 ).concat(" mil ").concat( centena( numero % 1000 ) )
      end
      @num_letracm = dec_miles(numero) if ( numero < 100000)
      @num_letracm
    end

    def millon(numero)
      if numero >= 1000000 and numero < 2000000
        @flag = 1
        @num_letramm = "Un millon ".concat( cien_miles( numero % 1000000 ) )
      end
      if numero >= 2000000 and numero < 10000000
        @flag = 1
        @num_letramm = unidad( numero / 1000000 ).concat(" millones ").concat( cien_miles( numero % 1000000 ) )
      end
      @num_letramm = cien_miles(numero) if ( numero < 1000000)
      @num_letramm
    end

    def dec_millon(numero)
      @num_letradmm = "diez millones" if ( numero == 10000000 )
      if numero > 10000000 and numero < 20000000
        @flag = 1
        @num_letradmm = decena( numero / 1000000 ).concat("millones ").concat( cien_miles( numero % 1000000 ) )
      end
      if numero >= 20000000 and numero < 100000000
        @flag = 1
        @num_letradmm = decena( numero / 1000000 ).concat(" millones ").concat( millon( numero % 1000000 ) )
      end
      @num_letradmm = millon(numero) if ( numero < 10000000 )
      @num_letradmm
    end

    public
    def compilar_numero(numero)
      dec_millon(numero)
    end
  end
end