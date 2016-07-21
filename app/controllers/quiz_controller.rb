    class QuizController < ApplicationController
  def index
    @data_final = params[:data_final]
  end

  def answer
    @all = params.select{|key, hash| hash == "on"}.keys
    @extras = []
    @all.each do |e|
        @extras << e.dup
    end
    @extras.each do |x|
        x.slice!(0,5)
    end
    @todas = params.select{|key, hash| hash != "on" && key != "commit" && key != "controller" && key != "action" && key != "utf8" && key != "authenticity_token"}
    @todas.each {|k,v| @todas[k] = v.to_f}
    @todas.each do |key, value|
        @extras.each do |x|
            if key == x
                @todas[key] = value + 2
            end
         end
    end

    q1 = @todas[:q1]
    q2 = @todas[:q2]
    q3 = @todas[:q3]
    q4 = @todas[:q4]
    q5 = @todas[:q5]
    q6 = @todas[:q6]
    q7 = @todas[:q7]
    q8 = @todas[:q8]
    q9 = @todas[:q9]
    q10 = @todas[:q10]
    q11 = @todas[:q11]
    q12 = @todas[:q12]
    q13 = @todas[:q13]
    q14 = @todas[:q14]
    q15 = @todas[:q15]
    q16 = @todas[:q16]
    q17 = @todas[:q17]
    q18 = @todas[:q18]
    q19 = @todas[:q19]
    q20 = @todas[:q20]
    q21 = @todas[:q21]
    q22 = @todas[:q22]
    q23 = @todas[:q23]
    q24 = @todas[:q24]
    q25 = @todas[:q25]
    q26 = @todas[:q26]
    q27 = @todas[:q27]
    q28 = @todas[:q28]
    q29 = @todas[:q29]
    q30 = @todas[:q30]
    q31 = @todas[:q31]
    q32 = @todas[:q32]
    q33 = @todas[:q33]
    q34 = @todas[:q34]
    q35 = @todas[:q35]
    q36 = @todas[:q36]
    q37 = @todas[:q37]
    q38 = @todas[:q38]
    q39 = @todas[:q39]
    q40 = @todas[:q40]


    @result = Result.new
    @result.tf = (q1 + q9 + q17 + q26 + q35) / 5.0
    @result.gm = (q2 + q10 + q21 + q30 + q36)/ 5.0
    @result.au = (q3 + q11 + q18 + q31 + q38)/ 5.0
    @result.se = (q5 + q12 + q19 + q25 + q37)/ 5.0
    @result.ec = (q4 + q13 + q20 + q29 + q33)/ 5.0
    @result.sv = (q7 + q14 + q22 + q28 + q34)/ 5.0
    @result.ch = (q8 + q15 + q23 + q32 + q40)/ 5.0
    @result.ls = (q6 + q16 + q24 + q27 + q39)/ 5.0
    @result.user_id = current_user.id
    @result.data_final = params[:data_final]
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

    @anchor2 = Anchor.new
    @anchor2.nome = @anchorinfo2.nome
    @anchor2.descricao = @anchorinfo2.descricao
    @anchor2.perfil = @anchorinfo2.perfil
    @anchor2.perspectiva = @anchorinfo2.perspectiva
    @anchor2.tipo = @anchorinfo2.tipo
    @anchor2.result = @result
    @result.data_final = params[:data_final]
    @anchor2.save


    redirect_to @result
  end

end
