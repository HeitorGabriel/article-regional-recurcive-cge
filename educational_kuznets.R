# First, you have to download the microdata since 1995 to 2015 of the Annual PNAD and save in your working directory labeling only by year, e.g., "1995.txt".

# http://ftp.ibge.gov.br/Trabalho_e_Rendimento/Pesquisa_Nacional_por_Amostra_de_Domicilios_anual/microdados/

# the process of considering the complex sample data can be validated by the procedure in line 879.

# If some package is not installed
#install.packages('tidyverse  ' , dependencies=T)
#install.packages('survey     ' , dependencies=T)
#install.packages('srvyr      ' , dependencies=T)
#install.packages('convey     ' , dependencies=T)
#install.packages('laeken     ' , dependencies=T)
#install.packages('REAT       ' , dependencies=T)
#install.packages('e1071      ' , dependencies=T)
#install.packages('gtsummary  ' , dependencies=T)
#install.packages('performance' , dependencies=T)



library(tidyverse) # default
library(survey) # to work with complex data
library(srvyr, warn.conflicts = FALSE) # to work with complex data
library(convey) # to work with complex data
library(laeken) # indicators on social exclusion and poverty
library(REAT)
library(e1071) # skewness
library(gtsummary) # summarizing models
library(performance)


setwd	("/home/heitor/Downloads/Pnad")

# 0) Extrating the Variables ===============================================

rm(list = ls())
txt <- "1995.DAT"
dds <- read_fwf(txt, fwf_cols(
  ano      = c(0001, 0002),
  uf       = c(0003, 0004),
  sex      = c(0016, 0016),
  idd      = c(0024, 0026),
  cor      = c(0030, 0030),
  curelv   = c(0148, 0148),
  hras     = c(0791, 0792),
  anosest  = c(1448, 1449),
  cndativ  = c(1461, 1461),
  cndocup  = c(1462, 1462),
  postrab  = c(1463, 1464),
  ramativ  = c(1465, 1466),
  grpocup  = c(1467, 1467),
  rendprnc = c(1468, 1479),
  rendtds  = c(1480, 1491),
  rendfnt  = c(1492, 1503),
  loc      = c(1547, 1547),
  pespes   = c(1548, 1552)
) )
dds <- dds %>% tibble() %>% filter(dds$uf==23)
write.csv2(dds, "ce95.csv")


rm(list = ls())
txt <- "1996.txt"
dds <- read_fwf(txt, fwf_cols(
  ano      = c(0001, 0002),
  uf       = c(0003, 0004),
  sex      = c(0016, 0016),
  idd      = c(0024, 0026),
  cor      = c(0030, 0030),
  curelv   = c(0148, 0148),
  hras     = c(0493, 0494),
  anosest  = c(1411, 1412),
  cndativ  = c(1424, 1424),
  cndocup  = c(1425, 1425),
  postrab  = c(1426, 1427),
  ramativ  = c(1428, 1429),
  grpocup  = c(1430, 1430),
  rendprnc = c(1431, 1442),
  rendtds  = c(1443, 1454),
  rendfnt  = c(1455, 1466),
  loc      = c(1510, 1510),
  pespes   = c(1511, 1515)
) )
dds <- dds %>% tibble() %>% filter(dds$uf==23)
write.csv2(dds, "ce96.csv")


rm(list = ls())
txt <- "1997.txt"
dds <- read_fwf(txt, fwf_cols(
  ano      = c(0001, 0002),
  uf       = c(0003, 0004),
  sex      = c(0016, 0016),
  idd      = c(0024, 0026),
  cor      = c(0030, 0030),
  curelv   = c(0148, 0148),
  hras     = c(0493, 0494),
  anosest  = c(1146, 1147),
  cndativ  = c(1159, 1159),
  cndocup  = c(1160, 1160),
  postrab  = c(1161, 1162),
  ramativ  = c(1163, 1164),
  grpocup  = c(1165, 1165),
  rendprnc = c(1166, 1177),
  rendtds  = c(1178, 1189),
  rendfnt  = c(1190, 1201),
  loc      = c(1245, 1245),
  pespes   = c(1246, 1250)
) )
dds <- dds %>% tibble() %>% filter(dds$uf==23)
write.csv2(dds, "ce97.csv")


rm(list = ls())
txt <- "1998.txt"
dds <- read_fwf(txt, fwf_cols(
  ano      = c(001, 002),
  uf       = c(003, 004),
  sex      = c(016, 016),
  idd      = c(024, 026),
  cor      = c(030, 030),
  curelv   = c(064, 064),
  hras     = c(342, 343),
  anosest  = c(641, 642),
  cndativ  = c(654, 654),
  cndocup  = c(655, 655),
  postrab  = c(656, 657),
  ramativ  = c(658, 659),
  grpocup  = c(660, 660),
  rendprnc = c(661, 672),
  rendtds  = c(673, 684),
  rendfnt  = c(685, 696),
  loc      = c(740, 740),
  pespes   = c(741, 745)
) )
dds <- dds %>% tibble() %>% filter(dds$uf==23)
write.csv2(dds, "ce98.csv")


rm(list = ls())
txt <- "1999.txt"
dds <- read_fwf(txt, fwf_cols(
  ano      = c(001, 002),
  uf       = c(003, 004),
  sex      = c(016, 016),
  idd      = c(024, 026),
  cor      = c(030, 030),
  curelv   = c(064, 064),
  hras     = c(342, 343),
  anosest  = c(641, 642),
  cndativ  = c(654, 654),
  cndocup  = c(655, 655),
  postrab  = c(656, 657),
  ramativ  = c(658, 659),
  grpocup  = c(660, 660),
  rendprnc = c(661, 672),
  rendtds  = c(673, 684),
  rendfnt  = c(685, 696),
  loc      = c(740, 740),
  pespes   = c(741, 745)
) )
dds <- dds %>% tibble() %>% filter(dds$uf==23)
write.csv2(dds, "ce99.csv")


