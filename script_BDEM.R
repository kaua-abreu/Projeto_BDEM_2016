# script roteiro do BDEM - no repositório Projeto_BDEM_2016
# Antes de começar a fazer qualquer coisa:
# a) Coloque todos os arquivos postados no Classroom (já descompactados) dentro do repositório local Projeto_BDEM_2016
# b) commit este roteiro com a mensagem "dados, arquivos de texto e script roteiro BDEM" e envie para o repositório Projeto_BDEM_2016
# c) salve o script com outro nome (script_BDEM.R) e commit com a mensagem "script BDEM" e envie para o repositório Projeto_BDEM_2016

# Ao inserir os comandos em cada Tarefa de cada Etapa, mantenha as linhas de comentários e orientações colocadas pela professora


##################################
# ETAPA 1: BANCO DE DADOS DO SIM
##################################
# Você deve criar e estar na branch SIM antes de inserir os comandos 
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1. Leitura do banco de dados SIM_2016 com 1309774 linhas e 87 colunas com o nome de dados_sim
# Verificar se a leitura foi feita corretamente e a estrutura dos dados

dados_sim = read.csv("SIM_2016.csv", header = TRUE, sep=";")

# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - SIM - tarefa 1" e envie para o repositório Projeto_BDEM_2016


# Tarefa 2. Reduzir dados_sim apenas para as colunas que serão utilizadas, nomeando este novo banco de dados como dados_sim_1
# As colunas serão: 1, 3, 9, 10, 11, 14, 17, 35, 47
# Nomes das respectivas variáveis: CONTADOR, TIPOBITO, IDADE, SEXO, RACACOR, ESC2010, CODMUNRES, TPMORTEOCO, CAUSABAS

dados_sim_1 <- dados_sim[, c(1, 3, 9, 10, 11, 14, 17, 35, 47)]

# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - SIM - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3. Reduzir dados_sim_1 apenas para o estado que o aluno irá trabalhar (utilizar os dois primeiros dígitos de CODMUNRES), nomeando este novo banco de dados como dados_sim_2
# Códigos das UF: 11: RO, 12: AC, 13: AM, 14: RR, 15: PA, 16: AP, 17: TO, 21: MA, 22: PI, 23: CE, 24: RN
# 25: PB, 26: PE, 27: AL, 28: SE, 29: BA, 31: MG, 32: ES, 33: RJ, 35: SP, 41: PR, 42: SC, 43: RS
# 50: MS, 51: MT, 52: GO, 53: DF

dados_sim_2 <- dados_sim_1[substr(dados_sim_1$CODMUNRES, 1, 2) == "31", ]

# observar abaixo o número de óbitos por UF de residência para certificar-se que seu banco de dados está correto
# 11:8344      12:3763     13:16799    14:2157      15:38557     16:2995     17:7490
# 21:34362     22:19187    23:54276    24:21922     25:28041     26:66928    27:20769    28:13516     29:88094
# 31:135257    32:22868    33:141089   35:296359
# 41:74740     42:40270    43:87583
# 50:16749     51:17535    52:38074    53:12050 

str(dados_sim_2)

# Ao terminar a Tarefa 3 commit com a mensagem "script BDEM - SIM - tarefas 1 a 3" e envie para o repositório Projeto_BDEM_2016


# Tarefa 4. Verificar em dados_sim_2 a frequência das categorias das seguintes variáveis:
# TIPOBITO, SEXO, RACACOR, ESC2010, TPMORTEOCO, CAUSABAS
# Avalie também os valores das variável IDADE (não estranhe mas idade é composta de um dígito inicial que indica a unidade de medida)
# Unidades de medida a serem consideradas em IDADE: 0: minutos, 1: horas, 2: dias, 3: meses, 4: anos, 5: idade maior que 100 anos
# Atenção: a unidade de medida de IDADE no DICIONÀRIO do SIM está errada
# O propósito das avaliações acima é verificar se as categorias estão de acordo com o dicionário do SIM ou se aparecem categorias estranhas

table(dados_sim_2$TIPOBITO) # Em todos os registros é 2 (?)
table(dados_sim_2$SEXO) # 0? Provavelmente NA
table(dados_sim_2$RACACOR)
table(dados_sim_2$ESC2010)
table(dados_sim_2$TPMORTEOCO)
table(dados_sim_2$CAUSABAS)

table(dados_sim_2$IDADE) # Idade 999, provavelmente NA

# Ao terminar a Tarefa 4 commit com a mensagem "script BDEM - SIM - tarefas 1 a 4" e envie para o repositório Projeto_BDEM_2016


# Tarefa 5. Atribuir para cada variável de dados_sim_2 como sendo NA a categoria de "Não informado ou Ignorado", 
# geralmente com código 9
# Verifique o dicionário do SIM para identificar qual o código das categorias de cada variável
# Em variáveis quantitativas como IDADE verificar se existem valores como 9999 para NA

dados_sim_2$IDADE[dados_sim_2$IDADE == 999] <- NA

dados_sim_2$SEXO[dados_sim_2$SEXO == 0] <- NA

dados_sim_2$ESC2010[dados_sim_2$ESC2010 == 9] <- NA

dados_sim_2$ESC2010[dados_sim_2$TPMORTEOCO == 9] <- NA

# Ao terminar a Tarefa 5 commit com a mensagem "script BDEM - SIM - tarefas 1 a 5" e envie para o repositório Projeto_BDEM_2016


# Tarefa 6. Atribuir legendas para as categorias das variáveis qualitativas investigadas na tarefa 4.
# Exemplo: dados_sim_2$TIPOBITO = factor(dados_sim_2$TIPOBITO, levels = c(1,2), labels = c("Fetal", "Não fetal")

# ATENçÃO: 1. Na hora de escrever os labels, somente a PRIMEIRA LETRA da legenda é maiúscula. Exemplo para SEXO: Feminino e Masculino
#          2. Nesta Tarefa 6 não crie novas variáveis dentro do banco de dados

dados_sim_2$SEXO = factor(dados_sim_2$SEXO, levels = c(1,2), labels = c("Masculino", "Feminino"))
dados_sim_2$TIPOBITO = factor(dados_sim_2$TIPOBITO, levels = c(1,2), labels = c("Fetal", "Não fetal"))
dados_sim_2$RACACOR = factor(dados_sim_2$RACACOR, levels = 1:5, labels = c("Branca", "Preta", "Amarela", "Parda", "Indígena"))
dados_sim_2$ESC2010 = factor(dados_sim_2$ESC2010, levels = 0:5, labels = c("Sem escolaridade", "Fundamental I (1° a 4° série)", "Fundamental II (5° a 8° série)", "Médio (antigo 2° Grau)", "Superior incompleto", "Superior completo"))
#dados_sim_2$TPMORTEOCO = factor(dados_sim_2$TPMORTEOCO, levels = c(1:5, 8), labels = c("na gravidez", "no parto", "no abortamento", "até 42 dias após o término do parto", "de 43 dias a 1 ano após o término da gestação", "não ocorreu nestes períodos")) -- CORREÇÃO ABAIXO


# Ao terminar a Tarefa 6 commit com a mensagem "script BDEM - SIM - tarefas 1 a 6" e envie para o repositório Projeto_BDEM_2016


# Tarefa 7. Criar um banco de dados, de nome SIM_UF.csv (Exemplo: SIM_RJ.csv), contendo as variáveis listadas no arquivo “Variáveis - Projeto - Tarefa 7 - SIM.pdf”
# Atenção: a ordem das variáveis do arquivo deve ser respeitada

# AO FAZER A TAREFA 7, PERCEBI UM ERRO COMETIDO DURANTE A TAREFA 6, ESQUECI DE COLOCAR A PRIMEIRA LETRA MAIÚSCULA NA LEGENDA DA VARIÁVEL TPMORTEOCO. CORRIGIREI ABAIXO E COMENTAREI A LINHA ERRADA...

dados_sim_2$TPMORTEOCO = factor(dados_sim_2$TPMORTEOCO, levels = c(1:5, 8), labels = c("Na gravidez", "No parto", "No abortamento", "Até 42 dias após o término do parto", "De 43 dias a 1 ano após o término da gestação", "Não ocorreu nestes períodos"))

# Não incluirei o UF nas variáveis agora

# Variável TO

TO <- as.data.frame(table(dados_sim_2$CODMUNRES))
names(TO) <- c("CODMUNRES", "TO")

# Variável TORC

registrosSemNA <- na.omit(dados_sim) # 0 registros completos

