* ############################################################ *
*          ___ Sumário ___                                     *
*      01) Definições dos Conjuntos;                           *
*      02) Leitura da SAM;                                     *
*      03) Calibração dos Valores Iniciais;                    *
*      04) O Modelo;                                           *
*      05) Inicialização de Variáveis;                         *
*      06) Define e resolve o Modelo;                          *
*      07) Recursividade: BAU (Contra-factual);                *
*      08) Reinicialização de Variáveis;                       *
*      09) Recursividade: Choque do Lockdown;                  *
*            pop('F1') = -0.0434 ->  0.0454                    *
*            pop('F2') =  0.0386 -> -0.0371                    *
*            pop('F3') =  0.0343 -> -0.0332                    *
*      10) Computação das Diferenças.                          *
*      !!) mudança na atualização de Sc e Sw, estava errada:   *
*  Sc.l*( sum((fl,h),FF0(fl,h,t)) / sum((fl,h), FF00(fl,h)) )  *
*  Sw.l*( sum((fl,h),FF0(fl,h,t)) / sum((fl,h), FF00(fl,h)) )  *
*                         to:                                  *
*  Sc00*( sum((fl,h),FF0(fl,h,t)) / sum((fl,h), FF00(fl,h)) )  *
*  Sw00*( sum((fl,h),FF0(fl,h,t)) / sum((fl,h), FF00(fl,h)) )  *
* ############################################################ *


option limRow = 0, limCol = 0;

$offSymXRef offSymList

* === Definições dos Conjuntos =================================================

Set
       u             'Entrada Sam'  / AGR, IND, SRV, K, L1, L2, L3, ICMS, Out,
                                      IM, F1, F2, F3, GOV, INV, ROW, ROB /
       i(u)          'Setores'      / AGR, IND, SRV /
       h(u)          'Fatores'      / K, L1, L2, L3 /
       h_mob(h)      'Fator Móvel'  /    L1, L2, L3 /
       h_imm(h)      'Fator Imóvel' / K             /
       fl(u)         'Famílias'     /    F1, F2, F3 /
       t             'Tempo'        /     1*20      /;

Alias (u,v), (i,j), (h,k), (fl,l);

option decimals = 8;

* === Leitura da SAM  ==========================================================

Parameter   SAM(u,v)        Matriz de Contabilidade Social;
$gdxin samPrinc.gdx
$load sam
$gdxin

* === Parâmetros da Dinâmica ===================================================

Parameter
      ror            'Tx de Retorno do Capital'
      dep            'Tx de Depreciação'
      pop(fl)        'Tx de Crescimento Populacional'
      zeta           'Parâmetro de Elasticidade da Aloca��o de Investimento'
;
ror       = 0.125;
dep       = 0.04;
pop('F1') = -0.0434;
pop('F2') =  0.0386;
pop('F3') =  0.0343;
zeta      = 2;

* === Valores Iniciais =========================================================
Parameter
* 1) --- Ano Base --------------------------------------------------------------
       FF00(fl,h)    'Dotação do Fator de Produção'
       shrK00(fl)    'Partilha da Remuneração de Capital'
       F00(h,j)      'Fator de Produção'
       Y00(j)        'Fator Composto'
       X00(i,j)      'Insumo Intermediário'
       Z00(j)        'Produção Estadual Bruta'
       Qs00(i)       'Produto Bruto demandado p Formar o Bem Final'

       Xc00(i)       'Exportações Nacionais'
       Xw00(i)       'Exportações Mundiais'
       Mc00(i)       'Importações Nacionais'
       Mw00(i)       'Importações Mundiais'

       Sg00          'Poupança do Governo'
       Ss00(fl)      'Poupança Privada'
       Sc00          'Poupança Nacional (Resto do Brasil)'
       Sw00          'Poupança Externa'

       III00         'Investimento Total Demandado'
       II00(j)       'Investimento Setorial'
       KK00(j)       'Estoque de Capital'

       Tdh00(fl)     'Arrecadação com Imposto de Renda'
       Ti00(j)       'Arrecadação com ICMS'
       To00(j)       'Arrecadação com outros impostos'
       Tm00(j)       'Arrecadação com imposto sobre importados'
       taudh00(fl)   'Alíquota de Imposto de Renda'
       taui00(i)     'Alíquota ICMS'
       tauo00(i)     'Alíquota Outros impostos'
       taum00(i)     'Alíquota sobre Prod. Estrangeiros importados'
       trh00(fl)     'Transferência do Governo p Famílias'

       Cf00(i,fl)    'Consumo Final das Famílias no Estado'
       Gf00(i)       'Consumo Final do Governo no Estado'
       In00(i)       'Demanda Final por Investimento no Estado'
       Qf00(i)       'Oferta de bem Composto Final p o Estado'

       pUSxw00(i)    'Preço das Exportações em moeda nacional'
       pUSmw00(i)    'Preço das Importações em moeda nacional'
       pBRxc00(i)    'Preço de exportação p o resto do Brasil'
       pBRmc00(i)    'Preço de importação p o resto do Brasil'

* 2) --- Base Temporal ---------------------------------------------------------
       FF0(fl,h,t)   'Dotação do Fator de Produção'
       shrK0(fl,t)   'Partilha da Remuneração de Capital'
       F0(h,j,t)     'Fator de Produção'
       Y0(j,t)       'Fator Composto'
       X0(i,j,t)     'Insumo Intermediário'
       Z0(j,t)       'Produção Estadual Bruta'
       Qs0(i,t)      'Demanda Estadual do Bem Bruto'

       Xc0(i,t)      'Exportações Nacionais'
       Xw0(i,t)      'Exportações Mundiais'
       Mc0(i,t)      'Importações Nacionais'
       Mw0(i,t)      'Importações Mundiais'

       Sg0(t)        'Poupança do Governo'
       Ss0(fl,t)     'Poupança Privada'
       Sc0(t)        'Poupança Nacional (Resto do Brasil)'
       Sw0(t)        'Poupança Externa'

       III0(t)       'Investimento Total Demandado'
       II0(j,t)      'Investimento Setorial'
       KK0(j,t)      'Estoque de Capital'
       shrII0(i,t)   'Divisão do Intestimento Imobilizado por Setor'

       Tdh0(fl,t)    'Arrecadação com Imposto de Renda'
       Ti0(j,t)      'Arrecadação com ICMS'
       To0(j,t)      'Arrecadação com outros impostos'
       Tm0(j,t)      'Arrecadação com imposto sobre importados'
       trh0(fl,t)    'Transferência do Governo p Famílias'

       Cf0(i,fl,t)   'Consumo Final das Famílias no Estado'
       Gf0(i,t)      'Consumo Final do Governo no Estado'
       In0(i,t)      'Demanda Final por Investimento no Estado'
       Qf0(i,t)      'Oferta de bem Composto Final p o Estado'

       pxW0(i,t)     'Preço das Exportações Internacionais ajustado pela margem'
       pmW0(i,t)     'Preço das Importações Internacionais ajustado pela margem'
       pxC0(i,t)     'Preço das Exportações Nacionais ajustado pela margem'
       pmC0(i,t)     'Preço das Importações Nacionais ajustado pela margem'

       mgW0(t)       'Margem Externa (+Tx de câmbio)'
       mgC0(t)       'Margem Nacional'

       pf0(h,j,t)    'Preço do Fator de Produção'
       py0(j,t)      'Preço do Fator Composto'
       pz0(j,t)      'Preço de Oferta do Produto Estadual Bruto'
       pqs0(i,t)     'Preço do Bem Composto Estadual'
       pqf0(i,t)     'Preço do Bem Final Estadual'
       pk0(t)        'Preço dos Bens de Investimento Composto'
       PRICE0(t)     'índice de Preço'

       UU0(fl,t)     'Utilidade das Famílias'
       US0(t)        'Utilidade Social'

