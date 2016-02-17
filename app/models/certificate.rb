class Certificate < ActiveRecord::Base

  validates :saldo_numeros, presence: { message: ": Es un campo obligatorio, no puede estar vacio!" }, numericality: { only_integer: true , message: ": Solo almacena cifras enteras!" }
  before_save :compile_values

  private

  def compile_values
    compiler = UtilsHelper::NumCompiler.new(0)
    self.saldo_letras = compiler.compilar_numero(self.saldo_numeros.to_i).upcase
    self.cuota_letras = compiler.compilar_numero(self.cuota_numeros.to_i).upcase
  end
end
