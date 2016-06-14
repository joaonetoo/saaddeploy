class QuizController < ApplicationController
  def index
  end

  def answer
    @q1 = params[:q1].to_i
    @q2 = params[:q2].to_i
    @q3 = params[:q3].to_i
    @q4 = params[:q4].to_i
    @q5 = params[:q5].to_i
    @q6 = params[:q6].to_i
    @q7 = params[:q7].to_i
    @q8 = params[:q8].to_i
    @q9 = params[:q9].to_i
    @q10 = params[:q10].to_i
    @q11 = params[:q11].to_i
    @q12 = params[:q12].to_i
    @q13 = params[:q13].to_i
    @q14 = params[:q14].to_i
    @q15 = params[:q15].to_i
    @q16 = params[:q16].to_i
    @q17 = params[:q17].to_i
    @q18 = params[:q18].to_i
    @q19 = params[:q19].to_i
    @q20 = params[:q20].to_i
    @q21 = params[:q21].to_i
    @q22 = params[:q22].to_i
    @q23 = params[:q23].to_i
    @q24 = params[:q24].to_i
    @q25 = params[:q25].to_i
    @q26 = params[:q26].to_i
    @q27 = params[:q27].to_i
    @q28 = params[:q28].to_i
    @q29 = params[:q29].to_i
    @q30 = params[:q30].to_i
    @q31 = params[:q31].to_i
    @q32 = params[:q32].to_i
    @q33 = params[:q33].to_i
    @q34 = params[:q34].to_i
    @q35 = params[:q35].to_i
    @q36 = params[:q36].to_i
    @q37 = params[:q37].to_i
    @q38 = params[:q38].to_i
    @q39 = params[:q39].to_i
    @q40 = params[:q40].to_i

    @result = Result.new
    @result.tf = @q1 + @q9 + @q17 + @q26 + @q35
    @result.gm = @q2 + @q10 + @q21 + @q30 + @q36
    @result.au = @q3 + @q11 + @q18 + @q31 + @q38
    @result.se = @q5 + @q12 + @q19 + @q25 + @q37
    @result.ec = @q4 + @q13 + @q20 + @q29 + @q33
    @result.sv = @q7 + @q14 + @q22 + @q28 + @q34
    @result.ch = @q8 + @q15 + @q23 + @q32 + @q40
    @result.ls = @q6 + @q16 + @q24 + @q27 + @q39
    @result.user_id = current_user.id
    @result.save


    hash = {"tf" => @result.tf, "gm" => @result.gm, "au" => @result.au, "se" => @result.se, "ec" => @result.ec, "sv" => @result.sv, "ch" => @result.ch, "ls" => @result.ls}
    @maiores = hash.max_by(2){|k,v| v}
    @maior1 = @maiores[0][0]
    @maior2 = @maiores[1][0]

    @anchorinfo = Anchorinfo.where(tipo: @maior1).first
    @anchorinfo2 = Anchorinfo.where(tipo: @maior2).first

    @anchor1 = Anchor.new
    @anchor1.nome = @anchorinfo.nome
    @anchor1.descricao = @anchorinfo.descricao
    @anchor1.perfil = @anchorinfo.perfil
    @anchor1.perspectiva = @anchorinfo.perspectiva
    @anchor1.tipo = @anchorinfo.tipo
    @anchor1.result = @result
    @anchor1.save


    redirect_to @result
  end

end