rm(list = ls())
txt <- "2001.txt"
dds <- read_fwf(txt, fwf_cols(
  ano      = c(001, 003),
  uf       = c(005, 006),
  sex      = c(018, 018),
  idd      = c(027, 029),
  cor      = c(033, 033),
  curelv   = c(072, 073),
  hras     = c(298, 299),
  anosest  = c(620, 621),
  cndativ  = c(633, 633),
  cndocup  = c(634, 634),
  postrab  = c(635, 636),
  ramativ  = c(637, 638),
  grpocup  = c(639, 639),
  rendprnc = c(640, 651),
  rendtds  = c(652, 663),
  rendfnt  = c(664, 675),
  loc      = c(719, 719),
  pespes   = c(720, 724)
  ))
dds <- dds %>% tibble() %>% filter(dds$uf==23)
write.csv2(dds, "ce01.csv")


rm(list = ls())
txt <- "2002.txt"
dds <- read_fwf(txt, fwf_cols(
  ano      = c(001, 004),
  uf       = c(005, 006),
  sex      = c(018, 018),
  idd      = c(027, 029),
  cor      = c(033, 033),
  curelv   = c(069, 070),
  hras     = c(355, 356),
  anosest  = c(666, 667),
  cndativ  = c(680, 680),
  cndocup  = c(681, 681),
  postrab  = c(682, 683),
  ramativ  = c(684, 685),
  grpocup  = c(686, 687),
  rendprnc = c(688, 699),
  rendtds  = c(700, 711),
  rendfnt  = c(712, 723),
  loc      = c(767, 767),
  pespes   = c(768, 772)
  ))
dds <- dds %>% tibble() %>% filter(dds$uf==23)
write.csv2(dds, "ce02.csv")


rm(list = ls())
txt <- "2003.txt"
dds <- read_fwf(txt, fwf_cols(
  ano      = c(001, 004),
  uf       = c(005, 006),
  sex      = c(018, 018),
  idd      = c(027, 029),
  cor      = c(033, 033),
  curelv   = c(069, 070),
  hras     = c(360, 361),
  anosest  = c(785, 786),
  cndativ  = c(799, 799),
  cndocup  = c(800, 800),
  postrab  = c(801, 802),
  ramativ  = c(803, 804),
  grpocup  = c(805, 806),
  rendprnc = c(807, 818),
  rendtds  = c(819, 830),
  rendfnt  = c(831, 842),
  loc      = c(886, 886),
  pespes   = c(887, 891)
  ))
dds <- dds %>% tibble() %>% filter(dds$uf==23)
write.csv2(dds, "ce03.csv")

rm(list = ls())
txt <- "2004.txt"
dds <- read_fwf(txt, fwf_cols(
  ano      = c(001, 004),
  uf       = c(005, 006),
  sex      = c(018, 018),
  idd      = c(027, 029),
  cor      = c(033, 033),
  curelv   = c(069, 070),
  hras     = c(370, 371),
  anosest  = c(681, 682),
  cndativ  = c(695, 695),
  cndocup  = c(696, 696),
  postrab  = c(697, 698),
  ramativ  = c(699, 700),
  grpocup  = c(701, 702),
  rendprnc = c(703, 714),
  rendtds  = c(715, 726),
  rendfnt  = c(727, 738),
  loc      = c(782, 782),
  pespes   = c(783, 787)
  ))
dds <- dds %>% tibble() %>% filter(dds$uf==23)
write.csv2(dds, "ce04.csv")

rm(list = ls())
txt <- "2005.txt"
dds <- read_fwf(txt, fwf_cols(
  ano      = c(001, 004),
  uf       = c(005, 006),
  sex      = c(018, 018),
  idd      = c(027, 029),
  cor      = c(033, 033),
  curelv   = c(070, 071),
  hras     = c(359, 360),
  anosest  = c(696, 697),
  cndativ  = c(710, 710),
  cndocup  = c(711, 711),
  postrab  = c(712, 713),
  ramativ  = c(714, 715),
  grpocup  = c(716, 717),
  rendprnc = c(718, 729),
  rendtds  = c(730, 741),
  rendfnt  = c(742, 753),
  loc      = c(797, 797),
  pespes   = c(798, 802)
) )
dds <- dds %>% tibble() %>% filter(dds$uf==23)
write.csv2(dds, "ce05.csv")

rm(list = ls())
txt <- "2006.txt"
dds <- read_fwf(txt, fwf_cols(
  ano      = c(001, 004),
  uf       = c(005, 006),
  sex      = c(018, 018),
  idd      = c(027, 029),
  cor      = c(033, 033),
  curelv   = c(070, 071),
  hras     = c(376, 377),
  anosest  = c(705, 706),
  cndativ  = c(719, 719),
  cndocup  = c(720, 720),
  postrab  = c(721, 722),
  ramativ  = c(723, 724),
  grpocup  = c(725, 726),
  rendprnc = c(727, 738),
  rendtds  = c(739, 750),
  rendfnt  = c(751, 762),
  loc      = c(806, 806),
  pespes   = c(807, 811)
  ))
dds <- dds %>% tibble() %>% filter(dds$uf==23)
write.csv2(dds, "ce06.csv")