* 3) --- Compara��o Temporal ---------------------------------------------------
       FF1(fl,h,t)   'Dotação do Fator de Produção'
       shrK1(fl,t)   'Partilha da Remuneração de Capital'
       F1(h,j,t)     'Fator de Produção'
       Y1(j,t)       'Fator Composto'
       X1(i,j,t)     'Insumo Intermediário'
       Z1(j,t)       'Produção Estadual Bruta'
       Qs1(i,t)      'Demanda Estadual do Bem Bruto'

       Xc1(i,t)      'Exportações Nacionais'
       Xw1(i,t)      'Exportações Mundiais'
       Mc1(i,t)      'Importações Nacionais'
       Mw1(i,t)      'Importações Mundiais'

       Sg1(t)        'Poupança do Governo'
       Ss1(fl,t)     'Poupança Privada'
       Sc1(t)        'Poupança Nacional (Resto do Brasil)'
       Sw1(t)        'Poupança Externa'

       III1(t)       'Investimento Total Demandado'
       II1(j,t)      'Investimento Setorial'
       KK1(j,t)      'Estoque de Capital'
       shrII1(i,t)   'Divisão do Intestimento Imobilizado por Setor'

       Tdh1(fl,t)    'Arrecadação com Imposto de Renda'
       Ti1(j,t)      'Arrecadação com ICMS'
       To1(j,t)      'Arrecadação com outros impostos'
       Tm1(j,t)      'Arrecadação com imposto sobre importados'
       trh1(fl,t)    'Transferência do Governo p Famílias'

       Cf1(i,fl,t)   'Consumo Final das Famílias no Estado'
       Gf1(i,t)      'Consumo Final do Governo no Estado'
       In1(i,t)      'Demanda Final por Investimento no Estado'
       Qf1(i,t)      'Oferta de bem Composto Final p o Estado'

       pxW1(i,t)     'Preço das Exportações Internacionais ajustado pela margem'
       pmW1(i,t)     'Preço das Importações Internacionais ajustado pela margem'
       pxC1(i,t)     'Preço das Exportações Nacionais ajustado pela margem'
       pmC1(i,t)     'Preço das Importações Nacionais ajustado pela margem'

       mgW1(t)       'Margem Externa (+Tx de câmbio)'
       mgC1(t)       'Margem Nacional'

       pf1(h,j,t)    'Preço do Fator de Produção'
       py1(j,t)      'Preço do Fator Composto'
       pz1(j,t)      'Preço de Oferta do Produto Estadual Bruto'
       pqs1(i,t)     'Preço do Bem Composto Estadual'
       pqf1(i,t)     'Preço do Bem Final Estadual'
       pk1(t)        'Preço dos Bens de Investimento Composto'
       PRICE1(t)     'índice de Preço'

       UU1(fl,t)     'Utilidade das Famílias'
       US1(t)        'Utilidade Social'
;

FF00(fl,h)     = SAM(fl,h);
shrK00(fl)     = FF00(fl,'K')/sum(l, FF00(l,'K'));
F00(h,j)       = SAM(h,j);
Y00(j)         = sum(h, F00(h,j));
X00(i,j)       = SAM(i,j);
Z00(j)         = Y00(j) + sum(i, X00(i,j));

*Xc00(i)       = SAM(i,"ROB");
Xw00(i)        = SAM(i,"ROW");
Mc00(i)        = SAM("ROB",i);
Mw00(i)        = SAM("ROW",i);

Sg00           = SAM("INV","GOV");
Ss00(fl)       = SAM("INV",fl);
*Sc00          = SAM("INV","ROB");
Sw00           = SAM("INV","ROW");

Tdh00(fl)      = SAM("GOV",fl);
Ti00(j)        = SAM("ICMS",j);
To00(j)        = SAM("Out",j);
Tm00(j)        = SAM("IM",j);

taudh00(fl)    = Tdh00(fl)/sum(h,FF00(fl,h));
taui00(i)      = Ti00(i)/Z00(i);
tauo00(i)      = To00(i)/Z00(i);
taum00(i) $ (Mw00(i)>0) = Tm00(i)/Mw00(i);

trh00(fl)      = SAM(fl,"GOV");

Cf00(i,fl)     = SAM(i,fl);
Gf00(i)        = SAM(i,"GOV");
*In00(i)       = SAM(i,"INV");

pUSxw00(i)     = 1;
pUSmw00(i)     = 1;
pBRxc00(i)     = 1;
pBRmc00(i)     = 1;

* --- Ajustando o Investimento da SAM e Realocando no ROB ----------------------
Parameter
       III_ASS(fl)   'Investimento requerido p o crescimento'
       III_SAM       'Investimento observado na SAM'
       adj           'III_ASS vs. III_SAM [>1]'
;
III_ASS(fl)    = ((pop(fl) + dep)/ror) * FF00(fl,'K');
III_SAM        = sum(i, SAM(i,"INV"));
adj            = sum(fl, III_ASS(fl))/III_SAM;

In00(i)        = SAM(i,"INV") * adj;

Xc00(i)        = SAM(i,"ROB") - (In00(i) - SAM(i,"INV"));
Sc00           = sum(i,Mc00(i))  - sum(i,Xc00(i));

III00          = sum(i, In00(i));
II00(j)        = (sum(fl,Ss00(fl)) +Sg00+Sc00+Sw00) * (F00("K",j)/sum(i, F00("K",i)));
KK00(j)        = F00("K",j)/ror;

display III_ASS, III_SAM, adj, In00, Xc00, Sc00, III00, II00, KK00;

* --- Calibração ---------------------------------------------------------------
Parameter
       beta(h,j)     'Participação na Função Produção do Fator Composto'
       b(j)          'PTF da Função de Produção do Fator Composto'
       ax(i,j)       'Coef. de Conversão do Insumo Intermediário'
       ay(j)         'Coef. de Conversão do Fator Composto'

       sigma(i)      'Elast. de Substituição e Transformação (CES e CET)'

       deltamc(i)    'Participação na CES do Resto do Brasil'
       deltamw(i)    'Participação na CES do Resto do Mundo'
       deltaqs(i)    'Participação na CES do Estado'
       gamma(i)      'PTF da Função CES'
       eta(i)        'Elasticidade de Substituição da CES'

       xiqs(i)       'Participação na CET Estadual'
       xixc(i)       'Participação na CET do Resto do Brasil'
       xixw(i)       'Participação na CET do Resto do Mundo'
       theta(i)      'PTF da Função CET'
       phi(i)        'Elasticidade de Transformação da CET'

       sss(fl)       'Propens�o Média a Poupar da Família'
       ssg           'Propens�o Média a Poupar do Governo'

       alpha(i,fl)   'Participação na Função Utilidade'
       a(fl)         'PTF da Função Utilidade'

       mu(i)         'Participação do Consumo do Governo'
       lambda(i)     'Participação da Demanda por Investimento'
       iota          'PTF da Função de Produção dos Investimentos Compostos'

;
*Calibração de Parâmetros da Família:

alpha(i,fl)    = Cf00(i,fl)/sum(j,Cf00(j,fl));
a(fl)          = sum(i,Cf00(i,fl))/prod(j, Cf00(j,fl)**alpha(j,fl));
sss(fl)        = Ss00(fl) / (sum(h,FF00(fl,h)) + trh00(fl) - Tdh00(fl));

*Calibração de Parâmetros do Investimento:

lambda(i)      = In00(i)/(Sg00 + sum(fl,Ss00(fl)) + Sc00 + Sw00);
iota           = III00/prod(i, In00(i)**lambda(i));

*Calibração de Parâmetros do Governo:

mu(i)          = Gf00(i)/sum(j,Gf00(j));
ssg            = Sg00/(sum(fl,Tdh00(fl))+sum(i,Ti00(i)+Tm00(i)+To00(i)));

*Calibração de Parâmetros da Produção (1o Est�gio):

beta(h,j)      = F00(h,j)/sum(k,F00(k,j));
b(j)           = Y00(j)/prod(k,F00(k,j)**beta(k,j));
ax(i,j)        = X00(i,j)/Z00(j);
ay(j)          = Y00(j)/Z00(j);

*Calibração de Parâmetros da Produção (2o Est�gio - CES):

sigma(i)       = 2;
eta(i)         = (sigma(i)-1)/sigma(i);

* ---
Qs00(i)        = (Z00(i)*(1+taui00(i)+tauo00(i))-Xc00(i)-Xw00(i));
Qf00(i)        = ((1+taum00(i))*Mw00(i)) + Mc00(i) + Qs00(i);
* ---

deltamc(i)     = Mc00(i)**(1-eta(i))/(Mc00(i)**(1-eta(i))+ (1+taum00(i))*Mw00(i)**
                 (1-eta(i))+(1+taui00(i)+tauo00(i))*Qs00(i)**(1-eta(i)));
deltamw(i)     = (1+taum00(i))*Mw00(i)**(1-eta(i))/(Mc00(i)**(1-eta(i))+
                 (1+taum00(i))*Mw00(i)**(1-eta(i))+
                 (1+taui00(i)+tauo00(i))*Qs00(i)**(1-eta(i)));
deltaqs(i)     = 1-deltamc(i)-deltamw(i);
gamma(i)       = Qf00(i)/((deltaqs(i)*Qs00(i)**eta(i)+deltamc(i)*Mc00(i)**eta(i)+
                 deltamw(i)*Mw00(i)**eta(i))**(1/eta(i)));

*Calibração de Parâmetros da Produção (3o Est�gio - CET):

phi(i)         = (sigma(i)+1)/sigma(i);
xixw(i)        = (Xw00(i)**(1-phi(i))/((1+taui00(i)+tauo00(i))*Qs00(i)**(1-phi(i))+
                 Xc00(i)**(1-phi(i))+Xw00(i)**(1-phi(i)))) $ (Xw00(i)>0)
                 + 0 $ (Xw00(i)=0);
