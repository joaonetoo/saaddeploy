require 'test_helper'

class PlanosControllerTest < ActionController::TestCase
  setup do
    @plano = planos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:planos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create plano" do
    assert_difference('Plano.count') do
      post :create, plano: { ameacas: @plano.ameacas, estrategias: @plano.estrategias, forcas: @plano.forcas, fraquezas: @plano.fraquezas, missao: @plano.missao, objetivos: @plano.objetivos, objetivos_cinco_anos: @plano.objetivos_cinco_anos, objetivos_dez_anos: @plano.objetivos_dez_anos, objetivos_proximo_ano: @plano.objetivos_proximo_ano, oportunidades: @plano.oportunidades, plano_estrategia: @plano.plano_estrategia, plano_fator_critico: @plano.plano_fator_critico, plano_objetivo: @plano.plano_objetivo, plano_prazo: @plano.plano_prazo, plano_recursos: @plano.plano_recursos, respostas_ameaca: @plano.respostas_ameaca, respostas_forcas: @plano.respostas_forcas, respostas_fraquezas: @plano.respostas_fraquezas, respostas_oportunidades: @plano.respostas_oportunidades }
    end

    assert_redirected_to plano_path(assigns(:plano))
  end

  test "should show plano" do
    get :show, id: @plano
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @plano
    assert_response :success
  end

  test "should update plano" do
    patch :update, id: @plano, plano: { ameacas: @plano.ameacas, estrategias: @plano.estrategias, forcas: @plano.forcas, fraquezas: @plano.fraquezas, missao: @plano.missao, objetivos: @plano.objetivos, objetivos_cinco_anos: @plano.objetivos_cinco_anos, objetivos_dez_anos: @plano.objetivos_dez_anos, objetivos_proximo_ano: @plano.objetivos_proximo_ano, oportunidades: @plano.oportunidades, plano_estrategia: @plano.plano_estrategia, plano_fator_critico: @plano.plano_fator_critico, plano_objetivo: @plano.plano_objetivo, plano_prazo: @plano.plano_prazo, plano_recursos: @plano.plano_recursos, respostas_ameaca: @plano.respostas_ameaca, respostas_forcas: @plano.respostas_forcas, respostas_fraquezas: @plano.respostas_fraquezas, respostas_oportunidades: @plano.respostas_oportunidades }
    assert_redirected_to plano_path(assigns(:plano))
  end

  test "should destroy plano" do
    assert_difference('Plano.count', -1) do
      delete :destroy, id: @plano
    end

    assert_redirected_to planos_path
  end
end