TORC <- as.data.frame(table(dados_sim_2$CODMUNRES))
TORC$Freq <- 0
names(TORC) <- c("CODMUNRES", "TORC")

# Variável TORCR

registrosSemNA2 <- na.omit(dados_sim_2)

TORCR <- as.data.frame(table(registrosSemNA2$CODMUNRES))
names(TORCR) <- c("CODMUNRES", "TORCR")

# Função para ajudar nas variáveis que envolvem os códigos do CID-10

causas <- dados_sim_2$CAUSABAS

SelecionarDoencas <- function(nomeVar, lim_inf, lim_sup){
  Resultado <- dados_sim_2[causas >= lim_inf & causas <= lim_sup,]
  Resultado <- as.data.frame(table(Resultado$CODMUNRES))
  names(Resultado) <- c("CODMUNRES", nomeVar)
  return(Resultado)
}

# Variável TO_NN

TO_NN <- SelecionarDoencas("TO_NN", "V01", "Y98")

# Variável TO_N

TO_N <- merge(TO, TO_NN, by = "CODMUNRES", all.x = TRUE)
TO_N[is.na(TO_N)] <- 0
TO_N$TO_N <- TO_N$TO - TO_N$TO_NN
TO_N <- TO_N[, -(2:3)]

# Variável TO_CB_I

TO_CB_I <- SelecionarDoencas("TO_CB_I", "A00", "B99")

# Variável TO_CB_N

Tabela1 <- SelecionarDoencas("C00-D48", "C00", "D48")
Tabela2 <- SelecionarDoencas("D50-D89", "D50", "D89")

TO_CB_N <- merge(Tabela1, Tabela2, all = TRUE)
TO_CB_N[is.na(TO_CB_N)] <- 0

TO_CB_N$TO_CB_N <- TO_CB_N$`D50-D89` + TO_CB_N$`C00-D48`

TO_CB_N <- TO_CB_N[, -(2:3)]

# Variável TO_CB_C

TO_CB_C <- SelecionarDoencas("TO_CB_C", "I00", "I99")

# Variável TO_CB_R

TO_CB_R <- SelecionarDoencas("TO_CB_R", "J00", "J99")

# Variável TO_CB_O

Temp1 <- merge(TO_CB_I, TO_CB_N, all = TRUE)
Temp2 <- merge(TO_CB_R, TO_CB_C, all = TRUE)
Temp3 <- merge(Temp1, Temp2, all = TRUE)

TO_CB_O <- merge(TO_N, Temp3, all = TRUE)
TO_CB_O[is.na(TO_CB_O)] <- 0

TO_CB_O$TO_CB_O <- TO_CB_O$TO_N - TO_CB_O$TO_CB_I - TO_CB_O$TO_CB_N - TO_CB_O$TO_CB_R - TO_CB_O$TO_CB_C

TO_CB_O <- TO_CB_O[, -(2:6)]

# Variável TO_M

TO_M <- dados_sim_2[dados_sim_2$SEXO == "Masculino",]
TO_M <- as.data.frame(table(TO_M$CODMUNRES))
names(TO_M) <- c("CODMUNRES", "TO_M")

# Variável TO_F

TO_F <- merge(TO, TO_M, all = TRUE)
TO_F$TO_F <- TO_F$TO - TO_F$TO_M
TO_F <- TO_F[, -(2:3)]

# Variável TO_F_IF

IdadeFertil <- dados_sim_2[dados_sim_2$IDADE >= "415" & dados_sim_2$IDADE <= "449",]
Sexo <- IdadeFertil[IdadeFertil$SEXO == "Feminino",]
TO_F_IF <- as.data.frame(table(Sexo$CODMUNRES))
names(TO_F_IF) <- c("CODMUNRES", "TO_F_IF")

Teste <- dados_sim_2[!is.na(dados_sim_2$TPMORTEOCO),]
Teste2 <- as.data.frame(table(Teste$CODMUNRES))
names(Teste2) <- c("CODMUNRES", "TO_F_IF")

# Variável TO_FT

ObitosFetais <- dados_sim_2[dados_sim_2$TIPOBITO == "Fetal",]

TO_FT <- as.data.frame(table(dados_sim_2$CODMUNRES))
names(TO_FT) <- c("CODMUNRES", "TO_FT")

# Funções para ajudar nas variáveis de informações fetais e neonatais

Idade <- dados_sim_2$IDADE
RacaCor <- dados_sim_2$RACACOR

SelecionarPorIdade <- function(nomeVar, lim_inf, lim_sup) {
  Filtro <- dados_sim_2[Idade >= lim_inf & Idade <= lim_sup,]
  Resultado <- as.data.frame(table(Filtro$CODMUNRES))
  names(Resultado) <- c("CODMUNRES", nomeVar)
  return(Resultado)
}

SelecionarPorRacaCor <- function(nomeVar, raca) {
  Filtro <- dados_sim_2[RacaCor == raca & Idade >= 0 & Idade <= 227,]
  Resultado <- as.data.frame(table(Filtro$CODMUNRES))
  names(Resultado) <- c("CODMUNRES", nomeVar)
  return(Resultado)
}

# Variáveis TO_NT até TO_PNTT

TO_NT <- SelecionarPorIdade("TO_NT", 0, 227)

TO_NT_P <- SelecionarPorIdade("TO_NT_P", 0, 206)

TO_NT_T <- SelecionarPorIdade("TO_NT_T", 207, 227)

TO_PNT <- SelecionarPorIdade("TO_PNT", 228, 311)

# Variáveis TONT_B até TONT_I

TONT_B <- SelecionarPorRacaCor("TONT_B", "Branca")
TONT_PT <- SelecionarPorRacaCor("TONT_PT", "Preta")
TONT_A <- SelecionarPorRacaCor("TONT_A", "Amarela")
TONT_PD <- SelecionarPorRacaCor("TONT_PD", "Parda")
TONT_I <- SelecionarPorRacaCor("TONT_I", "Indígena")

# Função para ajudar nas variáveis de informações maternas

TpMorteOco <- dados_sim_2$TPMORTEOCO

SelecionarPorTpMorte <- function (nomeVar, indices){
  Filtro <- dados_sim_2[as.integer(TpMorteOco) %in% indices & !is.na(TpMorteOco),]
  Resultado <- as.data.frame(table(Filtro$CODMUNRES))
  names(Resultado) <- c("CODMUNRES", nomeVar)
  return(Resultado)
}

levels(TpMorteOco) # Para ver os indíces corretos
# [1] "Na gravidez"                                  
# [2] "No parto"                                     
# [3] "No abortamento"                               
# [4] "Até 42 dias após o término do parto"          
# [5] "De 43 dias a 1 ano após o término da gestação"
# [6] "Não ocorreu nestes períodos"

# Variáveis TO_MT até TO_MT_P

TO_MT <- SelecionarPorTpMorte("TO_MT", 1:5)
TO_MT_DG <- SelecionarPorTpMorte("TO_MT_DG", 1)
TO_MT_PT <- SelecionarPorTpMorte("TO_MT_PT", 2)
TO_MT_AB <- SelecionarPorTpMorte("TO_MT_AB", 3)
TO_MT_42 <- SelecionarPorTpMorte("TO_MT_42", 4)
TO_MT_43 <- SelecionarPorTpMorte("TO_MT_43", 5)
TO_MT_P <- SelecionarPorTpMorte("TO_MT_P", 1:4)

# Variável TO_MT_P_I

Filtro <- dados_sim_2[as.integer(TpMorteOco) %in% 1:4 & !is.na(TpMorteOco) & Idade >= 415 & Idade <= 449,]
TO_MT_P_I <- as.data.frame(table(Filtro$CODMUNRES))
names(TO_MT_P_I) <- c("CODMUNRES", "TO_MT_P_I")

# Variáveis TO_MT_P_ES até TO_MT_P_ESC

Escolaridade <- dados_sim_2$ESC2010

SelecionarPorEscolaridade <- function(nomeVar, indice_esc){
  Filtro <- dados_sim_2[as.integer(TpMorteOco) %in% 1:4 & !is.na(TpMorteOco) & as.integer(Escolaridade) == indice_esc,]
  Resultado <- as.data.frame(table(Filtro$CODMUNRES))
  names(Resultado) <- c("CODMUNRES", nomeVar)
  return(Resultado)
}

levels(Escolaridade)
# [1] "Sem escolaridade"              
# [2] "Fundamental I (1° a 4° série)" 
# [3] "Fundamental II (5° a 8° série)"
# [4] "Médio (antigo 2° Grau)"        
# [5] "Superior incompleto"           
# [6] "Superior completo" 