xixc(i)        = (Xc00(i)**(1-phi(i))/((1+taui00(i)+tauo00(i))*Qs00(i)**(1-phi(i))+
                 Xc00(i)**(1-phi(i))+Xw00(i)**(1-phi(i)))) $ ((Xc00(i)>0) and (Xw00(i)>0)) +
                 (Xc00(i)**(1-phi(i))/((1+taui00(i)+tauo00(i))*Qs00(i)**(1-phi(i))+ Xc00(i)**
                 (1-phi(i)))) $ ((Xc00(i)>0) and (Xw00(i)=0)) +
                 0 $ ((Xc00(i)=0) and (Xw00(i)>0)) +  0 $ ((Xc00(i)=0) and (Xw00(i)=0));
xiqs(i)        = 1-xixw(i)-xixc(i);
theta(i)       = Z00(i)/((xiqs(i)*Qs00(i)**phi(i)+xixc(i)*Xc00(i)**phi(i)+ xixw(i)*
                 Xw00(i)**phi(i))**(1/phi(i)));

display 	FF00, F00, Y00, X00, Z00, Qs00, Xw00, Mc00, Mw00, Sg00, Ss00, Sw00, Tdh00, Ti00,
          To00, Tm00, Qf00, taudh00, taui00, tauo00, taum00, trh00, Cf00,
          Gf00, In00, pUSxw00, pUSmw00, pBRxc00, pBRmc00;
display   beta, b, ax, ay, sigma, deltamc, deltamw, deltaqs, gamma, eta, xiqs, xixc,
          xixw, theta, phi, sss, ssg, alpha, a, mu, lambda, iota;

* --- Computando o BAU ---------------------------------------------------------

* === O Modelo =================================================================
Variable
       FF(fl,h)      'Dotação das Famílias'
       shrK(fl)      'Partilha da Remuneração de Capital'
       F(h,j)        'Fator de Produção'
       Y(j)          'Fator Composto'
       X(i,j)        'Insumo Intermediário'
       Z(j)          'Oferta Estadual do Bem Bruto'
       Qs(i)         'Demanda Estadual do Bem Bruto'

       Mc(i)         'Importações Nacionais'
       Mw(i)         'Importações Mundiais'
       Xc(i)         'Exportações p o Resto do Pa�s'
       Xw(i)         'Exportações p o Resto do Mundo'

       Ss(fl)        'Poupança da Família'
       Sg            'Poupança do Governo Estadual'
       Sc            'Poupança Nacional (Resto do Brasil)'
       Sw            'Poupança Internacional'

       KK(j)         'Estoque de Capital'
       II(j)         'Investimento Setorial'
       III           'Investimento Composto Total Demandado'

       Ti(j)         'Receita do ICMS'
       Tm(j)         'Receita do Imposto sobre Importados do RM'
       To(j)         'Receita de Outros Impostos'
       Tdh(fl)       'Receita do Imposto de Renda'
       trh(fl)       'Transferência do Governo p Famílias'

       Cf(i,fl)      'Consumo da Família'
       Gf(i)         'Consumo do Governo Estadual'
       In(i)         'Demanda de Investimento'
       Qf(i)         'Oferta Final'

       pf(h,j)       'Preço do Fator de Produção'
       py(j)         'Preço do Fator Composto'
       pz(j)         'Preço de Oferta do Produto Estadual Bruto'
       pqs(i)        'Preço do Bem Composto Estadual'
       pqf(i)        'Preço do Bem Final Estadual'
       pk            'Preço dos Bens de Investimento Composto'
       PRICE         'índice de Preços'

       pxW(i)        'Preço das Exportações Internacionais ajustado pela margem'
       pmW(i)        'Preço das Importações Internacionais ajustado pela margem'
       pxC(i)        'Preço das Exportações Nacionais ajustado pela margem'
       pmC(i)        'Preço das Exportações Nacionais ajustado pela margem'
       mgW           'Margem Externa (+Tx de câmbio)'
       mgC           'Margem Nacional'

       UU(fl)        'Utilidade [Fictícia]'
       US            'Utilidade Social'
       ;
Equation
       eqF(h,j)      'Função de Demanda por Fatores de Produção'
       eqX(i,j)      'Função Demanda dos Insumos Intermediários'
       eqY(j)        'Função de Demanda pelo Fator Composto'
       eqZ(j)        'Função de Oferta do Produto Estadual Bruto'
       eqQs(i)       'Função de Demanda pelo Produto Estadual Bruto'

       eqMc(i)       'Função de Demanda por Importados Nacionais'
       eqMw(i)       'Função de Demanda por Importados Estrangeiros'
       eqXc(i)       'Oferta de Exportações p o Resto do Brasil'
       eqXw(i)       'Oferta de Exportações p o Exterior'

       eqCf1(i,fl)   'Função de Demanda da Família'
       eqCf2(i,fl)   'Função de Demanda da Família'
       eqCf3(i,fl)   'Função de Demanda da Família'
       eqGf(i)       'Função de Demanda do Governo'
       eqQf(i)       'Função de Oferta do Produto Final'

       eqTi(j)       'Função Receita do Imposto ICMS'
       eqTm(j)       'Função Receita sobre importados'
       eqTo(j)       'Função Receita de Outros Impostos'
       eqTdh1(fl)    'Função Receita do Imposto de Renda'
       eqTdh2(fl)    'Função Receita do Imposto de Renda'
       eqTdh3(fl)    'Função Receita do Imposto de Renda'


       eqSs1(fl)     'Função Poupança da Família'
       eqSs2(fl)     'Função Poupança da Família'
       eqSs3(fl)     'Função Poupança da Família'
       eqSg          'Função Poupança do Governo'

       eqIn(i)       'Função de Demanda Por Investimentos'
       eqII(j)       'Função de Repartição dos Novos Investimentos'
       eqIII         'Função de Produção do Investimento Composto'
       eqIIeq        'Função de Equilíbrio de Investimento'
       eqKK(j)       'Função de Uso do Estoque de Capital'
       eqFF1(h_mob)  'Equilíbrio entre Dotação e Trabalho Demandado'
       eqFF2(h_mob)  'Equilíbrio entre Dotação e Trabalho Demandado'
       eqFF3(h_mob)  'Equilíbrio entre Dotação e Trabalho Demandado'
       eqFFCC1(fl)   'Função de Equilíbrio Or�ament�rio das Famílias'
       eqFFCC2(fl)   'Função de Equilíbrio Or�ament�rio das Famílias'
       eqFFCC3(fl)   'Função de Equilíbrio Or�ament�rio das Famílias'
       eqpf(h_mob,i,j) 'Fechamento de Preço do Fator Trabalho'

       eqpy(j)       'Função de Oferta do Fator Composto'
       eqpz(j)       'Função Custo unit�rio de Produção'
       eqpqs(i)      'Função de Oferta de Bens Locais'
       eqpqf(i)      'Equalização de Quantidades Locais'
       eqpxW(i)      'Preço das Exportações Internacionais ajustado pela margem'
       eqpmW(i)      'Preço das Importações Internacionais ajustado pela margem'
       eqpxC(i)      'Preço das Exportações Nacionais ajustado pela margem'
       eqpmC(i)      'Preço das Importações Nacionais ajustado pela margem'
       eqFore        'Equação de Equilíbrio de BP'
       eqPRICE       'Equação do índice de Preços'

       eqU(fl)       'Função Utilidade da fl-�sima Família'
       obj           'Função Utilidade [fictícia]'
;
* --- [Produção Dom�stica] -----------------------------------------------------
eqpy(j)..      Y(j)    =e= b(j)*prod(h, F(h,j)**beta(h,j));
eqF(h,j)..     F(h,j)  =e= beta(h,j)*py(j)*Y(j) / pf(h,j);
eqX(i,j)..     X(i,j)  =e= ax(i,j)*Z(j);
eqY(j)..       Y(j)    =e= ay(j)*Z(j);
eqpz(j)..      pz(j)   =e= ay(j)*py(j)+sum(i,ax(i,j)*pqf(i));

* --- [CES] --------------------------------------------------------------------
eqQf(i)..      Qf(i)   =e= gamma(i)*(deltaqs(i)*Qs(i)**eta(i) +
                                     deltamc(i)*Mc(i)**eta(i) +
                                     deltamw(i)*Mw(i)**eta(i))**(1/eta(i));
eqQs(i)..      Qs(i)   =e= Qf(i)*(deltaqs(i)*pqf(i)*gamma(i)**eta(i)/
                           pqs(i))**(1/(1-eta(i)));
eqMc(i)..      Mc(i)   =e= Qf(i)*(deltamc(i)*pqf(i)*gamma(i)**eta(i)/
                           pmC(i))**(1/(1-eta(i)));
