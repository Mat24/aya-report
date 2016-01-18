json.array!(@certificates) do |certificate|
  json.extract! certificate, :id, :nombre, :cedula, :pagaduria, :no_libranza, :saldo_letras, :saldo_numeros, :cuota_letras, :cuota_numeros, :clase_cooperativa, :fecha_vencimiento
  json.url certificate_url(certificate, format: :json)
end
