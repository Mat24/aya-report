class Certificate < ActiveRecord::Base
  before_save :compile_values

  private

  def compile_values
    compiler = UtilsHelper::NumCompiler.new(0)
    self.saldo_letras = compiler.compilar_numero(self.saldo_numeros.to_i)
    self.cuota_letras = compiler.compilar_numero(self.cuota_numeros.to_i)
  end
end