rm(list = ls())
txt <- "2007.txt"
dds <- read_fwf(txt, fwf_cols(
  ano      = c(001, 004),
  uf       = c(005, 006),
  sex      = c(018, 018),
  idd      = c(027, 029),
  cor      = c(033, 033),
  curelv   = c(075, 076),
  hras     = c(343, 344),
  anosest  = c(650, 651),
  cndativ  = c(664, 664),
  cndocup  = c(665, 665),
  postrab  = c(666, 667),
  ramativ  = c(668, 669),
  grpocup  = c(670, 671),
  rendprnc = c(672, 683),
  rendtds  = c(684, 695),
  rendfnt  = c(696, 707),
  loc      = c(737, 737),
  pespes   = c(738, 742),
  V4745    = c(767, 767)
) )
dds <- dds %>% tibble() %>% filter(dds$uf==23)
write.csv2(dds, "ce07.csv")

rm(list = ls())
txt <- "2008.txt"
dds <- read_fwf(txt, fwf_cols(
  ano      = c(001, 004),
  uf       = c(005, 006),
  sex      = c(018, 018),
  idd      = c(027, 029),
  cor      = c(033, 033),
  curelv   = c(075, 076),
  hras     = c(345, 346),
  anosest  = c(654, 655),
  cndativ  = c(668, 668),
  cndocup  = c(669, 669),
  postrab  = c(670, 671),
  ramativ  = c(672, 673),
  grpocup  = c(674, 675),
  rendprnc = c(676, 687),
  rendtds  = c(688, 699),
  rendfnt  = c(700, 711),
  loc      = c(741, 741),
  pespes   = c(742, 746),
  V4745    = c(771, 771)
) )
dds <- dds %>% tibble() %>% filter(dds$uf==23)
write.csv2(dds, "ce08.csv")

rm(list = ls())
txt <- "2009.txt"
dds <- read_fwf(txt, fwf_cols(
  ano      = c(001, 004),
  uf       = c(005, 006),
  sex      = c(018, 018),
  idd      = c(027, 029),
  cor      = c(033, 033),
  curelv   = c(077, 078),
  hras     = c(350, 351),
  anosest  = c(659, 660),
  cndativ  = c(673, 673),
  cndocup  = c(674, 674),
  postrab  = c(675, 676),
  ramativ  = c(677, 678),
  grpocup  = c(679, 680),
  rendprnc = c(681, 692),
  rendtds  = c(693, 704),
  rendfnt  = c(705, 716),
  loc      = c(746, 746),
  pespes   = c(747, 751),
  V4745    = c(778, 778)
) )
dds <- dds %>% tibble() %>% filter(dds$uf==23)
write.csv2(dds, "ce09.csv")

rm(list = ls())
txt <- "2011.txt"
dds <- read_fwf(txt, fwf_cols(
  ano      = c(001, 004),
  uf       = c(005, 006),
  sex      = c(018, 018),
  idd      = c(027, 029),
  cor      = c(033, 033),
  curelv   = c(079, 080),
  hras     = c(354, 355),
  anosest  = c(663, 664),
  cndativ  = c(677, 677),
  cndocup  = c(678, 678),
  postrab  = c(679, 680),
  ramativ  = c(681, 682),
  grpocup  = c(683, 684),
  rendprnc = c(685, 696),
  rendtds  = c(697, 708),
  rendfnt  = c(709, 720),
  loc      = c(750, 750),
  pespes   = c(751, 755),
  V4745    = c(780, 780)
) )
dds <- dds %>% tibble() %>% filter(dds$uf==23)
write.csv2(dds, "ce11.csv")

rm(list = ls())
txt <- "2012.txt"
dds <- read_fwf(txt, fwf_cols(
  ano      = c(001, 004),
  uf       = c(005, 006),
  sex      = c(018, 018),
  idd      = c(027, 029),
  cor      = c(033, 033),
  curelv   = c(079, 080),
  hras     = c(355, 356),
  anosest  = c(664, 665),
  cndativ  = c(678, 678),
  cndocup  = c(679, 679),
  postrab  = c(680, 681),
  ramativ  = c(682, 683),
  grpocup  = c(684, 685),
  rendprnc = c(686, 697),
  rendtds  = c(698, 709),
  rendfnt  = c(710, 721),
  loc      = c(751, 751),
  pespes   = c(752, 756),
  V4745    = c(781, 781)
) )
dds <- dds %>% tibble() %>% filter(dds$uf==23)
write.csv2(dds, "ce12.csv")

rm(list = ls())
txt <- "2013.txt"
dds <- read_fwf(txt, fwf_cols(
  ano      = c(001, 004),
  uf       = c(005, 006),
  sex      = c(018, 018),
  idd      = c(027, 029),
  cor      = c(033, 033),
  curelv   = c(079, 080),
  hras     = c(148, 149),
  anosest  = c(669, 670),
  cndativ  = c(683, 683),
  cndocup  = c(684, 684),
  postrab  = c(685, 686),
  ramativ  = c(687, 688),
  grpocup  = c(689, 690),
  rendprnc = c(691, 702),
  rendtds  = c(703, 714),
  rendfnt  = c(715, 726),
  loc      = c(756, 756),
  pespes   = c(757, 761),
  V4745    = c(786, 786)
) )
dds <- dds %>% tibble() %>% filter(dds$uf==23)
write.csv2(dds, "ce13.csv")

