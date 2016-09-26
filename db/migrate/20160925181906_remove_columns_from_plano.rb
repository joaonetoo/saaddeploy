class RemoveColumnsFromPlano < ActiveRecord::Migration
  def change
    remove_column :planos, :ameacas
    remove_column :planos, :respostas_ameaca
    remove_column :planos, :oportunidades
    remove_column :planos, :respostas_oportunidades
    remove_column :planos, :fraquezas
    remove_column :planos, :respostas_fraquezas
    remove_column :planos, :forcas
    remove_column :planos, :respostas_forcas
    remove_column :planos, :missao
    remove_column :planos, :objetivos_proximo_ano
    remove_column :planos, :objetivos_cinco_anos
    remove_column :planos, :objetivos_dez_anos
    remove_column :planos, :objetivos
    remove_column :planos, :estrategias
    remove_column :planos, :plano_objetivo
    remove_column :planos, :plano_estrategia
    remove_column :planos, :plano_prazo
    remove_column :planos, :plano_fator_critico
    remove_column :planos, :plano_recursos
  end
end
