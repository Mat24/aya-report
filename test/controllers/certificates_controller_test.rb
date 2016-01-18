require 'test_helper'

class CertificatesControllerTest < ActionController::TestCase
  setup do
    @certificate = certificates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:certificates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create certificate" do
    assert_difference('Certificate.count') do
      post :create, certificate: { cedula: @certificate.cedula, clase_cooperativa: @certificate.clase_cooperativa, cuota_letras: @certificate.cuota_letras, cuota_numeros: @certificate.cuota_numeros, fecha_vencimiento: @certificate.fecha_vencimiento, no_libranza: @certificate.no_libranza, nombre: @certificate.nombre, pagaduria: @certificate.pagaduria, saldo_letras: @certificate.saldo_letras, saldo_numeros: @certificate.saldo_numeros }
    end

    assert_redirected_to certificate_path(assigns(:certificate))
  end

  test "should show certificate" do
    get :show, id: @certificate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @certificate
    assert_response :success
  end

  test "should update certificate" do
    patch :update, id: @certificate, certificate: { cedula: @certificate.cedula, clase_cooperativa: @certificate.clase_cooperativa, cuota_letras: @certificate.cuota_letras, cuota_numeros: @certificate.cuota_numeros, fecha_vencimiento: @certificate.fecha_vencimiento, no_libranza: @certificate.no_libranza, nombre: @certificate.nombre, pagaduria: @certificate.pagaduria, saldo_letras: @certificate.saldo_letras, saldo_numeros: @certificate.saldo_numeros }
    assert_redirected_to certificate_path(assigns(:certificate))
  end

  test "should destroy certificate" do
    assert_difference('Certificate.count', -1) do
      delete :destroy, id: @certificate
    end

    assert_redirected_to certificates_path
  end
end