eqMw(i)..      Mw(i)   =e= Qf(i)*(deltamw(i)*pqf(i)*gamma(i)**eta(i)/
                           (1+taum00(i))*pmW(i))**(1/(1-eta(i)));

* --- [CET] --------------------------------------------------------------------
eqZ(i)..       Z(i)    =e= theta(i)*(xiqs(i)*Qs(i)**phi(i) +
                                     xixc(i)*Xc(i)**phi(i) +
                                     xixw(i)*Xw(i)**phi(i))**(1/phi(i));
eqpqs(i)..     Qs(i)   =e= Z(i)*(theta(i)**phi(i)*xiqs(i)*(1+taui00(i)+tauo00(i))*pz(i)/
                           pqs(i))**(1/(1-phi(i)));
eqXc(i)..      Xc(i)   =e= (Z(i)*(theta(i)**phi(i)*xixc(i)*(1+taui00(i)+tauo00(i))*pz(i)/
                           pxC(i))**(1/(1-phi(i))));
eqXw(i)..      Xw(i)   =e= (Z(i)*(theta(i)**phi(i)*xixw(i)*(1+taui00(i)+tauo00(i))*pz(i)/
                           pxW(i))**(1/(1-phi(i))));


* --- [Governo] ----------------------------------------------------------------
eqTdh1('F1')..    Tdh('F1')  =e= taudh00('F1') * (sum(j, pf('L1',j)*F('L1',j))
                                                 + shrK('F1')*sum(j, pf('K',j)*F('K',j)));
eqTdh2('F2')..    Tdh('F2')  =e= taudh00('F2') * (sum(j, pf('L2',j)*F('L2',j))
                                                 + shrK('F2')*sum(j, pf('K',j)*F('K',j)));
eqTdh3('F3')..    Tdh('F3')  =e= taudh00('F3') * (sum(j, pf('L3',j)*F('L3',j))
                                                 + shrK('F3')*sum(j, pf('K',j)*F('K',j)));
eqTm(j)..         Tm(j)      =e= taum00(j) * pmW(j) * Mw(j);
eqTi(j)..         Ti(j)      =e= taui00(j) * pz(j) * Z(j);
eqTo(j)..         To(j)      =e= tauo00(j) * pz(j) * Z(j);
eqSg..            Sg         =e= ssg* (sum(fl,Tdh(fl)-trh(fl)) + sum(j,Tm(j)+Ti(j)+To(j)) );
eqGf(i)..         Gf(i)      =e= (mu(i)/pqf(i)) * (sum(fl,Tdh(fl)-trh(fl))
                                                    + sum(j,Tm(j)+Ti(j)+To(j))-Sg);


* --- [Famílias] --------------------------------------------------------------
eqSs1('F1')..    Ss('F1')   =e= sss('F1')* (sum(j, pf('L1',j)*F('L1',j))
                                                 + shrK('F1')*sum(j, pf('K',j)*F('K',j))
                                                 + trh('F1') - Tdh('F1'));
eqSs2('F2')..    Ss('F2')   =e= sss('F2')* (sum(j, pf('L2',j)*F('L2',j))
                                                 + shrK('F2')*sum(j, pf('K',j)*F('K',j))
                                                 + trh('F2') - Tdh('F2'));
eqSs3('F3')..    Ss('F3')   =e= sss('F3')* (sum(j, pf('L3',j)*F('L3',j))
                                                 + shrK('F3')*sum(j, pf('K',j)*F('K',j))
                                                 + trh('F3') - Tdh('F3'));
eqCf1(i,'F1')..  Cf(i,'F1') =e= (alpha(i,'F1')/pqf(i)) * ( sum(j, pf('L1',j)*F('L1',j))
                                                 + shrK('F1')*sum(j, pf('K',j)*F('K',j))
                                                 - Ss('F1') - Tdh('F1') + trh('F1') );
eqCf2(i,'F2')..  Cf(i,'F2') =e= (alpha(i,'F2')/pqf(i)) * ( sum(j, pf('L2',j)*F('L2',j))
                                                 + shrK('F2')*sum(j, pf('K',j)*F('K',j))
                                                 - Ss('F2') - Tdh('F2') + trh('F2') );
eqCf3(i,'F3')..  Cf(i,'F3') =e= (alpha(i,'F3')/pqf(i)) * ( sum(j, pf('L3',j)*F('L3',j))
                                                 + shrK('F3')*sum(j, pf('K',j)*F('K',j))
                                                 - Ss('F3') - Tdh('F3') + trh('F3') );

* --- [Investimento] -----------------------------------------------------------
eqIn(i)..      In(i)    =e= lambda(i)*pk*sum(j, II(j))/pqf(i);
eqII(j)..      pk*II(j) =e= (pf("K",j)**zeta*F("K",j) / sum(i,pf("K",i)**zeta*F("K",i))) * (Sg + sum(fl,Ss(fl)) + mgC*Sc + mgW*Sw);
eqIII..        III      =e= iota*prod(i, In(i)**lambda(i));
eqKK(j)..      F("K",j) =e= ror*KK(j);

* --- [Market Clearing] --------------------------------------------------------
eqIIeq..           III               =e= sum(j, II(j));
eqFF1("L1")..      sum(j,F("L1",j))  =e= FF('F1',"L1");
eqFF2("L2")..      sum(j,F("L2",j))  =e= FF('F2',"L2");
eqFF3("L3")..      sum(j,F("L3",j))  =e= FF('F3',"L3");
eqpf(h_mob,i,j)..  pf(h_mob,j)       =e= pf(h_mob,i);
eqFore..            Sc + Sw          =e= sum(i,pBRmc00(i)*Mc(i))-sum(i,pBRxc00(i)*Xc(i)) +
                                         sum(i,pUSmw00(i)*Mw(i))-sum(i,pUSxw00(i)*Xw(i));
eqFFCC1('F1')..   sum(i,pqf(i)*Cf(i,'F1')) =e= sum(j, pf('L1',j)*F('L1',j))
                                               + shrK('F1')*sum(j, pf('K',j)*F('K',j))
                                               + trh('F1') - (Tdh('F1') + Ss('F1'));
eqFFCC2('F2')..   sum(i,pqf(i)*Cf(i,'F2')) =e= sum(j, pf('L2',j)*F('L2',j))
                                               + shrK('F2')*sum(j, pf('K',j)*F('K',j))
                                               + trh('F2') - (Tdh('F2') + Ss('F2'));
eqFFCC3('F3')..   sum(i,pqf(i)*Cf(i,'F3')) =e= sum(j, pf('L3',j)*F('L3',j))
                                               + shrK('F3')*sum(j, pf('K',j)*F('K',j))
                                               + trh('F3') - (Tdh('F3') + Ss('F3'));
eqpqf(i)..          Qf(i)            =e= sum(fl,Cf(i,fl)) + Gf(i) + In(i) + sum(j,X(i,j));
eqpxW(i)..          pxW(i)           =e= pUSxw00(i)*mgw;
eqpmW(i)..          pmW(i)           =e= pUSmw00(i)*mgw;
eqpxC(i)..          pxC(i)           =e= pBRxc00(i)*mgc;
eqpmC(i)..          pmC(i)           =e= pBRmc00(i)*mgc;
eqPRICE..           PRICE            =e= sum(j, pqf(j)*Qf00(j)/sum(i,Qf00(i)));


* --- [Função Objetivo Fictícia] -----------------------------------------------
eqU(fl)..       UU(fl) 		=e= a(fl)*prod(i,Cf(i,fl)**alpha(i,fl));
obj..           US    		=e= sum(fl, UU(fl));


* === inicialização de Variáveis ===============================================

FF.l(fl,h)    = FF00(fl,h);
F.l(h,j)      = F00(h,j);
Y.l(j)        = Y00(j);
X.l(i,j)      = X00(i,j);
Z.l(j)        = Z00(j);
Qs.l(i)       = Qs00(i);

Mc.l(i)       = Mc00(i);
Mw.l(i)       = Mw00(i);
Xc.l(i)       = Xc00(i);
Xw.l(i)       = Xw00(i);

Ss.l(fl)      = Ss00(fl);
Sg.l          = Sg00;

II.l(j)       = II00(j);
III.l         = III00;

Tdh.l(fl)     = Tdh00(fl);
Ti.l(j)       = Ti00(j);
To.l(j)       = To00(j);
Tm.l(j)       = Tm00(j);

Gf.l(i)       = Gf00(i);
Cf.l(i,fl)    = Cf00(i,fl);
In.l(i)       = In00(i);
Qf.l(i)       = Qf00(i);

pf.l(h,j)     = 1;
py.l(j)       = 1;
pz.l(j)       = 1;
pqs.l(i)      = 1;
pqf.l(i)      = 1;
pk.l          = 1;