TO_MT_P_ES <- SelecionarPorEscolaridade("TO_MT_P_ES", 1)
TO_MT_P_EFI <- SelecionarPorEscolaridade("TO_MT_P_EFI", 2)
TO_MT_P_EFII <- SelecionarPorEscolaridade("TO_MT_P_EFII", 3)
TO_MT_P_EM <- SelecionarPorEscolaridade("TO_MT_P_EM", 4)
TO_MT_P_ESI <- SelecionarPorEscolaridade("TO_MT_P_ESI", 5)
TO_MT_P_ESC <- SelecionarPorEscolaridade("TO_MT_P_ESC", 6)

# Juntando as variáveis

variaveis <- list(TO, TORC, TORCR, TO_NN, TO_N, TO_CB_I, TO_CB_N, TO_CB_C, TO_CB_R, TO_CB_O, TO_M, TO_F, TO_F_IF, TO_FT, TO_NT, TO_NT_P, TO_NT_T, TO_PNT, TONT_B, TONT_PT, TONT_A, TONT_PD, TONT_I, TO_MT, TO_MT_DG, TO_MT_PT, TO_MT_AB, TO_MT_42, TO_MT_43, TO_MT_P, TO_MT_P_I, TO_MT_P_ES, TO_MT_P_EFI, TO_MT_P_EFII, TO_MT_P_EM, TO_MT_P_ESI, TO_MT_P_ESC)

ANO <- "2016"
NIVEL <- "MUNICIPIO"

SIM_MG <- Reduce(function (x,y) merge(x,y, all = TRUE, by = "CODMUNRES"), variaveis)

SIM_MG[is.na(SIM_MG)] <- 0
SIM_MG <- cbind(ANO, NIVEL, SIM_MG)

UF <- SIM_MG[1,]
UF$NIVEL <- "UF"
UF$CODMUNRES <- "31"

cols <- sapply(SIM_MG, is.numeric)
UF[cols] <- colSums(SIM_MG[, cols])

SIM_MG <- rbind(UF, SIM_MG)

# Ao terminar a Tarefa 7 commit com a mensagem "script BDEM - SIM - tarefas 1 a 7" e envie para o repositório Projeto_BDEM_2016


# Tarefa 8. Exportar o banco de dados com o nome SIM_UF.csv (Exemplo: SIM_RJ.csv)

# Ao terminar a Tarefa 8 fazer um commit com o comentário "dados SIM_UF 2016 e script - SIM - tarefas 1 a 8"  e envie para o repositório Projeto_BDEM_2016

write.csv2(SIM_MG, file = "SIM_MG.csv", row.names = FALSE)

####################################
# ETAPA 2: BANCO DE DADOS DO SINASC
####################################
# Você deve criar e estar na branch SINASC antes de inserir os comandos 
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1. Leitura do banco de dados SINASC_2016 com 2857800 linhas e 61 colunas com o nome de dados_sinasc
# Verificar se a leitura foi feita corretamente e a estrutura dos dados
# Por uma questão de padronização coloque todos os nomes das variáveis em letra maiúscula,
# usando o comando names(dados_sinasc) = toupper(names(dados_sinasc))

dados_sinasc <- read.csv("SINASC_2016.csv", header=TRUE, sep=";")
names(dados_sinasc) <- toupper(names(dados_sinasc))

# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - SINASC - tarefa 1" e envie para o repositório Projeto_BDEM_2016

# Tarefa 2. Reduzir dados_sinasc apenas para as colunas que serão utilizadas, nomeando este novo banco de dados como dados_sinasc_1
# As colunas serão 3, 4, 5, 6, 11, 12, 13, 14, 18, 20, 21, 22, 23, 34, 37, 43, 47, 58, 59, 60, 61
# Nomes das respectivas variáveis: CODMUNNASC, LOCNASC, IDADEMAE, ESTCIVMAE, CODMUNRES, GESTACAO, GRAVIDEZ, PARTO, 
# SEXO, APGAR5, RACACOR, PESO, IDANOMAL, ESCMAE2010, RACACORMAE, SEMAGESTAC, TPAPRESENT, TPROBSON, PARIDADE, KOTELCHUCK, CONTADOR

dados_sinasc_1 <- dados_sinasc[, c(3,4,5,6,11,12,13,14,18,20,21,22,23,34,37,43,47,58,59,60,61)]

# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3. Reduzir dados_sinasc_1 apenas para o estado que o aluno irá trabalhar (utilizar os dois primeiros dígitos de CODMUNRES), nomeando este novo banco de dados como dados_sinasc_2
# Códigos das UF: 11: RO, 12: AC, 13: AM, 14: RR, 15: PA, 16: AP, 17: TO, 21: MA, 22: PI, 23: CE, 24: RN
# 25: PB, 26: PE, 27: AL, 28: SE, 29: BA, 31: MG, 32: ES, 33: RJ, 35: SP, 41: PR, 42: SC, 43: RS
# 50: MS, 51: MT, 52: GO, 53: DF 

# observar abaixo o número de nascimentos por UF de residência para certificar-se que seu banco de dados está correto
# 11: 26602     12: 15773     13: 76703     14: 11376     15: 137681    16: 15521      17: 23870
# 21: 110493    22: 46986     23: 126246    24: 45366     25: 56083     26: 130733     27: 48164     28: 32218     29: 199830
# 31: 253520    32: 53413     33: 219129    35: 601437     
# 41: 155066    42: 95313     43: 141411
# 50: 42432     51: 53531     52: 95563     53: 43340 

dados_sinasc_2 <- dados_sinasc_1[substr(dados_sinasc_1$CODMUNRES, 1, 2) == "31",]

# Ao terminar a Tarefa 3 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 3" e envie para o repositório Projeto_BDEM_2016


# Tarefa 4. Verificar em dados_sinasc_2 a frequência das categorias das seguintes variáveis: LOCNASC, ESTCIVMAE, GESTACAO, GRAVIDEZ, PARTO,
# SEXO, RACACOR, IDANOMAL, ESCMAE2010, RACACORMAE, TPAPRESENT, TPROBSON, PARIDADE, KOTELCHUCK
# Avalie também os valores das variáveis quantitativas de IDADEMAE, SEMAGESTAC, APGAR5 e PESO

table(dados_sinasc_2$LOCNASC) # Valores 9, possivelmente NA?
table(dados_sinasc_2$ESTCIVMAE) # Valores 9, possivelmente NA?
table(dados_sinasc_2$GESTACAO) # Valores 9, possivelmente NA?
table(dados_sinasc_2$GRAVIDEZ) # Valores 9, possivelmente NA?
table(dados_sinasc_2$PARTO) # Valores 9, possivelmente NA?
table(dados_sinasc_2$SEXO) # Valores 0??
table(dados_sinasc_2$RACACOR)
table(dados_sinasc_2$IDANOMAL)  # Valores 9, possivelmente NA?
table(dados_sinasc_2$ESCMAE2010) # Valores 9, possivelmente NA?
table(dados_sinasc_2$RACACORMAE)
table(dados_sinasc_2$TPAPRESENT) # Valores 9, possivelmente NA?
table(dados_sinasc_2$TPROBSON)
table(dados_sinasc_2$PARIDADE)
table(dados_sinasc_2$KOTELCHUCK)  # Valores 9, possivelmente NA?

table(dados_sinasc_2$IDADEMAE)
table(dados_sinasc_2$SEMAGESTAC)
table(dados_sinasc_2$APGAR5) # Valores 99?
table(dados_sinasc_2$PESO) # Não consegui ver todos os valores, tentarei outra coisa...

max(dados_sinasc_2$PESO, na.rm = TRUE) # Tem pelo menos um registro com valor 9999, provavelmente NA

# Ao terminar a Tarefa 4 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 4" e envie para o repositório Projeto_BDEM_2016


# Tarefa 5. Atribuir para cada variável de dados_sinasc_2 como sendo NA a categoria de "Não informado ou Ignorado", 
# geralmente com código 9
# Verifique o dicionário do SINASC para identificar qual o código das categorias de cada variável
# KOTELCHUCK = 9 significa "Não informado"   TPROBSON = 11 significa "Não classificado por falta de informação"
# Em variáveis quantitativas como IDADEMAE verificar se existem valores como 9999 para NA

NAs9 <- c("LOCNASC", "ESTCIVMAE", "GESTACAO", "GRAVIDEZ", "PARTO", "IDANOMAL", "ESCMAE2010", "TPAPRESENT", "KOTELCHUCK") # Todas as variáveis com NA representado por 9