rm(list = ls())
txt <- "2014.txt"
dds <- read_fwf(txt, fwf_cols(
  ano      = c(001, 004),
  uf       = c(005, 006),
  sex      = c(018, 018),
  idd      = c(027, 029),
  cor      = c(033, 033),
  curelv   = c(079, 080),
  hras     = c(371, 372),
  anosest  = c(680, 681),
  cndativ  = c(694, 694),
  cndocup  = c(695, 695),
  postrab  = c(696, 697),
  ramativ  = c(698, 699),
  grpocup  = c(700, 701),
  rendprnc = c(702, 713),
  rendtds  = c(714, 725),
  rendfnt  = c(726, 737),
  loc      = c(767, 767),
  pespes   = c(768, 772),
  V4745    = c(797, 797)
) )
dds <- dds %>% tibble() %>% filter(dds$uf==23)
write.csv2(dds, "ce14.csv")


rm(list = ls())
txt <- "2015.txt"
dds <- read_fwf(txt, fwf_cols(
  ano      = c(001, 004),
  uf       = c(005, 006),
  sex      = c(018, 018),
  idd      = c(027, 029),
  cor      = c(033, 033),
  curelv   = c(077, 078),
  hras     = c(360, 361),
  anosest  = c(703, 704),
  cndativ  = c(717, 717),
  cndocup  = c(718, 718),
  postrab  = c(719, 720),
  ramativ  = c(721, 722),
  grpocup  = c(723, 724),
  rendprnc = c(725, 736),
  rendtds  = c(737, 748),
  rendfnt  = c(749, 760),
  loc      = c(790, 790),
  pespes   = c(791, 795),
  V4745    = c(820, 820)
) )
dds <- dds %>% tibble() %>% filter(dds$uf==23)
write.csv2(dds, "ce15.csv")

# 1) Append the Data =======================================================
rm(list = ls())

ce95 <- read_delim("ce95.csv", ";", escape_double = FALSE,
                   na = "NA", trim_ws = TRUE)
ce95 <- ce95 %>%  mutate_at(vars(everything()), funs(as.numeric))

ce96 <- read_delim("ce96.csv", ";", escape_double = FALSE,
                   na = "NA", trim_ws = TRUE)
ce96 <- ce96 %>%  mutate_at(vars(everything()), funs(as.numeric))

ce97 <- read_delim("ce97.csv", ";", escape_double = FALSE,
                   na = "NA", trim_ws = TRUE)
ce97 <- ce97 %>%  mutate_at(vars(everything()), funs(as.numeric))

ce98 <- read_delim("ce98.csv", ";", escape_double = FALSE,
                   na = "NA", trim_ws = TRUE)
ce98 <- ce98 %>%  mutate_at(vars(everything()), funs(as.numeric))

ce99 <- read_delim("ce99.csv", ";", escape_double = FALSE,
                   na = "NA", trim_ws = TRUE)
ce99 <- ce99 %>%  mutate_at(vars(everything()), funs(as.numeric))

ce01 <- read_delim("ce01.csv", ";", escape_double = FALSE,
                   na = "NA", trim_ws = TRUE)
ce01 <- ce01 %>%  mutate_at(vars(everything()), funs(as.numeric))

ce02 <- read_delim("ce02.csv", ";", escape_double = FALSE,
                   na = "NA", trim_ws = TRUE)
ce02 <- ce02 %>%  mutate_at(vars(everything()), funs(as.numeric))

ce03 <- read_delim("ce03.csv", ";", escape_double = FALSE,
                   na = "NA", trim_ws = TRUE)
ce03 <- ce03 %>%  mutate_at(vars(everything()), funs(as.numeric))

ce04 <- read_delim("ce04.csv", ";", escape_double = FALSE,
                   na = "NA", trim_ws = TRUE)
ce04 <- ce04 %>%  mutate_at(vars(everything()), funs(as.numeric))

ce05 <- read_delim("ce05.csv", ";", escape_double = FALSE,
                   na = "NA", trim_ws = TRUE)
ce05 <- ce05 %>%  mutate_at(vars(everything()), funs(as.numeric))

ce06 <- read_delim("ce06.csv", ";", escape_double = FALSE,
                   na = "NA", trim_ws = TRUE)
ce06 <- ce06 %>%  mutate_at(vars(everything()), funs(as.numeric))

ce07 <- read_delim("ce07.csv", ";", escape_double = FALSE,
                   na = "NA", trim_ws = TRUE)
ce07 <- ce07 %>%  mutate_at(vars(everything()), funs(as.numeric))

ce08 <- read_delim("ce08.csv", ";", escape_double = FALSE,
                   na = "NA", trim_ws = TRUE)
ce08 <- ce08 %>%  mutate_at(vars(everything()), funs(as.numeric))

ce09 <- read_delim("ce09.csv", ";", escape_double = FALSE,
                   na = "NA", trim_ws = TRUE)
ce09 <- ce09 %>%  mutate_at(vars(everything()), funs(as.numeric))

ce11 <- read_delim("ce11.csv", ";", escape_double = FALSE,
                   na = "NA", trim_ws = TRUE)
ce11 <- ce11 %>%  mutate_at(vars(everything()), funs(as.numeric))

ce12 <- read_delim("ce12.csv", ";", escape_double = FALSE,
                   na = "NA", trim_ws = TRUE)
ce12 <- ce12 %>%  mutate_at(vars(everything()), funs(as.numeric))

ce13 <- read_delim("ce13.csv", ";", escape_double = FALSE,
                   na = "NA", trim_ws = TRUE)
ce13 <- ce13 %>%  mutate_at(vars(everything()), funs(as.numeric))

ce14 <- read_delim("ce14.csv", ";", escape_double = FALSE,
                   na = "NA", trim_ws = TRUE)
ce14 <- ce14 %>%  mutate_at(vars(everything()), funs(as.numeric))

