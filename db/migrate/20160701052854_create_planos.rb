class CreatePlanos < ActiveRecord::Migration
  def change
    create_table :planos do |t|
      t.text :ameacas
      t.text :respostas_ameaca
      t.text :oportunidades
      t.text :respostas_oportunidades
      t.text :fraquezas
      t.text :respostas_fraquezas
      t.text :forcas
      t.text :respostas_forcas
      t.text :missao
      t.text :objetivos_proximo_ano
      t.text :objetivos_cinco_anos
      t.text :objetivos_dez_anos
      t.text :objetivos
      t.text :estrategias
      t.text :plano_objetivo
      t.text :plano_estrategia
      t.text :plano_prazo
      t.text :plano_fator_critico
      t.text :plano_recursos

      t.timestamps null: false
    end
  end
end