for (variaveis in NAs9) {
  dados_sinasc_2[[variaveis]][ dados_sinasc_2[[variaveis]] == 9 ] <- NA
  print(any( dados_sinasc_2[[variaveis]] == 9 & !is.na(dados_sinasc_2[[variaveis]] ))) # Para ver se o comando funcionou
}

dados_sinasc_2$SEXO[dados_sinasc_2$SEXO == 0] <- NA

dados_sinasc_2$TPROBSON[dados_sinasc_2$TPROBSON == 11] <- NA

dados_sinasc_2$APGAR5[dados_sinasc_2$APGAR5 == 99] <- NA

dados_sinasc_2$PESO[dados_sinasc_2$PESO == 9999] <- NA

# Ao terminar a Tarefa 5 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 5" e envie para o repositório Projeto_BDEM_2016


# Tarefa 6. Atribuir legendas para as categorias das variáveis qualitativas investigadas na tarefa 4.
# Exemplo: dados_sinasc_2$KOTELCHUCK = factor(dados_sinasc_2$KOTELCHUCK, levels = c(1,2,3,4,5), 
# labels = c("Não realizou pré-natal", "Inadequado", "Intermediário", "Adequado",  
# "Mais que adequado")

# ATENçÃO: 1. Na hora de escrever os labels, somente a primeira letra da legenda é maiúscula. Exemplo para SEXO: Feminino e Masculino
#          2. Nesta Tarefa 6 não crie novas variáveis dentro do banco de dados

dados_sinasc_2$LOCNASC = factor(dados_sinasc_2$LOCNASC, levels = 1:5, labels = c("Hospital", "Outros estabelecimentos de saúde", "Domicílio", "Outros", "Aldeia indígena"))

dados_sinasc_2$ESTCIVMAE = factor(dados_sinasc_2$ESTCIVMAE, levels = 1:5, labels = c("Solteira", "Casada", "Viúva", "Separada judicialmente/divorciada", "União estável"))

dados_sinasc_2$GESTACAO = factor(dados_sinasc_2$GESTACAO, levels = 1:6, labels = c("Menos de 22 semanas", "22 a 27 semanas", "28 a 31 semanas", "32 a 36 semanas", "37 a 41 semanas", "42 semanas e mais"))

dados_sinasc_2$GRAVIDEZ = factor(dados_sinasc_2$GRAVIDEZ, levels = 1:3, labels = c("Única", "Dupla", "Tripla ou mais"))

dados_sinasc_2$PARTO = factor(dados_sinasc_2$PARTO, levels = 1:2, labels = c("Vaginal", "Cesário"))

dados_sinasc_2$SEXO = factor(dados_sinasc_2$SEXO, levels = 1:2, labels = c("Masculino", "Feminino"))

dados_sinasc_2$RACACOR = factor(dados_sinasc_2$RACACOR, levels = 1:5, labels = c("Branca", "Preta", "Amarela", "Parda", "Indígena"))
dados_sinasc_2$RACACORMAE = factor(dados_sinasc_2$RACACORMAE, levels = 1:5, labels = c("Branca", "Preta", "Amarela", "Parda", "Indígena"))

dados_sinasc_2$IDANOMAL = factor(dados_sinasc_2$IDANOMAL, levels = 1:2, labels = c("Sim", "Não"))

dados_sinasc_2$ESCMAE2010 = factor(dados_sinasc_2$ESCMAE2010, levels = 0:5, labels = c("Sem escolaridade", "Fundamental I (1° a 4° série)", "Fundamental II (5° a 8° série)", "Médio (antigo 2° Grau)", "Superior incompleto", "Superior completo"))

dados_sinasc_2$TPAPRESENT = factor(dados_sinasc_2$TPAPRESENT, levels = 1:3, labels = c("Cefálico", "Pélvica ou podálica", "Transversa"))

dados_sinasc_2$PARIDADE = factor(dados_sinasc_2$PARIDADE, levels = 0:1, labels = c("Multípara", "Nulípara"))

dados_sinasc_2$KOTELCHUCK = factor(dados_sinasc_2$KOTELCHUCK, levels = 1:5, labels = c("Não realizou pré-natal", "Inadequado", "Intermediário", "Adequado", "Mais que adequado"))

# Ao terminar a Tarefa 6 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 6" e envie para o repositório Projeto_BDEM_2016


# Tarefa 7. Categorizar as variáveis IDADEMAE, PESO e APGAR5 e criar variáveis referentes ao deslocamento materno (peregrinação) e estado civil
# nova variável: dados_sinasc_2$F_PESO com PESO: < 2500: Baixo peso, >=2500 e < 4000: Peso normal, >= 4000: Macrossomia
# nova variável dados_sinasc_2$F_IDADE com IDADEMAE: <15, 15-19, 20-24, 25-29, 30-34, 35-39, 40-44, 45-49, 50+
# nova variável dados_sinasc_2$F_APGAR5 com APGAR5: < 7: Baixo, >= 7: Normal
# Atenção para casos de NA em IDADEMAE, PESO e APGAR5
# nova variável: dados_sinasc_2$PEREG: Não: CODMUNNASC igual a CODMUNRES, Sim: CODMUNNASC diferente de CODMUNRES
# nova variável: dados_sinasc_2$ESTCIV: Sem companheiro: ESTCIVMAE 1, 3 ou 4, Com companheiro: ESTCIVMAE 2 ou 5
# Ao categorizar as variáveis, garantir que sejam transformadas em tipo fator

dados_sinasc_2$F_APGAR5 = ifelse(dados_sinasc_2$APGAR5 < 7, 0, 1)
dados_sinasc_2$F_APGAR5 = factor(dados_sinasc_2$F_APGAR5, levels = 0:1, labels = c("Baixo", "Normal"))

dados_sinasc_2$PEREG = ifelse(dados_sinasc_2$CODMUNNASC == dados_sinasc_2$CODMUNRES, 0, 1)
dados_sinasc_2$PEREG = factor(dados_sinasc_2$PEREG, levels = 0:1, labels = c("Não", "Sim"))

dados_sinasc_2$ESTCIV = ifelse(as.integer(dados_sinasc_2$ESTCIVMAE) == 2 | as.integer(dados_sinasc_2$ESTCIVMAE) == 5, 1, 0)
dados_sinasc_2$ESTCIV = factor(dados_sinasc_2$ESTCIV, levels = 0:1, labels = c("Sem companheiro", "Com companheiro"))

dados_sinasc_2$F_PESO <- 1
dados_sinasc_2$F_PESO[dados_sinasc_2$PESO < 2500] <- 0
dados_sinasc_2$F_PESO[dados_sinasc_2$PESO >= 4000] <- 2
dados_sinasc_2$F_PESO = factor(dados_sinasc_2$F_PESO, levels = 0:2, labels = c("Baixo peso", "Peso normal", "Macrossomia"))

dados_sinasc_2$F_IDADE[dados_sinasc_2$IDADEMAE < 15] <- 0
dados_sinasc_2$F_IDADE[dados_sinasc_2$IDADEMAE >= 15 & dados_sinasc_2$IDADEMAE <= 19] <- 1
dados_sinasc_2$F_IDADE[dados_sinasc_2$IDADEMAE >= 20 & dados_sinasc_2$IDADEMAE <= 24] <- 2
dados_sinasc_2$F_IDADE[dados_sinasc_2$IDADEMAE >= 25 & dados_sinasc_2$IDADEMAE <= 29] <- 3
dados_sinasc_2$F_IDADE[dados_sinasc_2$IDADEMAE >= 30 & dados_sinasc_2$IDADEMAE <= 34] <- 4
dados_sinasc_2$F_IDADE[dados_sinasc_2$IDADEMAE >= 35 & dados_sinasc_2$IDADEMAE <= 39] <- 5
dados_sinasc_2$F_IDADE[dados_sinasc_2$IDADEMAE >= 40 & dados_sinasc_2$IDADEMAE <= 44] <- 6
dados_sinasc_2$F_IDADE[dados_sinasc_2$IDADEMAE >= 45 & dados_sinasc_2$IDADEMAE <= 49] <- 7
dados_sinasc_2$F_IDADE[dados_sinasc_2$IDADEMAE >= 50] <- 8
dados_sinasc_2$F_IDADE = factor(dados_sinasc_2$F_IDADE, levels = 0:8, labels = c("<15", "15-19", "20-24", "25-29", "30-34", "35-39", "40-44", "45-49", "50+"))

# Ao terminar a Tarefa 7 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 7" e envie para o repositório Projeto_BDEM_2016