ce15 <- read_delim("ce15.csv", ";", escape_double = FALSE,
                   na = "NA", trim_ws = TRUE)
ce15 <- ce15 %>%  mutate_at(vars(everything()), funs(as.numeric))


ce <- bind_rows(ce15, ce14, ce13, ce12, ce11, ce09, ce08, ce07, ce06, ce05,
                ce04, ce03, ce02, ce01, ce99, ce98, ce97, ce96, ce95)

write.csv2(ce, "ce_all.csv")
rm(list = ls())


# 2) Treatment ===============================================

dds<-
  read_delim("ce_all.csv",
                  ";", escape_double = FALSE, trim_ws = TRUE)%>%
  tibble()

dds$X1     = NULL
dds$X1_1   = NULL
dds$pesfam = NULL
dds$uf     = NULL

dds <- dds %>%
  mutate(hras     = as.numeric(hras)) %>%
  mutate(rendfnt  = as.numeric(rendfnt)) %>%
  mutate(rendtds  = as.numeric(rendtds)) %>%
  mutate(rendprnc = as.numeric(rendprnc)) %>%
  mutate(pespes   = as.numeric(pespes)) %>%
  mutate(idd      = as.numeric(idd)) %>%
  mutate(hras     = na_if(hras, "-1")) %>%
  mutate(rendfnt  = na_if(rendfnt, "-1")) %>%
  mutate(rendtds  = na_if(rendtds, "-1")) %>%
  mutate(rendprnc = na_if(rendprnc, "-1")) %>%
  mutate(idd      = na_if(idd, "999")) %>%
  mutate(hras     = na_if(hras, "99")) %>%
  mutate(rendfnt  = na_if(rendfnt, "999999999999")) %>%
  mutate(rendtds  = na_if(rendtds, "999999999999")) %>%
  mutate(rendprnc = na_if(rendprnc,"999999999999"))


attach(dds)
#describe(dds)

temp <- as.character (dds[["ano"]])
temp [dds$ano == 200] <- 2001
temp [dds$ano == 95]  <- 1995
temp [dds$ano == 96]  <- 1996
temp [dds$ano == 97]  <- 1997
temp [dds$ano == 98]  <- 1998
temp [dds$ano == 99]  <- 1999
.GlobalEnv$dds[["ano"]] <- as.numeric (temp) # need be num to apply
remove("temp")          # conditionals in the future. After, transfor to factor

temp <- as.character (dds[["sex"]])
temp[dds$sex == 2] <- "Homem"
temp[dds$sex == 4] <- "Mulher"
.GlobalEnv$dds[["sex"]] <- as.factor (temp)
remove("temp")

temp <- as.character (dds[["cor"]])
temp [dds$cor == 2] <- "Branca"
temp [dds$cor == 4] <- "Preta"
temp [dds$cor == 6] <- "Amarela"
temp [dds$cor == 8] <- "Parda"
temp [dds$cor == 0] <- "Indígena"
temp [dds$cor == 9] <- NA_character_
.GlobalEnv$dds[["cor"]] <- as.factor (temp)
remove("temp")

temp <- as.character (dds[["anosest"]])
temp [dds$anosest == 01] <- "0"
temp [dds$anosest == 02] <- "1"
temp [dds$anosest == 03] <- "2"
temp [dds$anosest == 04] <- "3"
temp [dds$anosest == 05] <- "4"
temp [dds$anosest == 06] <- "5"
temp [dds$anosest == 07] <- "6"
temp [dds$anosest == 08] <- "7"
temp [dds$anosest == 09] <- "8"
temp [dds$anosest == 10] <- "9"
temp [dds$anosest == 11] <- "10"
temp [dds$anosest == 12] <- "11"
temp [dds$anosest == 13] <- "12"
temp [dds$anosest == 14] <- "13"
temp [dds$anosest == 15] <- "14"
temp [dds$anosest == 16] <- "15"
temp [dds$anosest == 17] <- NA_integer_
.GlobalEnv$dds[["anosest"]] <- as.numeric (temp)
remove("temp")

temp <- as.character (dds[["cndativ"]])
temp [dds$cndativ == 1] <- "Econ. Ativa"
temp [dds$cndativ == 2] <- "Não Econ. Ativa"
temp [dds$cndativ == 3] <- NA_character_
.GlobalEnv$dds[["cndativ"]] <- as.factor (temp)
remove("temp")

temp <- as.character (dds[["cndocup"]])
temp [dds$cndocup == 1] <- "Ocupada"
temp [dds$cndocup == 2] <- "Desocupada"
.GlobalEnv$dds[["cndocup"]] <- as.factor (temp)
remove("temp")

dds$postrab <- as.numeric(dds$postrab)
temp <- as.character (dds[["postrab"]])
temp [dds$postrab == 1]                  <- "Empreg cCart"
temp [dds$postrab == 2]                  <- "Militar"
temp [dds$postrab == 3]                  <- "Estatut"
temp [dds$postrab == 4]                  <- "Empreg sCart"
temp [dds$postrab == 5]                  <- "Empreg sCart"
temp [dds$postrab == 6]                  <- "Domest cCart"
temp [dds$postrab == 7]                  <- "Domest sCart"
temp [dds$postrab == 8]                  <- "Domest sCart"
temp [dds$postrab == 9]                  <- "Conta-Própr"
temp [dds$postrab == 10]                 <- "Empregador"
temp [dds$postrab == 11 & dds$ano>=2001] <- "Não Remun"
temp [dds$postrab == 11 & dds$ano<=1999] <- "Prod Própr"
temp [dds$postrab == 12 & dds$ano>=2001] <- "Prod Própr"
temp [dds$postrab == 12 & dds$ano<=1999] <- "Constr Própr"
temp [dds$postrab == 13 & dds$ano>=2001] <- "Constr Própr"
temp [dds$postrab == 13 & dds$ano<=1999] <- "Não Remun"
temp [dds$postrab == 14]                 <- NA_character_
.GlobalEnv$dds[["postrab"]] <- as.factor (temp)
remove("temp")

