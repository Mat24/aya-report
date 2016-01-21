class AddUltimoDescuentoToCertificates < ActiveRecord::Migration
  def change
    add_column :certificates, :ultimo_descuento, :string
  end
end