# Tarefa 8. Agregar ao banco de dados_sinasc_2 as informações PESO_P10 e PESO_P90 a partir de Tabela_PIG_Brasil.csv
# a Tabela PIG informa P10 e P90 dos pesos, de acordo com a idade gestacional
# Criar nova variável referente ao peso, de acordo com a idade gestacional, conforme indicado abaixo
# nova variável apenas para casos de GRAVIDEZ Única: dados_sinasc_2$F_PIG: PIG: PESO < PESO_P10, AIG: PESO_P10 <= PESO <= PESO_P90, GIG: PESO > PESO_P90
# Atenção para casos de NA em SEMAGESTAC, PESO ou SEXO. Lembre-se também que em dados_sinasc_2 SEXO está como fator com as categorias Feminino e Masculino.

tabela_pig <- read.csv(file="Tabela_PIG_Brasil.csv", header=TRUE, sep=";")

teste <- merge(dados_sinasc_2, tabela_pig, by=c("SEMAGESTAC", "SEXO"), all.x = TRUE)

dados_sinasc_2 <- teste

dados_sinasc_2$F_PIG <- ifelse(dados_sinasc_2$PESO < dados_sinasc_2$PESO_P10, "PIG", ifelse(dados_sinasc_2$PESO > dados_sinasc_2$PESO_P90, "GIG", "AIG"))

# Garantindo os NAs

dados_sinasc_2$F_PIG[is.na(dados_sinasc_2$SEMAGESTAC)] <- NA
dados_sinasc_2$F_PIG[is.na(dados_sinasc_2$SEXO)] <- NA
dados_sinasc_2$F_PIG[is.na(dados_sinasc_2$PESO)] <- NA

dados_sinasc_2$F_PIG[dados_sinasc_2$GRAVIDEZ != "Única"] <- NA
dados_sinasc_2$F_PIG[is.na(dados_sinasc_2$GRAVIDEZ)] <- NA

# Ao terminar a Tarefa 8 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 8" e envie para o repositório Projeto_BDEM_2016


# Tarefa 9. Criar um banco de dados, de nome SINASC_UF.csv (Exemplo: SINASC_RJ.csv), contendo as variáveis listadas no arquivo “Variáveis - Projeto - Tarefa 9 - SINASC.pdf”
# Atenção: a ordem das variáveis do arquivo deve ser respeitada

# Variáveis sobre nascimentos

TN <- as.data.frame(table(dados_sinasc_2$CODMUNRES))
names(TN) <- c("CODMUNRES", "TN")

dados_originais <- dados_sinasc[substr(dados_sinasc$CODMUNRES, 1, 2) == "31",]
dadosSemNA <- na.omit(dados_originais) # data frame com 0 registros

TNRC <- TN
names(TNRC) <- c("CODMUNRES", "TNRC")
TNRC$TNRC <- 0

teste <- dados_sinasc_1[substr(dados_sinasc_1$CODMUNRES, 1, 2) == "31",] # dados_sinasc_1 já contém nossas variáveis selecionadas
dadosSemNA2 <- na.omit(teste)

TNRCR <- as.data.frame(table(dadosSemNA2$CODMUNRES))
names(TNRCR) <- c("CODMUNRES", "TNRCR")

# Variáveis sobre as gestantes

TGI_15 <- dados_sinasc_2[dados_sinasc_2$IDADEMAE < 15,]
TGI_15 <- as.data.frame(table(TGI_15$CODMUNRES))
names(TGI_15) <- c("CODMUNRES", "TGI_15")

Idade <- dados_sinasc_2$IDADEMAE

SelecionarPorIdade <- function(lim_inf, lim_sup, nomeVar){
  temp <- dados_sinasc_2[Idade <= lim_sup & Idade >= lim_inf,]
  resultado <- as.data.frame(table(temp$CODMUNRES))
  names(resultado) <- c("CODMUNRES", nomeVar)
  return(resultado)
}

TGI_15_19 <- SelecionarPorIdade(15, 19, "TGI_15_19")
TGI_20_24 <- SelecionarPorIdade(20, 24, "TGI_20_24")
TGI_25_29 <- SelecionarPorIdade(25, 29, "TGI_25_29")
TGI_30_34 <- SelecionarPorIdade(30, 34, "TGI_30_34")
TGI_35_39 <- SelecionarPorIdade(35, 39, "TGI_35_39")
TGI_40_44 <- SelecionarPorIdade(40, 44, "TGI_40_44")
TGI_45_49 <- SelecionarPorIdade(45, 49, "TGI_45_49")

TGI_50 <- dados_sinasc_2[Idade > 50,]
TGI_50 <- as.data.frame(table(TGI_50$CODMUNRES))
names(TGI_50) <- c("CODMUNRES", "TGI_50")

IdadeFertil <- list(TGI_15_19, TGI_20_24, TGI_25_29, TGI_30_34, TGI_35_39, TGI_40_44, TGI_45_49)

temp <- Reduce(function(x,y) merge(x,y, all = TRUE), IdadeFertil)
temp[is.na(temp)] <- 0
colsValidas <- sapply(temp, is.numeric)
temp$TGIF <- rowSums(temp[, colsValidas])

TGIF <- temp[, c("CODMUNRES", "TGIF")]

# Idade materna e código de munícipio de residência são variáveis sem quaisquer NAs, o que nos permite omitir o na.rm = TRUE no argumento de aggregate
# Podemos verificar isso com:
# anyNA(dados_sinasc_2$IDADEMAE)
# anyNA(dados_sinasc_2$CODMUNRES)

MedidasDescritivasIM <- function(nomeVar, funcao, percentil = NULL){
  # Tive que chamar as funções como funções genéricas, pois eu estava sendo impedindo de renomear as colunas do data frame
  if(is.null(percentil)){
    resultado <- aggregate(IDADEMAE ~ CODMUNRES, data = dados_sinasc_2, FUN = function(x) funcao(x, na.rm = TRUE))
  }
  else{
    resultado <- aggregate(IDADEMAE ~ CODMUNRES, data = dados_sinasc_2, FUN = function(x) funcao(x, probs = percentil, na.rm = TRUE))
  }
  names(resultado) <- c("CODMUNRES", nomeVar)
  resultado[[nomeVar]] <- round(resultado[[nomeVar]], digits=2) # Arredondando os resultados para 2 casas decimais já dentro da função
  return(resultado)
}

IM_P25 <- MedidasDescritivasIM("IM_P25", quantile, 0.25)
IM_P50 <- MedidasDescritivasIM("IM_P50", quantile, 0.5)
IM_P75 <- MedidasDescritivasIM("IM_P75", quantile, 0.75)

IM_MD <- MedidasDescritivasIM("IM_MD", mean)
IM_MD$IM_MD <- round(IM_MD$IM_MD, digits=2)

IM_DP <- MedidasDescritivasIM("IM_DP", sd)

# Verificamos os indíces de cada escolaridade com:

VerIndices <- function(variavel){
  v <- levels(variavel)
  for(i in 1:length(v)){
    cat(i, " - ", v[i], "\n")
  }
}

Escolaridade <- dados_sinasc_2$ESCMAE2010

VerIndices(Escolaridade)

SelecionarPorEscolaridade <- function(indiceEsc, nomeVar){
  temp <- dados_sinasc_2[as.integer(Escolaridade) == indiceEsc,]
  resultado <- as.data.frame(table(temp$CODMUNRES))
  names(resultado) <- c("CODMUNRES", nomeVar)
  return(resultado)
}

EM_S <- SelecionarPorEscolaridade(1, "EM_S")
EM_FI <- SelecionarPorEscolaridade(2, "EM_FI")
EM_FII <- SelecionarPorEscolaridade(3, "EM_FII")
EM_M <- SelecionarPorEscolaridade(4, "EM_M")
EM_SI <- SelecionarPorEscolaridade(5, "EM_SI")
EM_SC <- SelecionarPorEscolaridade(6, "EM_SC")

# Verificamos os indíces de cada cor com:
CorMae <- dados_sinasc_2$RACACORMAE
VerIndices(CorMae)

SelecionarPorCor <- function(indiceCorMae, nomeVar){
  temp <- dados_sinasc_2[as.integer(CorMae) == indiceCorMae,]
  resultado <- as.data.frame(table(temp$CODMUNRES))
  names(resultado) <- c("CODMUNRES", nomeVar)
  return(resultado)
}