pxW.l(i)      = 1;
pmW.l(i)      = 1;
pxC.l(i)      = 1;
pmC.l(i)      = 1;
mgW.l         = 1;
mgC.l         = 1;

FF.fx(fl,h_mob)  = FF00(fl,h_mob);
KK.fx(j)      = KK00(j);
Sc.fx         = Sc00;
Sw.fx         = Sw00;
trh.fx(fl)    = trh00(fl);
shrK.fx(fl)   = shrK00(fl);


* --- Numerário ----------------------------------------------------------------
PRICE.fx = 1;

* === Define e resolve o Modelo ================================================
Model Ceara /all/;
Solve Ceara maximizing US using NLP;

Ceara.ScaleOpt = 100;   option bratio=1;
$if not x%gams.jt%==x $exit
option limRow = 0, limCol = 0, solPrint = off, solveLink = %solveLink.loadlibrary%;

* === Recursividade: BAU =======================================================
loop(t,

Solve Ceara maximizing US using NLP;

* --- Gravando os Resultados da Primeira Recursividade -------------------------
FF0(fl,h,t) = FF.l(fl,h);
shrK0(fl,t) = shrK.l(fl);
F0(h,j,t)   = F.l(h,j)  ;
Y0(j,t)     = Y.l(j)    ;
X0(i,j,t)   = X.l(i,j)  ;
Z0(j,t)     = Z.l(j)    ;
Qs0(i,t)    = Qs.l(i)   ;

Xc0(i,t)    = Xc.l(i)   ;
Xw0(i,t)    = Xw.l(i)   ;
Mc0(i,t)    = Mc.l(i)   ;
Mw0(i,t)    = Mw.l(i)   ;

Sg0(t)      = Sg.l      ;
Ss0(fl,t)   = Ss.l(fl)  ;
Sc0(t)      = Sc.l      ;
Sw0(t)      = Sw.l      ;

III0(t)     = III.l     ;
II0(j,t)    = II.l(j)   ;
KK0(j,t)    = KK.l(j)   ;
shrII0(j,t) = (pf.l("K",j)**zeta*F.l("K",j) /
               sum(i,pf.l("K",i)**zeta*F.l("K",i)));

Tdh0(fl,t)  = Tdh.l(fl) ;
Ti0(j,t)    = Ti.l(j)   ;
To0(j,t)    = To.l(j)   ;
Tm0(j,t)    = Tm.l(j)   ;
trh0(fl,t)  = trh.l(fl) ;

Cf0(i,fl,t) = Cf.l(i,fl);
Gf0(i,t)    = Gf.l(i)   ;
In0(i,t)    = In.l(i)   ;
Qf0(i,t)    = Qf.l(i)   ;

pxW0(i,t)   = pxW.l(i)  ;
pmW0(i,t)   = pmW.l(i)  ;
pxC0(i,t)   = pxC.l(i)  ;
pmC0(i,t)   = pmC.l(i)  ;
mgW0(t)     = mgW.l     ;
mgC0(t)     = mgC.l     ;
pf0(h,j,t)  = pf.l(h,j) ;
py0(j,t)    = py.l(j)   ;
pz0(j,t)    = pz.l(j)   ;
pqs0(i,t)   = pqs.l(i)  ;
pqf0(i,t)   = pqf.l(i)  ;
pk0(t)      = pk.l      ;
PRICE0(t)   = PRICE.l   ;

UU0(fl,t)   = UU.l(fl)  ;
US0(t)      = US.l      ;


* --- Regras de Movimento ------------------------------------------------------
   FF.fx(fl,h)  = FF.l(fl,h)*(1 + pop(fl));
   KK.fx(j)     = (1 - dep)*KK.l(j) + II.l(j);

   shrK.fx(fl)  = FF.l(fl,'K')/sum(l, FF.l(l,'K'));
   trh.fx(fl)   = trh00(fl)*(1 + pop(fl))**(ord(t) - 1);

   Sc.fx        = Sc00*( sum((fl,h),FF0(fl,h,t)) / sum((fl,h), FF00(fl,h)) );
   Sw.fx        = Sw00*( sum((fl,h),FF0(fl,h,t)) / sum((fl,h), FF00(fl,h)) );

);

* === Reinicialização de Variáveis =============================================

FF.l(fl,h)    = FF00(fl,h);
F.l(h,j)      = F00(h,j);
Y.l(j)        = Y00(j);
X.l(i,j)      = X00(i,j);
Z.l(j)        = Z00(j);
Qs.l(i)       = Qs00(i);

Mc.l(i)       = Mc00(i);
Mw.l(i)       = Mw00(i);
Xc.l(i)       = Xc00(i);
Xw.l(i)       = Xw00(i);

Ss.l(fl)      = Ss00(fl);
Sg.l          = Sg00;

II.l(j)       = II00(j);
III.l         = III00;

Tdh.l(fl)     = Tdh00(fl);
Ti.l(j)       = Ti00(j);
To.l(j)       = To00(j);
Tm.l(j)       = Tm00(j);

Gf.l(i)       = Gf00(i);
Cf.l(i,fl)    = Cf00(i,fl);
In.l(i)       = In00(i);
Qf.l(i)       = Qf00(i);

pf.l(h,j)     = 1;
py.l(j)       = 1;
pz.l(j)       = 1;
pqs.l(i)      = 1;
pqf.l(i)      = 1;
pk.l          = 1;

pxW.l(i)      = 1;
pmW.l(i)      = 1;
pxC.l(i)      = 1;
pmC.l(i)      = 1;
mgW.l         = 1;
mgC.l         = 1;

FF.fx(fl,h_mob)  = FF00(fl,h_mob);
KK.fx(j)      = KK00(j);
Sc.fx         = Sc00;
Sw.fx         = Sw00;
trh.fx(fl)    = trh00(fl);
shrK.fx(fl)   = shrK00(fl);


* --- Numerário ----------------------------------------------------------------
PRICE.fx = 1;

* === Recursividade: Choque do Lockdown ========================================

   pop('F1') =  0.0454;
   pop('F2') = -0.0371;
   pop('F3') = -0.0332;

loop(t,

Solve Ceara maximizing US using NLP;

* --- Gravando os Resultados da Segunda Recursividade --------------------------
FF1(fl,h,t) = FF.l(fl,h);
shrK1(fl,t) = shrK.l(fl);
F1(h,j,t)   = F.l(h,j)  ;
Y1(j,t)     = Y.l(j)    ;
X1(i,j,t)   = X.l(i,j)  ;
Z1(j,t)     = Z.l(j)    ;
Qs1(i,t)    = Qs.l(i)   ;

Xc1(i,t)    = Xc.l(i)   ;
Xw1(i,t)    = Xw.l(i)   ;
Mc1(i,t)    = Mc.l(i)   ;
Mw1(i,t)    = Mw.l(i)   ;

Sg1(t)      = Sg.l      ;
Ss1(fl,t)   = Ss.l(fl)  ;
Sc1(t)      = Sc.l      ;
Sw1(t)      = Sw.l      ;

III1(t)     = III.l     ;
II1(j,t)    = II.l(j)   ;
KK1(j,t)    = KK.l(j)   ;
shrII1(j,t) = (pf.l("K",j)**zeta*F.l("K",j) /
               sum(i,pf.l("K",i)**zeta*F.l("K",i)));

Tdh1(fl,t)  = Tdh.l(fl) ;
Ti1(j,t)    = Ti.l(j)   ;
To1(j,t)    = To.l(j)   ;
Tm1(j,t)    = Tm.l(j)   ;
trh1(fl,t)  = trh.l(fl) ;

Cf1(i,fl,t) = Cf.l(i,fl);
Gf1(i,t)    = Gf.l(i)   ;
In1(i,t)    = In.l(i)   ;
Qf1(i,t)    = Qf.l(i)   ;

pxW1(i,t)   = pxW.l(i)  ;
pmW1(i,t)   = pmW.l(i)  ;
pxC1(i,t)   = pxC.l(i)  ;
pmC1(i,t)   = pmC.l(i)  ;
mgW1(t)     = mgW.l     ;
mgC1(t)     = mgC.l     ;
pf1(h,j,t)  = pf.l(h,j) ;
py1(j,t)    = py.l(j)   ;
pz1(j,t)    = pz.l(j)   ;
pqs1(i,t)   = pqs.l(i)  ;
pqf1(i,t)   = pqf.l(i)  ;
pk1(t)      = pk.l      ;
PRICE1(t)   = PRICE.l   ;

UU1(fl,t)   = UU.l(fl)  ;
US1(t)      = US.l      ;

* --- Regras de Movimento ------------------------------------------------------
   FF.fx(fl,h)  = FF.l(fl,h)*(1 + pop(fl));
   KK.fx(j)     = (1 - dep)*KK.l(j) + II.l(j);

   shrK.fx(fl)  = FF.l(fl,'K')/sum(l, FF.l(l,'K'));
   trh.fx(fl)   = trh00(fl)*(1 + pop(fl))**(ord(t) - 1);

   Sc.fx        = Sc00*( sum((fl,h),FF0(fl,h,t)) / sum((fl,h), FF00(fl,h)) );
   Sw.fx        = Sw00*( sum((fl,h),FF0(fl,h,t)) / sum((fl,h), FF00(fl,h)) );

);