dds$ramativ <- as.numeric(dds$ramativ)
temp <- as.character (dds[["ramativ"]])
temp [dds$ramativ == 1]                  <- "Agr"
temp [dds$ramativ == 2]                  <- "Ind"
temp [dds$ramativ == 3 & dds$ano>=2001]  <- "Ind"
temp [dds$ramativ == 3 & dds$ano<=1999]  <- "Constr"
temp [dds$ramativ == 4 & dds$ano>=2001]  <- "Constr"
temp [dds$ramativ == 4 & dds$ano<=1999]  <- "Ind"
temp [dds$ramativ == 5]                  <- "Comérc e Rep"
temp [dds$ramativ == 6]                  <- "Aloj e Aliment"
temp [dds$ramativ == 7 & dds$ano>=2001]  <- "Transp Armz Comunc"
temp [dds$ramativ == 7 & dds$ano<=1999]  <- "Serv Aux"
temp [dds$ramativ == 8 & dds$ano>=2001]  <- "Admn Públc"
temp [dds$ramativ == 8 & dds$ano<=1999]  <- "Transp Armz Comunc"
temp [dds$ramativ == 9]                  <- "Educ Saúd Soc"
temp [dds$ramativ == 10 & dds$ano>=2001] <- "Doméstc"
temp [dds$ramativ == 10 & dds$ano<=1999] <- "Admn Públc"
temp [dds$ramativ == 11]                 <- "Outr Serv"
temp [dds$ramativ == 12]                 <- "Outr Serv"
temp [dds$ramativ == 13]                 <- "Outr Serv"
.GlobalEnv$dds[["ramativ"]] <- as.factor (temp)
remove("temp")

dds$grpocup <- as.numeric(dds$grpocup)
temp <- as.character (dds[["grpocup"]])
temp [dds$grpocup == 1 & dds$ano>=2001] <- "Dirigentes"
temp [dds$grpocup == 1 & dds$ano<=1999] <- "Téc Cient Adm"
temp [dds$grpocup == 2 & dds$ano>=2001] <- "Téc Cient Adm"
temp [dds$grpocup == 2 & dds$ano<=1999] <- "Agro"
temp [dds$grpocup == 3 & dds$ano>=2001] <- "Téc Méd"
temp [dds$grpocup == 3 & dds$ano<=1999] <- "Ind"
temp [dds$grpocup == 4 & dds$ano>=2001] <- "Serv Adm"
temp [dds$grpocup == 4 & dds$ano<=1999] <- "Comérc"
temp [dds$grpocup == 5 & dds$ano>=2001] <- "Serv"
temp [dds$grpocup == 5 & dds$ano<=1999] <- "Transp Comunc"
temp [dds$grpocup == 6 & dds$ano>=2001] <- "Comérc"
temp [dds$grpocup == 6 & dds$ano<=1999] <- "Serv"
temp [dds$grpocup == 7 & dds$ano>=2001] <- "Agro"
temp [dds$grpocup == 7 & dds$ano<=1999] <- "Mal Defnd"
temp [dds$grpocup == 8 & dds$ano>=2001] <- "Prod"
temp [dds$grpocup == 8 & dds$ano<=1999] <- NA_character_
temp [dds$grpocup == 9]                 <- "Militar"
temp [dds$grpocup == 10]                <- "Mal Defnd"
.GlobalEnv$dds[["grpocup"]] <- as.factor (temp)
remove("temp")

temp <- as.character (dds[["loc"]])
temp [dds$loc == 1] <- "Urbana"
temp [dds$loc == 2] <- "Urbana"
temp [dds$loc == 3] <- "Urbana"
temp [dds$loc == 5] <- "Rural"
temp [dds$loc == 8] <- "Rural"
.GlobalEnv$dds[["loc"]] <- as.factor (temp)
remove("temp")

dds$curelv <- as.numeric(dds$curelv)
temp <- as.character (dds[["curelv"]])
temp [dds$curelv == 0]                 <- NA_character_
temp [dds$curelv == 1]                 <- "Primário"
temp [dds$curelv == 2]                 <- "Fundamental 1c"
temp [dds$curelv == 3]                 <- "Fundamental 2c"
temp [dds$curelv == 4]                 <- "Funtamental 1g"
temp [dds$curelv == 5]                 <- "Médio 2g"
temp [dds$curelv == 6 & dds$ano>=2001] <- "Suplet Fund"
temp [dds$curelv == 6 & dds$ano<=1999] <- "Superior"
temp [dds$curelv == 7 & dds$ano>=2001] <- "Suplet Méd"
temp [dds$curelv == 7 & dds$ano<=1999] <- "Mestr Dout"
temp [dds$curelv == 8 & dds$ano>=2001] <- "Superior"
temp [dds$curelv == 8 & dds$ano<=1999] <- "Alfbet Adlt"
temp [dds$curelv == 9 & dds$ano>=2001] <- "Mestr Dout"
temp [dds$curelv == 9 & dds$ano<=1999] <- "Pré Esc"
temp [dds$curelv == 10]                <- "Alfbet Adlt"
temp [dds$curelv == 11]                <- "Pré Esc"
temp [dds$curelv == 12]                <- "Alfbet Adlt"
temp [dds$curelv == 13]                <- "Pré Esc"
.GlobalEnv$dds[["curelv"]] <- as.factor (temp)
remove("temp")