TGRC_B <- SelecionarPorCor(1, "TGRC_B")
TGRC_PT <- SelecionarPorCor(2, "TGRC_PT")
TGRC_A <- SelecionarPorCor(3, "TGRC_A")
TGRC_PD <- SelecionarPorCor(4, "TGRC_PD")
TGRC_I <- SelecionarPorCor(5, "TGRC_I")

# Decidi criar uma versão mais genérica das funções de selecionar, pode ser útil

SelecionarGenerico <- function(valor, variavel, nomeVar){
  temp <- dados_sinasc_2[as.integer(variavel) == valor,]
  resultado <- as.data.frame(table(temp$CODMUNRES))
  names(resultado) <- c("CODMUNRES", nomeVar)
  return(resultado)
}

EstCivil <- dados_sinasc_2$ESTCIV

VerIndices(EstCivil)

TGSC <- SelecionarGenerico(1, EstCivil, "TGSC")
TGCC <- SelecionarGenerico(1, EstCivil, "TGCC")

Paridade <- dados_sinasc_2$PARIDADE
VerIndices(Paridade)

TGPRI <- SelecionarGenerico(2, Paridade, "TGPRI")
TGNPRI <- SelecionarGenerico(1, Paridade, "TGNPRI")

# Variáveis sobre gestação

Gravidez <- dados_sinasc_2$GRAVIDEZ
VerIndices(Gravidez)

TGU <- SelecionarGenerico(1, Gravidez, "TGU")

TGG <- merge(SelecionarGenerico(2, Gravidez, "temp1"), SelecionarGenerico(3, Gravidez, "temp2"), all = TRUE)
TGG[is.na(TGG)] <- 0
TGG$TGG <- TGG$temp1 + TGG$temp2
TGG <- TGG[, c("CODMUNRES", "TGG")]

SelecionarPorFaixa <- function(lim_inf, lim_sup, variavel, nomeVar){
  temp <- dados_sinasc_2[variavel >= lim_inf & variavel <= lim_sup,]
  resultado <- as.data.frame(table(temp$CODMUNRES))
  names(resultado) <- c("CODMUNRES", nomeVar)
  return(resultado)
}

TempoGest <- dados_sinasc_2$SEMAGESTAC

TGD_22 <- dados_sinasc_2[TempoGest < 22,]
TGD_22 <- as.data.frame(table(TGD_22$CODMUNRES))
names(TGD_22) <- c("CODMUNRES", "TGD_22")

TGD_22_27 <- SelecionarPorFaixa(22, 27, TempoGest, "TGD_22_27")
TGD_28_31 <- SelecionarPorFaixa(28, 31, TempoGest, "TGD_28_31")
TGD_32_36 <- SelecionarPorFaixa(32, 36, TempoGest, "TGD_32_36")
TGD_37_41 <- SelecionarPorFaixa(37, 41, TempoGest, "TGD_37_41")

TGD_42 <- dados_sinasc_2[TempoGest >= 42,]
TGD_42 <- as.data.frame(table(TGD_42$CODMUNRES))
names(TGD_42) <- c("CODMUNRES", "TGD_42")

TGD_PRT <- dados_sinasc_2[TempoGest < 37,]
TGD_PRT <- as.data.frame(table(TGD_PRT$CODMUNRES))
names(TGD_PRT) <- c("CODMUNRES", "TGD_PRT")

TGD_AT <- SelecionarPorFaixa(37, 41, TempoGest, "TGD_AT")

TGD_PST <- TGD_42
names(TGD_PST) <- c("CODMUNRES", "TGD_PST")

MedidasDescritivasDG <- function(nomeVar, funcao, percentil = NULL){
  if(!is.null(percentil)){
    resultado <- aggregate(SEMAGESTAC ~ CODMUNRES, data = dados_sinasc_2, FUN = function(x) funcao(x, probs=percentil, na.rm=TRUE))
  }
  else{
    resultado <- aggregate(SEMAGESTAC ~ CODMUNRES, data = dados_sinasc_2, FUN = function(x) funcao(x, na.rm=TRUE))
  }
  names(resultado) <- c("CODMUNRES", nomeVar)
  resultado[[nomeVar]] <- round(resultado[[nomeVar]], digits=2)
  return(resultado)
}

DG_P25 <- MedidasDescritivasDG("DG_P25", quantile, 0.25)
DG_P50 <- MedidasDescritivasDG("DG_P50", quantile, 0.5)
DG_P75 <- MedidasDescritivasDG("DG_P75", quantile, 0.75)
DG_MD <- MedidasDescritivasDG("DG_MD", mean)
DG_DP <- MedidasDescritivasDG("DG_DP", sd)

Kotelchuck <- dados_sinasc_2$KOTELCHUCK
VerIndices(Kotelchuck)

TKC_NR <- SelecionarGenerico(1, Kotelchuck, "TKC_NR")
TKC_ID <- SelecionarGenerico(2, Kotelchuck, "TKC_ID")
TKC_IT <- SelecionarGenerico(3, Kotelchuck, "TKC_IT")
TKC_AD <- SelecionarGenerico(4, Kotelchuck, "TKC_AD")
TKC_MAD <- SelecionarGenerico(5, Kotelchuck, "TKC_MAD")

# Variáveis sobre o parto

Pereg <- dados_sinasc_2$PEREG
VerIndices(Pereg)

TGPRG_S <- SelecionarGenerico(2, Pereg, "TGPRG_S")
TGPRG_N <- SelecionarGenerico(1, Pereg, "TGPRG_N")

Parto <- dados_sinasc_2$PARTO
VerIndices(Parto)

TPC <- SelecionarGenerico(2, Parto, "TPC")
TPV <- SelecionarGenerico(1, Parto, "TPV")

Posicao <- dados_sinasc_2$TPAPRESENT
VerIndices(Posicao)

TRAP_C <- SelecionarGenerico(1, Posicao, "TRAP_C")
TRAP_P <- SelecionarGenerico(2, Posicao, "TRAP_P")
TRAP_T <- SelecionarGenerico(3, Posicao, "TRAP_T")

Robson <- dados_sinasc_2$TPROBSON

TGROB_1 <- SelecionarGenerico(1, Robson, "TGROB_1")
TGROB_2 <- SelecionarGenerico(2, Robson, "TGROB_2")
TGROB_3 <- SelecionarGenerico(3, Robson, "TGROB_3")
TGROB_4 <- SelecionarGenerico(4, Robson, "TGROB_4")
TGROB_5 <- SelecionarGenerico(5, Robson, "TGROB_5")
TGROB_6 <- SelecionarGenerico(6, Robson, "TGROB_6")
TGROB_7 <- SelecionarGenerico(7, Robson, "TGROB_7")
TGROB_8 <- SelecionarGenerico(8, Robson, "TGROB_8")
TGROB_9 <- SelecionarGenerico(9, Robson, "TGROB_9")
TGROB_10 <- SelecionarGenerico(10, Robson, "TGROB_10")

Local <- dados_sinasc_2$LOCNASC
VerIndices(Local)

TNLOC_H <- SelecionarGenerico(1, Local, "TNLOC_H")
TNLOC_ES <- SelecionarGenerico(2, Local, "TNLOC_ES")
TNLOC_D <- SelecionarGenerico(3, Local, "TNLOC_D")
TNLOC_O <- SelecionarGenerico(4, Local, "TNLOC_O")
# TNLOC_AI <- SelecionarGenerico(5, Local, "TNLOC_AI") Deu erro, vamos verificar...

aldeiaindigena <- dados_sinasc_2[dados_sinasc_2$LOCNASC == 5,]
as.data.frame(table(aldeiaindigena$CODMUNRES)) # Não existe nenhum registro com LOCNASC == 5

# Então podemos fazer:
TNLOC_AI <- as.data.frame(table(dados_sinasc_2$CODMUNRES))
TNLOC_AI$Freq <- 0
names(TNLOC_AI) <- c("CODMUNRES", "TNLOC_AI")

# Variáveis sobre os recém-nascidos

Sexo <- dados_sinasc_2$SEXO
VerIndices(Sexo)

TRS_M <- SelecionarGenerico(1, Sexo, "TRS_M")
TRS_F <- SelecionarGenerico(2, Sexo, "TRS_F")

RacaCor <- dados_sinasc_2$RACACOR
VerIndices(RacaCor)

TRRC_B <- SelecionarGenerico(1, RacaCor, "TRRC_B")
TRRC_PT <- SelecionarGenerico(2, RacaCor, "TRRC_PT")
TRRC_A <- SelecionarGenerico(3, RacaCor, "TRRC_A")
TRRC_PD <- SelecionarGenerico(4, RacaCor, "TRRC_PD")
TRRC_I <- SelecionarGenerico(5, RacaCor, "TRRC_I")