* === Computação das Diferenças =================================================
Parameter
* --- Variação Percentual Entre as Trajetórias ----------------------------------

   dFF(fl,h,t)    'Variação Percental da Dotação das Famílias [%]'
   dF(h,j,t)      'Variação Percental dos Fatores de Produção [%]'
   dY(j,t)        'Variação Percental da Agregação de Fatores [%]'
   dX(i,j,t)      'Variação Percental dos Insumos Intermediários [%]'
   dZ(j,t)        'Variação Percental do Produto Bruto [%]'
   dQs(i,t)       'Variação Percental do Bem de Armington [%]'

   dMc(i,t)       'Variação Percental da importação do Resto-do-Brasil [%]'
   dMw(i,t)       'Variação Percental da importação do Mundo [%]'
   dXc(i,t)       'Variação Percental da exportação p o Resto-do-Brasil [%]'
   dXw(i,t)       'Variação Percental da exportação p o Mundo [%]'

   dSs(fl,t)      'Variação Percental da Poupança Privada [%]'
   dSg(t)         'Variação Percental da Poupança Governamental [%]'
   dSc(t)         'Variação Percental da Poupança do Resto-do-Brasil [%]'
   dSw(t)         'Variação Percental da Poupança do Mundo [%]'

   dII(j,t)       'Variação Percental do Investimento Setorial [%]'
   dIII(t)        'Variação Percental do Montante de Investimento [%]'

   dTdh(fl,t)     'Variação Percental da Tarifa de Imposto sobre a Renda [%]'
   dTi(j,t)       'Variação Percental da Tarifa de Imposto sobre Produção [%]'
   dTo(j,t)       'Variação Percental da Tarifa de Outros Impostos [%]'
   dTm(j,t)       'Variação Percental da Tarifa de Imposto sobre importação [%]'

   dGf(i,t)       'Variação Percental do Consumo do Governo [%]'
   dCf(i,fl,t)    'Variação Percental do Consumo das Famílias [%]'
   dIn(i,t)       'Variação Percental do Bens de Investimento [%]'
   dQf(i,t)       'Variação Percental da Oferta Final [%]'

   dpf(h,j,t)     'Variação Percental do Preço dos Fatores de Produção [%]'
   dpy(j,t)       'Variação Percental do Preço dos Fatoresa Compostos [%]'
   dpz(j,t)       'Variação Percental do Preço do Produto Bruto [%]'
   dpqs(i,t)      'Variação Percental do Preço do Bem de Armington [%]'
   dpqf(i,t)      'Variação Percental do Preço do Bem Final [%]'
   dpk(t)         'Variação Percental do Preço do Capital [%]'

   dpxW(i,t)      'Variação Percental do Preço da exportação p o Mundo [%]'
   dpmW(i,t)      'Variação Percental do Preço da importação p o Mundo [%]'
   dpxC(i,t)      'Variação Percental do Preço da exportação p o Resto-do-Brasil [%]'
   dpmC(i,t)      'Variação Percental do Preço da importação p o Resto-do-Brasil [%]'
   dmgW(t)        'Variação Percental da Margem de Comércio com o Mundo [%]'
   dmgC(t)        'Variação Percental da Margem de Comércio com o Resto-do-Brasil [%]'

* --- Tx de Crescimento do BAU (Contra-factual) -------------------------------
   gFF0(fl,h,t)    'Tx de Cresc. Contra-factual da Dotação das Famílias [%]'
   gF0g(h,j,t)     'Tx de Cresc. Contra-factual dos Fatores de Produção [%]'
   gY0(j,t)        'Tx de Cresc. Contra-factual da Agregação de Fatores [%]'
   gX0(i,j,t)      'Tx de Cresc. Contra-factual dos Insumos Intermediários [%]'
   gZ0(j,t)        'Tx de Cresc. Contra-factual do Produto Bruto [%]'
   gQs0(i,t)       'Tx de Cresc. Contra-factual do Bem de Armington [%]'

   gMc0(i,t)       'Tx de Cresc. Contra-factual da importação do Resto-do-Brasil [%]'
   gMw0(i,t)       'Tx de Cresc. Contra-factual da importação do Mundo [%]'
   gXc0(i,t)       'Tx de Cresc. Contra-factual da exportação p o Resto-do-Brasil [%]'
   gXw0(i,t)       'Tx de Cresc. Contra-factual da exportação p o Mundo [%]'

   gSs0(fl,t)      'Tx de Cresc. Contra-factual da Poupança Privada [%]'
   gSg0(t)         'Tx de Cresc. Contra-factual da Poupança Governamental [%]'
   gSc0(t)         'Tx de Cresc. Contra-factual da Poupança do Resto-do-Brasil [%]'
   gSw0(t)         'Tx de Cresc. Contra-factual da Poupança do Mundo [%]'

   gII0(j,t)       'Tx de Cresc. Contra-factual do Investimento Setorial [%]'
   gIII0(t)        'Tx de Cresc. Contra-factual do Montante de Investimento [%]'

   gTdh0(fl,t)     'Tx de Cresc. Contra-factual da Tarifa de Imposto sobre a Renda [%]'
   gTi0(j,t)       'Tx de Cresc. Contra-factual da Tarifa de Imposto sobre Produção [%]'
   gTo0(j,t)       'Tx de Cresc. Contra-factual da Tarifa de Outros Impostos [%]'
   gTm0(j,t)       'Tx de Cresc. Contra-factual da Tarifa de Imposto sobre importação [%]'

   gGf0(i,t)       'Tx de Cresc. Contra-factual do Consumo do Governo [%]'
   gCf0(i,fl,t)    'Tx de Cresc. Contra-factual do Consumo das Famílias [%]'
   gIn0(i,t)       'Tx de Cresc. Contra-factual do Bens de Investimento [%]'
   gQf0(i,t)       'Tx de Cresc. Contra-factual da Oferta Final [%]'

   gpf0(h,j,t)     'Tx de Cresc. Contra-factual do Preço dos Fatores de Produção [%]'
   gpy0(j,t)       'Tx de Cresc. Contra-factual do Preço dos Fatoresa Compostos [%]'
   gpz0(j,t)       'Tx de Cresc. Contra-factual do Preço do Produto Bruto [%]'
   gpqs0(i,t)      'Tx de Cresc. Contra-factual do Preço do Bem de Armington [%]'
   gpqf0(i,t)      'Tx de Cresc. Contra-factual do Preço do Bem Final [%]'
   gpk0(t)         'Tx de Cresc. Contra-factual do Preço do Capital [%]'

   gpxW0(i,t)      'Tx de Cresc. Contra-factual do Preço da exportação p o Mundo [%]'
   gpmW0(i,t)      'Tx de Cresc. Contra-factual do Preço da importação p o Mundo [%]'
   gpxC0(i,t)      'Tx de Cresc. Contra-factual do Preço da exportação po Resto-do-Brasil [%]'
   gpmC0(i,t)      'Tx de Cresc. Contra-factual do Preço da importação po Resto-do-Brasil [%]'
   gmgW0(t)        'Tx de Cresc. Contra-factual da Mrg de Comércio com o Mundo [%]'
   gmgC0(t)        'Tx de Cresc. Contra-factual da Mrg de Comércio com o Resto-do-Brasil [%]'