dds$V4745 <- as.numeric(dds$V4745)
temp <- as.character (dds[["V4745"]])
temp [dds$V4745 == 1]  <- "Sem Instr"
temp [dds$V4745 == 2]  <- "Fundamental Inc"
temp [dds$V4745 == 3]  <- "Fundamental"
temp [dds$V4745 == 4]  <- "Médio Inc"
temp [dds$V4745 == 5]  <- "Médio"
temp [dds$V4745 == 6]  <- "Superior Inc"
temp [dds$V4745 == 7]  <- "Superior"
temp [dds$V4745 == 8]  <- NA_character_
.GlobalEnv$dds[["V4745"]] <- as.factor (temp)
remove("temp")

temp <- as.character (dds[["curelv"]])
temp[dds$curelv=="Primário"      ] <- 'F1'
temp[dds$curelv=="Fundamental 1c"] <- 'F1'
temp[dds$curelv=="Fundamental 2c"] <- 'F2'
temp[dds$curelv=="Funtamental 1g"] <- 'F1'
temp[dds$curelv=="Médio 2g"      ] <- 'F2'
temp[dds$curelv=="Suplet Fund"   ] <- 'F1'
temp[dds$curelv=="Superior"      ] <- 'F3'
temp[dds$curelv=="Suplet Méd"    ] <- 'F2'
temp[dds$curelv=="Mestr Dout"    ] <- 'F3'
temp[dds$curelv=="Alfbet Adlt"   ] <- 'F1'
temp[dds$curelv=="Pré Esc"       ] <- 'F1'
.GlobalEnv$dds[["familia"]] <- as.factor (temp)
remove("temp")

summary(dds)
glimpse(dds)
write.csv2(dds, "dds.csv")

# 3) Complex Samples Consideration ======================================

dd <- dds %>%
  as_survey_design(strata = ano, weights = pespes) %>%
  group_by(ano)

dd <-  dd %>% convey_prep()

# 4) Kuznets with Variance and Skewness ================================
# 4.1) Base Formation --------------------------------------------------
cnt_fam <- dd %>%
  filter(cndativ=="Econ. Ativa") %>%
  group_by(ano, familia) %>%
  survey_tally()

cnt_fam$n_se <- NULL
cnt_fam <- cnt_fam %>% filter(!is.na(familia))

cnt_fam <- cnt_fam %>%
  pivot_wider(names_from = familia,
              values_from = n)

med_ce <- dd %>%
	filter(cndocup=="Ocupada") %>%
	filter(idd>10) %>%
	filter(rendprnc>0) %>%
	group_by(ano) %>% #, familia) %>% 
	summarise(
		#Idd_méd       = survey_mean (idd,      na.rm = T),
		Esc_méd       = survey_mean (anosest,  na.rm = T),
		#Esc_sd        = survey_sd   (anosest,  na.rm = T),
		#Esc_var       = survey_var  (anosest,  na.rm = T),
		#Hrs_méd       = survey_mean (hras,     na.rm = T),
		Rméd_nom_prnc = survey_mean (rendprnc, na.rm = T),
		Rméd_nom_tds  = survey_mean (rendtds,  na.rm = T),
		Rméd_nom_fnt  = survey_mean (rendfnt,  na.rm = T)
	) %>%
	#filter(!is.na(familia)) %>%
	tibble()
med_ce

# To see that the process of considering the complex sample is correct, compare the variable "Rméd_nom_xxx" with the official data published by IBGE:
# >  http://ftp.ibge.gov.br/Trabalho_e_Rendimento/Pesquisa_Nacional_por_Amostra_de_Domicilios_anual/
# to every year, go to "Unidades da Federação" and choose "Ceara.zip", open the Table 4.22 to confirm with our variable "Rméd_nom_prnc" and Table 4.14 to confirm with our "Rméd_nom_tds"
# The variable "Rméd_nom_fnt" matches the results of Table 1860 for SIDRA. The variable "Rméd_nom_tds" matches the values of Tab 1871 of Cider EXCEPT for 2001. The values of "Rméd_nom_prnc" match the values in Tables 1907 and 1908 in SIDRA:
# https://sidra.ibge.gov.br


cnt_fam <- cnt_fam %>%
	cbind(esc = med_ce$Esc_méd) %>%
	dplyr::rowwise() %>%
	dplyr::mutate(med    = mean    (c(F1,F2,F3)),
				  var    = var2    (c(F1,F2,F3), is.sample=F),
                  skw    = skewness(c(F1,F2,F3), type=1),
                  shrF1  = F1/       (F1+F2+F3),
                  shrF2  = F2/       (F1+F2+F3),
                  shrF3  = F3/       (F1+F2+F3))

rtgrw1 = cnt_fam$F1/lag(cnt_fam$F1)
rtgrw2 = cnt_fam$F2/lag(cnt_fam$F2)
rtgrw3 = cnt_fam$F3/lag(cnt_fam$F3)
cnt_fam <- cnt_fam %>% cbind(rtgrw1, rtgrw2, rtgrw3)
rm(rtgrw1, rtgrw2, rtgrw3)

write.csv2(cnt_fam, "cnt_fam.csv")