TRP_BP <- dados_sinasc_2[dados_sinasc_2$PESO < 2500,]
TRP_BP <- as.data.frame(table(TRP_BP$CODMUNRES))
names(TRP_BP) <- c("CODMUNRES", "TRP_BP")

TRP_M <- dados_sinasc_2[dados_sinasc_2$PESO >= 4000,]
TRP_M <- as.data.frame(table(TRP_M$CODMUNRES))
names(TRP_M) <- c("CODMUNRES", "TRP_M")

TRP_N <- dados_sinasc_2[dados_sinasc_2$PESO >= 2500 & dados_sinasc_2$PESO < 4000,]
TRP_N <- as.data.frame(table(TRP_N$CODMUNRES))
names(TRP_N) <- c("CODMUNRES", "TRP_N")

# Decidi generalizar também as funções de medida descritiva

MedidasDescritivasGenerica <- function(nomeVar, variavel, funcao, percentil = NULL){
  x <- as.formula(paste(variavel, "CODMUNRES", sep=" ~ "))
  if(!is.null(percentil)){
    resultado <- aggregate(x, data = dados_sinasc_2, FUN = function(x) funcao(x, probs=percentil, na.rm=TRUE))
  }
  else{
    resultado <- aggregate(x, data = dados_sinasc_2, FUN = function(x) funcao(x, na.rm=TRUE))
  }
  names(resultado) <- c("CODMUNRES", nomeVar)
  resultado[[nomeVar]] <- round(resultado[[nomeVar]], digits=2)
  return(resultado)
}

PESO_P25 <- MedidasDescritivasGenerica("PESO_P25", "PESO", quantile, 0.25)
PESO_P50 <- MedidasDescritivasGenerica("PESO_P50", "PESO", quantile, 0.5)
PESO_P75 <- MedidasDescritivasGenerica("PESO_P75", "PESO", quantile, 0.75)

PESO_MD <- MedidasDescritivasGenerica("PESO_MD", "PESO", mean)
PESO_DP <- MedidasDescritivasGenerica("PESO_DP", "PESO", sd)

TRPIG_P <- dados_sinasc_2[dados_sinasc_2$F_PIG == "PIG",]
TRPIG_P <- as.data.frame(table(TRPIG_P$CODMUNRES))
names(TRPIG_P) <- c("CODMUNRES", "TRPIG_P")

TRPIG_A <- dados_sinasc_2[dados_sinasc_2$F_PIG == "AIG",]
TRPIG_A <- as.data.frame(table(TRPIG_A$CODMUNRES))
names(TRPIG_A) <- c("CODMUNRES", "TRPIG_A")

TRPIG_G <- dados_sinasc_2[dados_sinasc_2$F_PIG == "GIG",]
TRPIG_G <- as.data.frame(table(TRPIG_G$CODMUNRES))
names(TRPIG_G) <- c("CODMUNRES", "TRPIG_G")

TRAPG5_B <- dados_sinasc_2[dados_sinasc_2$APGAR5 < 7,]
TRAPG5_B <- as.data.frame(table(TRAPG5_B$CODMUNRES))
names(TRAPG5_B) <- c("CODMUNRES", "TRAPG5_B")

TRAPG5_N <- dados_sinasc_2[dados_sinasc_2$APGAR5 >= 7,]
TRAPG5_N <- as.data.frame(table(TRAPG5_N$CODMUNRES))
names(TRAPG5_N) <- c("CODMUNRES", "TRAPG5_N")

APG5_MD <- MedidasDescritivasGenerica("APG5_MD", "APGAR5", mean)
APG5_DP <- MedidasDescritivasGenerica("APG5_DP", "APGAR5", sd)

Anomalia <- dados_sinasc_2$IDANOMAL
VerIndices(Anomalia)

TRAC <- SelecionarGenerico(1, Anomalia, "TRAC")
TRSAC <- SelecionarGenerico(2, Anomalia, "TRSAC")

variaveis_sinasc <- list(TN, TNRC, TNRCR, TGI_15, TGI_15_19, TGI_20_24, TGI_25_29, TGI_30_34, TGI_35_39, TGI_40_44, TGI_45_49, TGI_50, TGIF, IM_P25, IM_P50, IM_P75, IM_MD, IM_DP, EM_S, EM_FI, EM_FII, EM_M, EM_SI, EM_SC, TGRC_B, TGRC_PT, TGRC_A, TGRC_PD, TGRC_I, TGSC, TGCC, TGPRI, TGNPRI, TGU, TGG, TGD_22, TGD_22_27, TGD_28_31, TGD_32_36, TGD_37_41, TGD_42, TGD_PRT, TGD_AT, TGD_PST, DG_P25, DG_P50, DG_P75, DG_MD, DG_DP, TKC_NR, TKC_ID, TKC_IT, TKC_AD, TKC_MAD, TGPRG_S, TGPRG_N, TPV, TPC, TRAP_C, TRAP_P, TRAP_T, TGROB_1, TGROB_2, TGROB_3, TGROB_4, TGROB_5, TGROB_6, TGROB_7, TGROB_8, TGROB_9, TGROB_10, TNLOC_H, TNLOC_ES, TNLOC_D, TNLOC_O, TNLOC_AI, TRS_M, TRS_F, TRRC_B, TRRC_PT, TRRC_A, TRRC_PD, TRRC_I, TRP_BP, TRP_N, TRP_M, PESO_P25, PESO_P50, PESO_P75, PESO_MD, PESO_DP, TRPIG_P, TRPIG_A, TRPIG_G, TRAPG5_B, TRAPG5_N, APG5_MD, APG5_DP, TRAC, TRSAC)

SINASC_MG <- Reduce(function(x,y) merge(x,y, all=TRUE, by = "CODMUNRES"), variaveis_sinasc)
SINASC_MG[is.na(SINASC_MG)] <- 0

UF <- SINASC_MG[1,]
colsValidas <- sapply(SINASC_MG, is.numeric)
UF[colsValidas] <- colSums(SINASC_MG[, colsValidas])
UF$CODMUNRES <- "31"

SINASC_MG <- rbind(UF, SINASC_MG)

ANO <- 2016
NIVEL <- "MUNICIPIO"

SINASC_MG <- cbind(ANO, NIVEL, SINASC_MG)
SINASC_MG$NIVEL[SINASC_MG$CODMUNRES == "31"] <- "UF"

# Ao terminar a Tarefa 9 commit com a mensagem "script BDEM - SINASC - tarefas 1 a 9" e envie para o repositório Projeto_BDEM_2016


# Tarefa 10. Exportar o banco de dados com o nome SINASC_UF.csv (Exemplo: SINASC_RJ.csv)
# Ao terminar a Tarefa 10 commit com o comentário "dados SINASC_UF 2016 e script - SIM - tarefas 1 a 10"  e envie para o repositório Projeto_BDEM_2016



####################################
# ETAPA 3: BANCOS DE DADOS DO SIDRA
####################################
# Você deve criar e estar na branch SIDRA antes de inserir os comandos 
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1: Ler os bancos de dados abaixo listados com os respectivos nomes
# dados_sidra_1 para população residente estimada - UF e municípios - 2016 - SIDRA - tabela_6579.csv
# dados_sidra_2 para população residente censo 2010 - UF e municípios - total e por sexo - SIDRA - tabela_1552.csv
# dados_sidra_3 para população residente censo 2010 - por faixa etária - UF - SIDRA - tabela_1552.csv
# dados_sidra_4 para população residente censo 2010 - por faixa etária e sexo - municípios - SIDRA - tabela_1552.csv
# Atenção que agora os arquivos têm nomes e códigos (com 7 dígitos) dos municípios (e alguns UF)

# Verificar se a leitura de todos os bancos foi feita corretamente e a estrutura dos dados


# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - SIDRA - tarefa 1" e envie para o repositório Projeto_BDEM_2016


# Tarefa 2. Criar uma nova variável de nome CODUF com os códigos da UF nos bancos dados_sidra_1, dados_sidra_2, dados_sidra_4


# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - SIDRA - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3. Selecionar em dados_sidra_ 1 a dados_sidra_4 a UF de responsabilidade do aluno 
# e chamar os bancos de dados, respectivamente por sidra_1, sidra_2, sidra_3 e sidra_4


# Ao terminar a Tarefa 3 commit com a mensagem "script BDEM - SIDRA - tarefas 1 a 3" e envie para o repositório Projeto_BDEM_2016


