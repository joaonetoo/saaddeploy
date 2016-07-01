json.array!(@planos) do |plano|
  json.extract! plano, :id, :ameacas, :respostas_ameaca, :oportunidades, :respostas_oportunidades, :fraquezas, :respostas_fraquezas, :forcas, :respostas_forcas, :missao, :objetivos_proximo_ano, :objetivos_cinco_anos, :objetivos_dez_anos, :objetivos, :estrategias, :plano_objetivo, :plano_estrategia, :plano_prazo, :plano_fator_critico, :plano_recursos
  json.url plano_url(plano, format: :json)
end
