# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
    Anchorinfo.create(nome: 'Competência Técnica e Funcional', descricao: 'Pessoas que se sentem muito motivadas no exercício de seus talentos e na satisfação de saberem que
são “experts”. Pode acontecer com qualquer tipo de serviço, desde o engenheiro, analista econômico até o professor.', perfil: 'Ter grande satisfação com seu crescente conhecimento na área onde atua; Dedicar sua vida toda à especialização; - procurar um trabalho desafiador; Estar mais interessado no conteúdo intrínseco do trabalho, do que no contexto do trabalho em
si; Ser fiel a uma organização, desejando tomar parte no estabelecimento das metas; Desejar carta branca para agir, que o capacite a desempenhar a tarefa apropriadamente; A remuneração deve estar em acordo com suas aptidões, frequentemente definidas pelo
preparo educacional e experiência profissional; Além de educação contínua, esse grupo valoriza mais o reconhecimento de seus colegas do
mesmo nível profissional; Aprecia, como reconhecimento pelo seu trabalho, oportunidades educacionais, licenças para estudo, incentivos para participar de reuniões profissionais, verbas para compra de livros ou equipamentos, etc.',
perspectiva: 'Schein (1996) acredita que o grupo ancorado na Competência Técnico funcional está consciente que conhecimento e habilidade tornam-se obsoletos em um mundo tecnológico que muda dinamicamente, não encontrando por parte da empresa a garantia de educação e retreinamento continuado. O mundo necessitará constantemente de artífices e peritos em
 funções específicas diante da complexidade tecnológica, mas permanecer tecnologicamente/funcionalmente competente exigirá constante atualização e reaprendizagem no mundo organizacional, que não agüentará os custos em termos de tempo e dinheiro destes processos de atualização. Poderá haver uma aceleração dos processos de demissão de pessoas obsoletas e a substituição delas por talentos mais jovens e atualizados. Os indivíduos ocupantes de carreira terão que planejar e fazer orçamentos para sua própria aprendizagem,
 ou as organizações privadas e públicas assumirão a responsabilidade, porque, em última análise, trará vantagens para suas organizações.', tipo: 'tf')

    Anchorinfo.create(nome: 'Competência Administrativa Geral', descricao: 'A pessoa percebe que ela realmente quer se tornar uma administradora,
        a gerência por si só lhe interessa, ela avalia que tem o nível de competência requerida para a função, tem ambição para subir na hierarquia da organização onde será responsável
por decisões e planos mais importantes e que o seu próprio esforço será responsável pelo sucesso ou fracasso. As pessoas desta âncora reconhecem que devem ter conhecimentos em muitas
áreas diferentes. Os valores e motivações estão ligados aos altos graus de responsabilidade, oportunidades de liderança e alto rendimento. Suas competências devem ser: habilidade de identificar, analisar, sintetizar e resolver problemas sob condições de informação incompleta ou incerta. É comum serem chamados de “tomadores de decisão”, entretanto isto quer
dizer que eles seriam capazes de identificar e colocar os problemas para que as decisões possam ser tomadas. Têm também habilidades para influenciar, supervisionar, dirigir, ajudar e controlar as pessoas em todos os níveis da organização
afim de atingir os objetivos da empresa. O tipo de trabalho que mais lhe motiva está ligado a altos graus de responsabilidade, desafio, trabalho variado e integrativo, liderança de oportunidades para contribuir para o sucesso de sua organização.', perfil: 'Alcançar os mais altos graus de responsabilidade; Ter oportunidade de liderança e facilidade no relacionamento interpessoal; Equilíbrio emocional; Contribuir para o sucesso da organização; Receber altos rendimentos.', perspectiva: 'Segundo Schein, a necessidade de administração crescerá e será estendida para
os níveis mais baixos na administração, reduzindo o controle centralizado, que está sendo horizontalizado e replanejado em função das equipes de projeto. As habilidades da administração geral, isto é, competência analítica e interpessoal, serão, portanto, necessárias em todos os níveis da organização. Administradores de equipes, administradores de projetos e administradores de programas, além de suas habilidades técnicas, terão que desenvolver habilidades de administração geral e liderança.', tipo: 'gm')

    Anchorinfo.create(nome: 'Autonomia e Independência', descricao: 'Pessoas que percebem que não podem se sentir dependentes de outra pessoa em relação a regras, procedimentos, horário de trabalho, códigos de vestimenta, e outras normas que estão invariavelmente presentes na maioria das organizações. Estas pessoas têm necessidade de fazerem as coisas “do seu jeito”, no seu próprio passo e de acordo com seus padrões pessoais.
        Eles acham a vida na organização muito restritiva, irracional e intrusiva em sua vida privada, por isto preferem seguir a sua carreira mais independente. Geralmente escolhem profissões autônomas. O tipo de trabalho está ligado ao contrato por projetos definidos, sendo em
tempo parcial, total, ou temporário. Este tipo de pessoa gosta de trabalhar com objetivos definidos, e depois de clarificados, quer ser deixada livre para trabalhar.', perfil: 'Perceber que não pode se sentir dependente de outras pessoas em relação a regras, procedimentos, horários de trabalho, códigos de vestimenta e outras normas presentes na organização; Gostar de trabalhar com objetivos definidos, depois de clarificados, quer ser deixado livre para trabalhar.', perspectiva: 'Quanto à Autonomia/Independência, Schein (1996) considera que os
indivíduos nela ancorados acham o mundo ocupacional um lugar fácil para navegar, pois esta âncora está alinhada, pelo menos até o presente, com políticas
organizacionais, prometendo apenas empregabilidade. A autoconfiança, que pode ser
necessidade no futuro, já é parte do preparo psicológico deste grupo de pessoas.
Segundo Schein (1996), quando as pessoas envelhecem, cresce sua necessidade de
autonomia, levando a fantasias de abrir seus próprios negócios, de tornar-se
consultores, trabalhar meio-período, e, de certa maneira, procuram reduzir a
dependência de alguma organização ou trabalho particular.
            Os membros deste grupo, que já têm construído suas carreiras autônomas,
estarão bem adaptados para o futuro, mas aqueles que dependem de trabalhos
seguros e planejam desligar-se da organização podem ser altamente vulneráveis com a
atual reestruturação do mercado de trabalho, muito embora sua âncora esteja
alinhada com futuras opções.', tipo: 'au')

    Anchorinfo.create(nome: 'Segurança e Estabilidade', descricao: 'Pessoas que organizam suas carreiras para se sentirem estáveis e seguras, permitindo
assim que os futuros eventos sejam previsíveis e possam assim relaxar e prever o seu
sucesso. Geralmente estão ligados a empregos do governo ou exército, pois estes
garantem estabilidade. Muitas vezes são percebidos como “sem ambições” e podem
ser rejeitados em culturas que valorizam a ambição.
            Os mais talentosos deste grupo atingem níveis maiores na hierarquia da
organização. Os que têm talentos inusuais, se satisfazem de encontrar um hobby onde
possam realizá-los. Preferem um tipo de trabalho mais ligado ao contexto do que a
natureza do trabalho propriamente dita. Preferem ser reconhecidos por sua fidelidade,
desempenho correto que vão lhe assegurar mais estabilidade futura.', perfil: 'Ser reconhecido por sua fidelidade e performance correta, que vão assegurar
mais estabilidade futura; Tende a deixar sua carreira nas mãos de empregadores; Prefere trabalhos estáveis e previsíveis; Acredita que a lealdade contribui para o bom desempenho da empresa.', perspectiva: 'Indivíduos ancorados em Segurança/Estabilidade experimentam os mais severos
problemas, porque a mudança das políticas organizacionais de “garantia no emprego” passou para a obtenção de “segurança/empregabilidade”.  Isso significa que o ocupante de carreira ancorado em segurança/estabilidade
tem que mudar o foco de dependência da organização para dependência de si mesmo. Essa mudança implica afirmar que a única coisa que o ocupante de carreira pode
realmente esperar de uma organização é a oportunidade de aprender a ganhar experiência, a qual, presumivelmente, faz dele mais empregável em outra organização.', tipo: 'se')

    Anchorinfo.create(nome: 'Criatividade Empresarial', descricao: 'Pessoas que se sentem motivadas para criar negócios próprios através do
desenvolvimento de novos produtos e serviços, ou pela construção de novas
organizações financeiras ou ainda recriando negócios já existentes e adaptando-os às
suas especificidades. Não são somente os inventores e os artistas, nem pesquisadores
criativos, analistas de mercado ou executivos de publicidade.
            Neste grupo a criatividade surge como uma necessidade de criar novas
organizações, produtos ou serviços que podem ser identificados com os próprios
esforços do empresário que irá sobreviver por si mesmo, e que terá sucesso
econômico. “Fazer dinheiro” é a sua medida de sucesso. Geralmente são pessoas que
tem sonhos de ter seu próprio negócio desde a infância, tendo mesmo iniciado
pequenas empresas “fazedoras de dinheiro” já na adolescência. A diferença daqueles
que querem independência e autonomia é que os empresários são obstinados por
criarem a sua própria empresa, que muitas vezes deve sacrificar a autonomia e a
estabilidade antes de ter o sucesso esperado.
            O tipo de trabalho está ligado às necessidades de criar, em suas próprias
empresas, eles continuam a criar novos produtos e serviços ou eles perderão o
interesse, vendendo suas empresas e começando outra nova. O reconhecimento que
esperam é estabelecerem uma grande fortuna e uma empresa considerável.', perfil: 'Criar seus próprios negócios através de desenvolvimento de novos produtos e
serviços; Gerar dinheiro é uma medida de sucesso; Possui talento e um grau extraordinário de motivação para provar ao mundo
que é capaz.', perspectiva: 'À medida que o mundo se torna mais dinâmico e complexo, as oportunidades
para indivíduos com a âncora Criatividade Empresarial crescerão rapidamente. A
necessidade por novos produtos e serviços, derivados de tecnologias da informação e
biotecnologia, bem como a abertura de espaços para novas tecnologias, dará grande
mobilidade para o empresário, que se deslocará para qualquer parte do mundo ao
encontro de um lugar mais hospitaleiro para suas ideias.
            A Criatividade Empresarial é a principal fonte de novos trabalhos para os outros
grupos de âncoras, necessitando para tanto de um ambiente econômico, político e
cultural amigável e encorajador, que incentive novos projetos e valorize o potencial
dos acadêmicos e pesquisadores das universidades.', tipo: 'ec' )

    Anchorinfo.create(nome: 'Dedicação a uma Causa', descricao: 'Pessoas que procuram ocupações a fim de incorporarem no trabalho valores
importantes para si, mais do que seus talentos ou área de competência. Suas decisões
de carreira são feitas baseadas no desejo de fazer alguma coisa para melhorar o
mundo de alguma maneira.
            As profissões de ajuda como medicina, enfermagem, serviço social, educação
são tipicamente carreiras desta âncora onde predominam valores como: trabalhar com
as pessoas, servir a humanidade, ajudar a nação. Geralmente o tipo de trabalho deve
permitir influenciar sua organização ou o planejamento social na direção de seus
valores. O dinheiro não é importante e o que buscam como recompensa é atingir
posições com maior influência para poder operar com mais autonomia na realização
de sua causa.', perfil: 'Escolher profissões de assistência ao próximo; Deseja um trabalho que lhe permita influenciar as organizações que o emprega
ou a política social na direção de seus valores; Deseja obter reconhecimento e apoio, tanto por parte de seus colegas quanto
de seus superiores.', perspectiva: 'O número de pessoas que aparecem com esta âncora está crescendo. Tanto
pessoas jovens como pessoas de meia-idade relatam que estão sentindo a necessidade
não só de manter um rendimento adequado, mas de fazer alguma coisa mais
significativa num contexto mais amplo.
            Novos tipos de organizações e carreiras estão sendo criados para se dedicarem
a questões que preencham as lacunas entre mundo desenvolvido e subdesenvolvido,
como: problemas de raça e religião, segurança de produtos, privacidade,
superpopulação, saúde, bem-estar, etc.', tipo: 'sv')

    Anchorinfo.create(nome: 'Desafio Puro', descricao: 'As pessoas que pensam poder conquistar qualquer um ou qualquer coisa. Eles definem
sucesso como vencer obstáculos impossíveis, resolver problemas insolúveis, vencer os
oponentes mais ferrenhos. Na medida em que progridem eles procuram desafios cada
vez mais difíceis. Para alguns aparece sob a forma de procurar trabalhos nos quais ele é colocado
frente a problemas cada vez mais difíceis. Para outros o desafio é colocado em termos
de competitividade interpessoal. Geralmente procuram trabalhos nos quais podem se
sentir sempre testados, na ausência deste teste constante, sente-se aborrecidos e
desmotivados.', perfil: 'Procurar trabalhos nos quais possa se sentir sempre testado; Novidade, variedade e dificuldade tornam-se fins em si; Para alguns, o desafio é definido em termos interpessoais;
 É comum destacar a importância da diversidade de sua carreira.', perspectiva: 'Tem havido sempre um grupo de pessoas que definiu suas âncoras em
termos de superar probabilidades impossíveis, revolver problemas insolúveis e vencer
competidores. Segundo Schein (1996), este grupo está crescendo em número, mas não
está claro se mais pessoas estão ingressando na força de trabalho com esta
predisposição ou se é uma adaptação para desafios crescentes que o mundo está
apresentando.', tipo: 'ch')

    Anchorinfo.create(nome: 'Estilo de Vida', descricao: 'Pessoas que consideram a carreira menos importante e que esta deve estar integrada
num estilo de vida. É principalmente voltada a encontrar uma maneira de integrar as
necessidades individuais, familiares e da carreira, para isto a pessoa quer flexibilidade
mais do que qualquer outra coisa.
            A pessoa olha mais para a atitude da empresa do que para o seu programa de
trabalho propriamente dito, uma atitude que reflete respeito pela vida pessoal e
familiar e que permite uma negociação genuína do contrato psicológico possível.', perfil: 'Prefere flexibilidade acima de tudo; Exige que a carreira esteja integrada com o estilo de vida; Busca uma atitude organizacional que reflita respeito pelos interesses pessoais
e familiares; Esta âncora reflete algumas tendências da sociedade, sendo o resultado inevitável de famílias em que pai e mãe trabalham.', perspectiva: 'Estilo de Vida é a âncora que tem mostrado as maiores mudanças desde sua
pesquisa original, nos anos de 1960 e 1970. O progresso e a posição organizacional
estão cada vez mais definidos em termos do que as pessoas conhecem e quais
habilidades as pessoas possuem, e são baseados cada vez menos em tempo de serviço,
hierarquia e lealdade. Para manter seus melhores empregados, as organizações
devem, portanto, estar aptas para desafiá-los e então satisfazer suas necessidades. Ao fazer uma análise sobre mudanças e estruturas das âncoras de carreira para
o século XXI, Schein (1996) argumenta que cada categoria de âncora ainda atrai um
conjunto de pessoas, mas que o funcionamento de uma dada âncora pode tornar-se
problemática à medida que o mundo e a estrutura organizacional tornam-se mais
turbulentos. O principal efeito é que as pessoas terão que se tornar mais
autoconfiantes e descobrirem onde suas âncoras melhor se encaixam dentro de uma
estrutura ocupacional emergente. A habilidade para analisar a si mesmo, bem como a
habilidade de descobrir que tipo de trabalho está disponível e como esse trabalho
evoluirá, torna-se uma habilidade crucial.', tipo: 'ls')