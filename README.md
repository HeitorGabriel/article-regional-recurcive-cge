# The Long-run Effects of Lockdowns in Ceará Economy Through Productivity

The complete article and more detailed results [here.](https://rpubs.com/Heitor_Mont/)

To run the model in GAMS program, put this three files in the same directory address. The run generates a "results.gdx" file to compare with author's results.

1) "model.gms" description of the model;
2) "samPrinc.gdx" Social Accounting Matrix with Ceará's data to apply in the model;
3) "author_result.gdx" results file used in article.

To run the Kuznets Curve source file to R, you need to download the [microdata files](http://ftp.ibge.gov.br/Trabalho_e_Rendimento/Pesquisa_Nacional_por_Amostra_de_Domicilios_anual/microdados/) of the [National Household Sample Survey](https://www.ibge.gov.br/en/statistics/social/labor/18079-brazil-volume-pnad1.html?=&t=o-que-e), in Annual frequence. Then, modify to our directory address and the names of the files as in code, to correct importation of the data.

4) "educational_kuznets.R" source file to run in R.