* --- Tx de Crescimento do Cen�rio do Lockdown ---------------------------------
   gFF1(fl,h,t)    'Tx de Cresc. c/ Choque da Dotação das Famílias [%]'
   gF1g(h,j,t)      'Tx de Cresc. c/ Choque dos Fatores de Produção [%]'
   gY1(j,t)        'Tx de Cresc. c/ Choque da Agregação de Fatores [%]'
   gX1(i,j,t)      'Tx de Cresc. c/ Choque dos Insumos Intermediários [%]'
   gZ1(j,t)        'Tx de Cresc. c/ Choque do Produto Bruto [%]'
   gQs1(i,t)       'Tx de Cresc. c/ Choque do Bem de Armington [%]'

   gMc1(i,t)       'Tx de Cresc. c/ Choque da importação do Resto-do-Brasil [%]'
   gMw1(i,t)       'Tx de Cresc. c/ Choque da importação do Mundo [%]'
   gXc1(i,t)       'Tx de Cresc. c/ Choque da exportação p o Resto-do-Brasil [%]'
   gXw1(i,t)       'Tx de Cresc. c/ Choque da exportação p o Mundo [%]'

   gSs1(fl,t)      'Tx de Cresc. c/ Choque da Poupança Privada [%]'
   gSg1(t)         'Tx de Cresc. c/ Choque da Poupança Governamental [%]'
   gSc1(t)         'Tx de Cresc. c/ Choque da Poupança do Resto-do-Brasil [%]'
   gSw1(t)         'Tx de Cresc. c/ Choque da Poupança do Mundo [%]'

   gII1(j,t)       'Tx de Cresc. c/ Choque do Investimento Setorial [%]'
   gIII1(t)        'Tx de Cresc. c/ Choque do Montante de Investimento [%]'

   gTdh1(fl,t)     'Tx de Cresc. c/ Choque da Tarifa de Imposto sobre a Renda [%]'
   gTi1(j,t)       'Tx de Cresc. c/ Choque da Tarifa de Imposto sobre Produção [%]'
   gTo1(j,t)       'Tx de Cresc. c/ Choque da Tarifa de Outros Impostos [%]'
   gTm1(j,t)       'Tx de Cresc. c/ Choque da Tarifa de Imposto sobre importação [%]'

   gGf1(i,t)       'Tx de Cresc. c/ Choque do Consumo do Governo [%]'
   gCf1(i,fl,t)    'Tx de Cresc. c/ Choque do Consumo das Famílias [%]'
   gIn1(i,t)       'Tx de Cresc. c/ Choque do Bens de Investimento [%]'
   gQf1(i,t)       'Tx de Cresc. c/ Choque da Oferta Final [%]'

   gpf1(h,j,t)     'Tx de Cresc. c/ Choque do Preço dos Fatores de Produção [%]'
   gpy1(j,t)       'Tx de Cresc. c/ Choque do Preço dos Fatoresa Compostos [%]'
   gpz1(j,t)       'Tx de Cresc. c/ Choque do Preço do Produto Bruto [%]'
   gpqs1(i,t)      'Tx de Cresc. c/ Choque do Preço do Bem de Armington [%]'
   gpqf1(i,t)      'Tx de Cresc. c/ Choque do Preço do Bem Final [%]'
   gpk1(t)         'Tx de Cresc. c/ Choque do Preço do Capital [%]'

   gpxW1(i,t)      'Tx de Cresc. c/ Choque do Preço da exportação p o Mundo [%]'
   gpmW1(i,t)      'Tx de Cresc. c/ Choque do Preço da importação p o Mundo [%]'
   gpxC1(i,t)      'Tx de Cresc. c/ Choque do Preço da exportação p o Resto-do-Brasil [%]'
   gpmC1(i,t)      'Tx de Cresc. c/ Choque do Preço da importação p o Resto-do-Brasil [%]'
   gmgW1(t)        'Tx de Cresc. c/ Choque da Margem de Comércio com o Mundo [%]'
   gmgC1(t)        'Tx de Cresc. c/ Choque da Margem de Comércio com o Resto-do-Brasil [%]'
;

 dFF(fl,h,t)     $FF0(fl,h,t)  = (  FF1(fl,h,t)   / FF0(fl,h,t)-1)*100;
 dF(h,j,t)       $F0(h,j,t)    = (  F1(h,j,t)     / F0(h,j,t)  -1)*100;
 dY(j,t)         $Y0(j,t)      = (  Y1(j,t)       / Y0(j,t)    -1)*100;
 dX(i,j,t)       $X0(i,j,t)    = (  X1(i,j,t)     / X0(i,j,t)  -1)*100;
 dZ(j,t)         $Z0(j,t)      = (  Z1(j,t)       / Z0(j,t)    -1)*100;
 dQs(i,t)        $Qs0(i,t)     = (  Qs1(i,t)      / Qs0(i,t)   -1)*100;
 dXc(i,t)        $Xc0(i,t)     = (  Xc1(i,t)      / Xc0(i,t)   -1)*100;
 dXw(i,t)        $Xw0(i,t)     = (  Xw1(i,t)      / Xw0(i,t)   -1)*100;
 dMc(i,t)        $Mc0(i,t)     = (  Mc1(i,t)      / Mc0(i,t)   -1)*100;
 dMw(i,t)        $Mw0(i,t)     = (  Mw1(i,t)      / Mw0(i,t)   -1)*100;
 dSg(t)          $Sg0(t)       = (  Sg1(t)        / Sg0(t)     -1)*100;
 dSs(fl,t)       $Ss0(fl,t)    = (  Ss1(fl,t)     / Ss0(fl,t)  -1)*100;
 dSc(t)          $Sc0(t)       = (  Sc1(t)        / Sc0(t)     -1)*100;
 dSw(t)          $Sw0(t)       = (  Sw1(t)        / Sw0(t)     -1)*100;
 dIII(t)         $III0(t)      = (  III1(t)       / III0(t)    -1)*100;
 dII(j,t)        $II0(j,t)     = (  II1(j,t)      / II0(j,t)   -1)*100;
 dTdh(fl,t)      $Tdh0(fl,t)   = (  Tdh1(fl,t)    / Tdh0(fl,t) -1)*100;
 dTi(j,t)        $Ti0(j,t)     = (  Ti1(j,t)      / Ti0(j,t)   -1)*100;
 dTo(j,t)        $To0(j,t)     = (  To1(j,t)      / To0(j,t)   -1)*100;
 dTm(j,t)        $Tm0(j,t)     = (  Tm1(j,t)      / Tm0(j,t)   -1)*100;
 dCf(i,fl,t)     $Cf0(i,fl,t)  = (  Cf1(i,fl,t)   / Cf0(i,fl,t)-1)*100;
 dGf(i,t)        $Gf0(i,t)     = (  Gf1(i,t)      / Gf0(i,t)   -1)*100;
 dIn(i,t)        $In0(i,t)     = (  In1(i,t)      / In0(i,t)   -1)*100;
 dQf(i,t)        $Qf0(i,t)     = (  Qf1(i,t)      / Qf0(i,t)   -1)*100;
 dpf(h,j,t)      $pf0(h,j,t)   = (  pf1(h,j,t)    / pf0(h,j,t) -1)*100;
 dpy(j,t)        $py0(j,t)     = (  py1(j,t)      / py0(j,t)   -1)*100;
 dpz(j,t)        $pz0(j,t)     = (  pz1(j,t)      / pz0(j,t)   -1)*100;
 dpqs(i,t)       $pqs0(i,t)    = (  pqs1(i,t)     / pqs0(i,t)  -1)*100;
 dpqf(i,t)       $pqf0(i,t)    = (  pqf1(i,t)     / pqf0(i,t)  -1)*100;
 dpk(t)          $pk0(t)       = (  pk1(t)        / pk0(t)     -1)*100;
 dpxW(i,t)       $pxW0(i,t)    = (  pxW1(i,t)     / pxW0(i,t)  -1)*100;
 dpmW(i,t)       $pmW0(i,t)    = (  pmW1(i,t)     / pmW0(i,t)  -1)*100;
 dpxC(i,t)       $pxC0(i,t)    = (  pxC1(i,t)     / pxC0(i,t)  -1)*100;
 dpmC(i,t)       $pmC0(i,t)    = (  pmC1(i,t)     / pmC0(i,t)  -1)*100;
 dmgW(t)         $mgW0(t)      = (  mgW1(t)       / mgW0(t)    -1)*100;
 dmgC(t)         $mgC0(t)      = (  mgC1(t)       / mgC0(t)    -1)*100;