# Tarefa 4: Criar um banco de dados, de nome SIDRA_UF.csv (Exemplo: SIDRA_RJ.csv), contendo as variáveis listadas no arquivo “Variáveis - Projeto - Tarefa 4 - SIDRA.pdf”

# Ao terminar a Tarefa 4 commit com a mensagem "script BDEM - SIDRA - tarefas 1 a 4" e envie para o repositório Projeto_BDEM_2016


# Tarefa 5:Exportar o banco de dados com o nome SIDRA_UF.csv (Exemplo: SIDRA_RJ.csv)
# Ao terminar a Tarefa 5 commit com o comentário "dados SIDRA_UF 2016 e script - SIDRA - tarefas 1 a 5"  e envie para o repositório Projeto_BDEM_2016


####################################
# ETAPA 4: BANCOS DE DADOS DO ATLAS
####################################
# Você deve criar e estar na branch ATLAS antes de inserir os comandos 
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1: Ler os bancos de dados abaixo listados com os respectivos nomes
# codigos_IBGE_2010 para códigos dos municípios - 2010.csv
# dados_atlas_1 para IDHM - 2010 (CENSO) e 2016 (PNAD) - total e por sexo - UF - Atlas Brasil.csv
# dados_atlas_2 para IDHM - 2010 - municípios - Atlas Brasil.csv
# Atenção que agora alguns arquivos só têm os nomes dos municípios e das UFs, mas não têm os códigos

# Verificar se a leitura de todos os bancos foi feita corretamente e a estrutura dos dados

# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - ATLAS - tarefa 1" e envie para o repositório Projeto_BDEM_2016


# Tarefa 2: Manipular o banco de dados e criar o banco de dados ATLAS_UF

# Criar o banco UF_codigo tipo tabela de correspondência
UF_codigo = data.frame(
  UF = c("Rondônia","Acre","Amazonas","Roraima","Pará","Amapá","Tocantins",
         "Maranhão","Piauí","Ceará","Rio Grande do Norte","Paraíba",
         "Pernambuco","Alagoas","Sergipe","Bahia","Minas Gerais",
         "Espírito Santo","Rio de Janeiro","São Paulo","Paraná",
         "Santa Catarina","Rio Grande do Sul","Mato Grosso do Sul",
         "Mato Grosso","Goiás","Distrito Federal"),
  
  SIGLA = c("RO","AC","AM","RR","PA","AP","TO",
            "MA","PI","CE","RN","PB","PE","AL",
            "SE","BA","MG","ES","RJ","SP",
            "PR","SC","RS","MS","MT","GO","DF"),
  
  CODUF = c(11,12,13,14,15,16,17,
            21,22,23,24,25,26,27,
            28,29,31,32,33,35,
            41,42,43,50,51,52,53)
)

# Retirar de dados_atlas_1 a linha do Brasil e adicionar (com merge by UF) as colunas de UF_codigo

# Criar o banco linha_estado somente com as linhas da UF e com as seguintes colunas:
# ANO=2016, NIVEL=UF, CODMUNRES, IDHM_A, IDHM_CA, IDHM_CA_M e IDHM_CA_F 

# Selecionar de linha_estado a UF da responsabilidade do aluno por CODMUNRES

# Criar em dados_atlas_2 a coluna com UF

# Retirar (UF) da variável município

# Acrescentar em codigos_IBGE_2010 a variável CODUF baseado nos dois primeiros dígitos de CODMUNRES

# Acrescentar a codigos_IBGE_2010 as variáveis de UF_codigo (merge by CODUF)

# Associar dados_atlas_2 a codigos_IBGE_2010 e nomear o novo arquivo por atlas_municipio
# Neste caso o merge será by.x = c("município","UF") e by.y = c("município","SIGLA")

# Remover de atlas_municipio a coluna UF.y criada no merge

# Selecionar somente a UF de responsabilidade do aluno através dos dois primeiros dógitos de CODMUNRES

# Criar banco ATLAS_MUNICIPIO com as linhas dos municípios e com as seguintes variáveis:
# ANO=2016, NIVEL=MUNICIPIO, CODMUNRES, IDHM_A=NA, IDHM_CA, IDHM_CA_M=NA, IDHM_CA_F=NA

# Criar banco final ATLAS_UF "juntando" os bancos linha_estado e ATLAS_MUNICIPIO


# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - ATLAS - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3. Exportar o banco de dados com o nome ATLAS_UF.csv (Exemplo: ATLAS_RJ.csv)
# Ao terminar a Tarefa 3 commit com o comentário "dados ATLAS_UF 2016 e script - ATLAS - tarefas 1 a 3"  e envie para o repositório Projeto_BDEM_2016



####################################
# ETAPA 5: BANCOS DE DADOS DO SINISA
####################################
# Você deve criar e estar na branch SINISA antes de inserir os comandos 
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1: Ler o bancos de dados abaixo listado com os respectivo nome
# dados_sinisa para agua e esgoto - município - 2016.csv
# Atenção que o arquivo tem códigos e nomes de municípios e muitos NAs. 
# Repare que os valores estão com o milhar indicado por ponto, o que não deve acontecer para o R não entender como decimal

# Verificar se a leitura de todos os bancos foi feita corretamente e a estrutura dos dados
# Remover a pontuação de milhar e converter para formato numérico

# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - SINISA - tarefa 1" e envie para o repositório Projeto_BDEM_2016


# Tarefa 2. Reduzir dados_sinisa apenas para o estado que o aluno irá trabalhar (utilizar os dois primeiros dígitos de CODMUNRES), nomeando este novo banco de dados como dados_sinisa_1

# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - SINISA - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3. Criar um banco de dados, de nome SINISA_UF.csv (Exemplo: SINISA_RJ.csv), contendo as variáveis listadas no arquivo “Variáveis - Projeto - Tarefa 3 - SINISA.pdf”

# Ao terminar a Tarefa 3 commit com a mensagem "script BDEM - SINISA - tarefas 1 a 3" e envie para o repositório Projeto_BDEM_2016


# Tarefa 4. Exportar o banco de dados com o nome SINISA_UF.csv (Exemplo: SINISA_RJ.csv)
# Ao terminar a Tarefa 4 commit com o comentário "dados SINISA_UF 2016 e script - SINISA - tarefas 1 a 4"  e enviar para o repositório Projeto_BDEM_2016



################################
# ETAPA 6: CRIAÇÃO DE BDEM_UF
################################
# Você deve estar agora em main e antes de inserir qualquer comando desta ETAPA
# deverá fazer os merges de cada uma das 5 branches. A cada merge pode fazer o comentário "merge da branch TAL"
# NÃO altere as linhas de qualquer outra ETAPA do script e nem do cabeçalho

# Tarefa 1: Agregar os arquivos SIDRA_UF, ATLAS_UF, SINASC_UF, SIM_UF, SINISA_UF no banco BDEM_UF (Exemplo: BDEM_RJ)
# Leitura dos 5 bancos de dados expeortados das etapas anteriores

# Agregação dos bancos
# Lembre-se que SIDRA e ATLAS tem CODMUNRES com 7 dígitos e SINASC, SIM e SINISA com 6 dígitos
# Além disso dentro do merge all = TRUE garante a manutenção de qualquer município presente em um dos bancos envolvidos no merge


# Ao terminar a Tarefa 1 commit com a mensagem "script BDEM - BDEM - tarefa 1" e envie para o repositório Projeto_BDEM_2016


# Tarefa 2: Inserir os seguintes indicadores epidemiológicos (com apenas dias casas decimais) no BDEM_UF:
# TFG: Taxa de fecundidade geral
# TMG: Taxa de mortalidade geral
# RMM: Razão de mortalidade materna
# TMM: Taxa de mortalidade materna
# TMM_P: Taxa de mortalidade materna em até 42 dias
# TMN: Taxa de mortalidade neonatal
# TMN_P: Taxa de mortalidade neonatal precoce
# TMN_T: Taxa de mortalidade neonatal tardia
# TMI: Taxa de mortalidade infantil

# Conferir o banco BDEM_UF após inserção dos indicadores

# Ao terminar a Tarefa 2 commit com a mensagem "script BDEM - BDEM - tarefas 1 a 2" e envie para o repositório Projeto_BDEM_2016


# Tarefa 3: Exportar o banco de dados com o nome BDEM_UF.csv (Exemplo: BDEM_RJ.csv)
# Ao terminar a Tarefa 3 commit com o comentário "dados BDEM_UF 2016 e script - BDEM - tarefas 1 a 3"  e enviar para o repositório Projeto_BDEM_2016
 