cnt_fam_log <- cnt_fam %>%
	dplyr::select(ano, F1, F2, F3, esc) %>%
	dplyr::rowwise() %>%
	dplyr::mutate(logF1 = log10(F1),
				  logF2 = log10(F2),
				  logF3 = log10(F3),
				  med_l = mean(    c(logF1,logF2,logF3)),
				  var_l = var2(    c(logF1,logF2,logF3), is.sample=F),
				  skw_l = skewness(c(logF1,logF2,logF3), type = 1))

rtgrw1 = cnt_fam_log$logF1/lag(cnt_fam_log$logF1)
rtgrw2 = cnt_fam_log$logF2/lag(cnt_fam_log$logF2)
rtgrw3 = cnt_fam_log$logF3/lag(cnt_fam_log$logF3)
cnt_fam_log <- cnt_fam_log %>% cbind(rtgrw1, rtgrw2, rtgrw3)
rm(rtgrw1, rtgrw2, rtgrw3)

write.csv2(cnt_fam_log, "cnt_fam_log.csv")

cnt_fam_lin <- cnt_fam %>%
	dplyr::select(ano, F1, F2, F3, esc) %>%
	dplyr::rowwise() %>%
	dplyr::mutate(linF1   = F1/10^5,
				  linF2   = F2/10^5,
				  linF3   = F3/10^5,
				  med_lin = mean(    c(linF1,linF2,linF3)),
				  var_lin = var2(    c(linF1,linF2,linF3), is.sample=F),
				  skw_lin = skewness(c(linF1,linF2,linF3), type = 1))

rtgrw1 = cnt_fam_lin$linF1/lag(cnt_fam_lin$linF1)
rtgrw2 = cnt_fam_lin$linF2/lag(cnt_fam_lin$linF2)
rtgrw3 = cnt_fam_lin$linF3/lag(cnt_fam_lin$linF3)
cnt_fam_lin <- cnt_fam_lin %>% cbind(rtgrw1, rtgrw2, rtgrw3)
rm(rtgrw1, rtgrw2, rtgrw3)

write.csv2(cnt_fam_lin, "cnt_fam_lin.csv")

# 4.2) Means -----------------------------------------------------------
mean2(cnt_fam$rtgrw1, na.rm=T, output='geom')
mean2(cnt_fam$rtgrw2, na.rm=T, output='geom')
mean2(cnt_fam$rtgrw3, na.rm=T, output='geom')
mean2(cnt_fam_log$rtgrw1, na.rm=T, output='geom')
mean2(cnt_fam_log$rtgrw2, na.rm=T, output='geom')
mean2(cnt_fam_log$rtgrw3, na.rm=T, output='geom')

# 4.3) Visualizations --------------------------------------------------
gg_var <- ggplot(cnt_fam_log, aes(x=esc, y=var_l)) +
  geom_point(size=3)+
  geom_text(mapping = aes(label=ano),
            vjust=1.5) +
  geom_smooth(method = lm,
              formula = y~splines::bs(x, degree=2)) +
  labs(title    = "Ceara's Kuznets Curve for Education, 1995-2015.",
       subtitle = "Average of the Years of Instruction by Variance of the Count of the Groups of Families",
       x = 'Average of Instruction',
       y = 'Variance',
       caption  = "Source: Pnad Annual.  Onw Elaboration.")

gg_skw <- ggplot(cnt_fam_log,aes(x=esc, y=skw_l)) +
  geom_point(size=3)+
  geom_text(mapping = aes(label=ano),
            vjust=1.5) +
  geom_smooth(method = lm,
              formula = y~splines::bs(x, degree=2)) +
  labs(title    = "Ceara's Kuznets Curve for Education, 1995-2015.",
       subtitle = "Average of the Years of Instruction by Skewness of the Count of the Groups of Families",
       x = 'Average of Instruction',
       y = 'Skewness',
       caption  = "Source: Pnad Annual. Onw Elaboration.")

gg_hst <- ggplot(cnt_fam) +
  geom_area(aes(x=ano, y=shrF1, fill='shrF1'),
            alpha=0.5, size=0.8, colour='black') +
  geom_area(aes(x=ano, y=shrF2, fill='shrF2'),
            alpha=0.5, size=0.8, colour='black') +
  geom_area(aes(x=ano, y=shrF3, fill='shrF3'),
            alpha=0.5, size=0.8, colour='black') +
  labs(title = 'Share of the Families in Labour Market of the Ceará. 1995-2015',
       y     = 'Share of Families',
       x     = 'Year',
       colour= 'Families')

gg_hst_A <- ggplot(cnt_fam) +
	geom_area(aes(x=ano, y=F1, fill='F1'),
						alpha=0.5, size=0.8, colour='black') +
	geom_area(aes(x=ano, y=F2, fill='F2'),
						alpha=0.5, size=0.8, colour='black') +
	geom_area(aes(x=ano, y=F3, fill='F3'),
						alpha=0.5, size=0.8, colour='black') +
	labs(title = 'Share of the Families in Labour Market of the Ceará. 1995-2015',
		y      = 'Share of Families',
		x      = 'Year',
		colour = 'Families')

gg_hst
gg_hst_A
gg_var
gg_skw

# 7.4) Regressions With LOG --------------------------------------------
attach(cnt_fam_log)
lm_med <- lm(med_l~splines::bs(esc, degree = 2),
			 data = cnt_fam_log)
lm_var <- lm(var_l~splines::bs(esc, degree = 2),
             data = cnt_fam_log)
lm_skw <- lm(skw_l~splines::bs(esc, degree = 2),
             data = cnt_fam_log)

performance::check_model(lm_med)
performance::check_model(lm_var)
performance::check_model(lm_skw)

summary(lm_med)
summary(lm_var)
summary(lm_skw)