*--------------------------------
 gFF0(fl,h,t)    $FF0(fl,h,t)  = (  FF0(fl,h,t+1) / FF0(fl,h,t) -1)*100;
 gF0g(h,j,t)      $F0(h,j,t)    = (  F0(h,j,t+1)   / F0(h,j,t)   -1)*100;
 gY0(j,t)        $Y0(j,t)      = (  Y0(j,t+1)     / Y0(j,t)     -1)*100;
 gX0(i,j,t)      $X0(i,j,t)    = (  X0(i,j,t+1)   / X0(i,j,t)   -1)*100;
 gZ0(j,t)        $Z0(j,t)      = (  Z0(j,t+1)     / Z0(j,t)     -1)*100;
 gQs0(i,t)       $Qs0(i,t)     = (  Qs0(i,t+1)    / Qs0(i,t)    -1)*100;
 gXc0(i,t)       $Xc0(i,t)     = (  Xc0(i,t+1)    / Xc0(i,t)    -1)*100;
 gXw0(i,t)       $Xw0(i,t)     = (  Xw0(i,t+1)    / Xw0(i,t)    -1)*100;
 gMc0(i,t)       $Mc0(i,t)     = (  Mc0(i,t+1)    / Mc0(i,t)    -1)*100;
 gMw0(i,t)       $Mw0(i,t)     = (  Mw0(i,t+1)    / Mw0(i,t)    -1)*100;
 gSg0(t)         $Sg0(t)       = (  Sg0(t+1)      / Sg0(t)      -1)*100;
 gSs0(fl,t)      $Ss0(fl,t)    = (  Ss0(fl,t+1)   / Ss0(fl,t)   -1)*100;
 gSc0(t)         $Sc0(t)       = (  Sc0(t+1)      / Sc0(t)      -1)*100;
 gSw0(t)         $Sw0(t)       = (  Sw0(t+1)      / Sw0(t)      -1)*100;
 gIII0(t)        $III0(t)      = (  III0(t+1)     / III0(t)     -1)*100;
 gII0(j,t)       $II0(j,t)     = (  II0(j,t+1)    / II0(j,t)    -1)*100;
 gTdh0(fl,t)     $Tdh0(fl,t)   = (  Tdh0(fl,t+1)  / Tdh0(fl,t)  -1)*100;
 gTi0(j,t)       $Ti0(j,t)     = (  Ti0(j,t+1)    / Ti0(j,t)    -1)*100;
 gTo0(j,t)       $To0(j,t)     = (  To0(j,t+1)    / To0(j,t)    -1)*100;
 gTm0(j,t)       $Tm0(j,t)     = (  Tm0(j,t+1)    / Tm0(j,t)    -1)*100;
 gCf0(i,fl,t)    $Cf0(i,fl,t)  = (  Cf0(i,fl,t+1) / Cf0(i,fl,t) -1)*100;
 gGf0(i,t)       $Gf0(i,t)     = (  Gf0(i,t+1)    / Gf0(i,t)    -1)*100;
 gIn0(i,t)       $In0(i,t)     = (  In0(i,t+1)    / In0(i,t)    -1)*100;
 gQf0(i,t)       $Qf0(i,t)     = (  Qf0(i,t+1)    / Qf0(i,t)    -1)*100;
 gpf0(h,j,t)     $pf0(h,j,t)   = (  pf0(h,j,t+1)  / pf0(h,j,t)  -1)*100;
 gpy0(j,t)       $py0(j,t)     = (  py0(j,t+1)    / py0(j,t)    -1)*100;
 gpz0(j,t)       $pz0(j,t)     = (  pz0(j,t+1)    / pz0(j,t)    -1)*100;
 gpqs0(i,t)      $pqs0(i,t)    = (  pqs0(i,t+1)   / pqs0(i,t)   -1)*100;
 gpqf0(i,t)      $pqf0(i,t)    = (  pqf0(i,t+1)   / pqf0(i,t)   -1)*100;
 gpk0(t)         $pk0(t)       = (  pk0(t+1)      / pk0(t)      -1)*100;
 gpxW0(i,t)      $pxW0(i,t)    = (  pxW0(i,t+1)   / pxW0(i,t)   -1)*100;
 gpmW0(i,t)      $pmW0(i,t)    = (  pmW0(i,t+1)   / pmW0(i,t)   -1)*100;
 gpxC0(i,t)      $pxC0(i,t)    = (  pxC0(i,t+1)   / pxC0(i,t)   -1)*100;
 gpmC0(i,t)      $pmC0(i,t)    = (  pmC0(i,t+1)   / pmC0(i,t)   -1)*100;
 gmgW0(t)        $mgW0(t)      = (  mgW0(t+1)     / mgW0(t)     -1)*100;
 gmgC0(t)        $mgC0(t)      = (  mgC0(t+1)     / mgC0(t)     -1)*100;
*--------------------------------
 gFF1(fl,h,t)    $FF1(fl,h,t)  = ( FF1(fl,h,t+1)  / FF1(fl,h,t) -1)*100;
 gF1g(h,j,t)      $F1(h,j,t)    = ( F1(h,j,t+1)    / F1(h,j,t)   -1)*100;
 gY1(j,t)        $Y1(j,t)      = ( Y1(j,t+1)      / Y1(j,t)     -1)*100;
 gX1(i,j,t)      $X1(i,j,t)    = ( X1(i,j,t+1)    / X1(i,j,t)   -1)*100;
 gZ1(j,t)        $Z1(j,t)      = ( Z1(j,t+1)      / Z1(j,t)     -1)*100;
 gQs1(i,t)       $Qs1(i,t)     = ( Qs1(i,t+1)     / Qs1(i,t)    -1)*100;
 gXc1(i,t)       $Xc1(i,t)     = ( Xc1(i,t+1)     / Xc1(i,t)    -1)*100;
 gXw1(i,t)       $Xw1(i,t)     = ( Xw1(i,t+1)     / Xw1(i,t)    -1)*100;
 gMc1(i,t)       $Mc1(i,t)     = ( Mc1(i,t+1)     / Mc1(i,t)    -1)*100;
 gMw1(i,t)       $Mw1(i,t)     = ( Mw1(i,t+1)     / Mw1(i,t)    -1)*100;
 gSg1(t)         $Sg1(t)       = ( Sg1(t+1)       / Sg1(t)      -1)*100;
 gSs1(fl,t)      $Ss1(fl,t)    = ( Ss1(fl,t+1)    / Ss1(fl,t)   -1)*100;
 gSc1(t)         $Sc1(t)       = ( Sc1(t+1)       / Sc1(t)      -1)*100;
 gSw1(t)         $Sw1(t)       = ( Sw1(t+1)       / Sw1(t)      -1)*100;
 gIII1(t)        $III1(t)      = ( III1(t+1)      / III1(t)     -1)*100;
 gII1(j,t)       $II1(j,t)     = ( II1(j,t+1)     / II1(j,t)    -1)*100;
 gTdh1(fl,t)     $Tdh1(fl,t)   = ( Tdh1(fl,t+1)   / Tdh1(fl,t)  -1)*100;
 gTi1(j,t)       $Ti1(j,t)     = ( Ti1(j,t+1)     / Ti1(j,t)    -1)*100;
 gTo1(j,t)       $To1(j,t)     = ( To1(j,t+1)     / To1(j,t)    -1)*100;
 gTm1(j,t)       $Tm1(j,t)     = ( Tm1(j,t+1)     / Tm1(j,t)    -1)*100;
 gCf1(i,fl,t)    $Cf1(i,fl,t)  = ( Cf1(i,fl,t+1)  / Cf1(i,fl,t) -1)*100;
 gGf1(i,t)       $Gf1(i,t)     = ( Gf1(i,t+1)     / Gf1(i,t)    -1)*100;
 gIn1(i,t)       $In1(i,t)     = ( In1(i,t+1)     / In1(i,t)    -1)*100;
 gQf1(i,t)       $Qf1(i,t)     = ( Qf1(i,t+1)     / Qf1(i,t)    -1)*100;
 gpf1(h,j,t)     $pf1(h,j,t)   = ( pf1(h,j,t+1)   / pf1(h,j,t)  -1)*100;
 gpy1(j,t)       $py1(j,t)     = ( py1(j,t+1)     / py1(j,t)    -1)*100;
 gpz1(j,t)       $pz1(j,t)     = ( pz1(j,t+1)     / pz1(j,t)    -1)*100;
 gpqs1(i,t)      $pqs1(i,t)    = ( pqs1(i,t+1)    / pqs1(i,t)   -1)*100;
 gpqf1(i,t)      $pqf1(i,t)    = ( pqf1(i,t+1)    / pqf1(i,t)   -1)*100;
 gpk1(t)         $pk1(t)       = ( pk1(t+1)       / pk1(t)      -1)*100;
 gpxW1(i,t)      $pxW1(i,t)    = ( pxW1(i,t+1)    / pxW1(i,t)   -1)*100;
 gpmW1(i,t)      $pmW1(i,t)    = ( pmW1(i,t+1)    / pmW1(i,t)   -1)*100;
 gpxC1(i,t)      $pxC1(i,t)    = ( pxC1(i,t+1)    / pxC1(i,t)   -1)*100;
 gpmC1(i,t)      $pmC1(i,t)    = ( pmC1(i,t+1)    / pmC1(i,t)   -1)*100;
 gmgW1(t)        $mgW1(t)      = ( mgW1(t+1)      / mgW1(t)     -1)*100;
 gmgC1(t)        $mgC1(t)      = ( mgC1(t+1)      / mgC1(t)     -1)*100;

* --- Medi��o de Bem-Estar: Hicksian equivalent variations ---------------------
Parameter
   VE_scen(fl,t)   'Variação Equivalente de Hicks [current] entre cenários'
   VE_TTL(fl)      'Total V.E. [discounted sum]'
;
VE_scen(fl,t) = (UU1(fl,t) - UU0(fl,t)) / a(fl) / prod(i,(alpha(i,fl)/1) **alpha(i,fl));
VE_TTL(fl) = sum(t, VE_scen(fl,t) / (1 + ror)**(ord(t) - 1));

* --- GDX ----------------------------------------------------------------------
execute_unload "result.gdx";
OPTION NLP=GAMSCHK;
