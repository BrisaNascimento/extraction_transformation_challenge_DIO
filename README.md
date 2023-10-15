
# Desafio de Projeto: Processando e transformando dados com Power BI

Esse projeto é uma aplicação das etapas de processamento e transformação de dados utilizando Power BI. O desafio faz parte do módulo de Visualização e Análise de Dados com Power BI do Santander Bootcamp 2023 - Ciência de Dados com Python. O módulo, bem como seus desafios foram conduzidos pela Juliana Mascarenhas, expert da DIO.

A aplicação seguiu os passos conforme orientações do desafio, porém realizei algumas adaptações para que a extração dos dados da base fosse realizadas por meio do Azure SQL Database. No geral o desafio pede uma documentação descritiva a respeito dos passos que foram propostos. Na etapa de documentação eu descrevo em detalhes o que foi realizado. 




## 📁  Referência

 - [Repositório da Juliana Mascarenhas para obtenção das Bases de Dados](https://github.com/julianazanelatto/power_bi_analyst/tree/main/M%C3%B3dulo%203/Coleta%20e%20extra%C3%A7%C3%A3o%20de%20dados)
 


## 🛠️ Documentação do projeto


[Descrição do desafio módulo 3 – Processamento de Dados Simplificado com Power BI]


#### Criação de uma instância na Azure para MySQL:
✔️ Foi utilizada uma instância existente do Azure SQL Database, portanto não foi necessária a criação de uma nova instância.

#### Criar o Banco de dados com base disponível no github:
✔️ As instruções de criação de tabelas e inserção dos dados foram adaptadas para T-SQL para serem utilizadas no SQL Database (SQL Server). 

#### Integração do Power BI com MySQL no Azure 
✔️ Integração do Power BI com SQL Database.

#### Verificar problemas na base a fim de realizar a transformação dos dados. 
✔️ Realizados ao longo da aplicação do projeto.

✔️ Na etapa de transformação de dados observa-se que existem colunas agregadas, provavelmente oriundas das definições de chave estrangeira utilizadas na etapa de criação das tabelas no SGBD escolhido.

#### Verifique os cabeçalhos e tipos de dados
✔️ Foram ajustadas nomenclaturas das colunas de forma a tornar o título mais explicativo.
Ex.: Na tabela Department a coluna “Dname” foi renomeada para “department_name”. 

✔️ Os tipos de dados de algumas colunas foram ajustados de forma a facilitar a operação de números com características numéricas sobretudo. Ex.: Na tabela Department a coluna “Mgr_ssn” agora renomeada para “manager_ssn” possuía o tipo numérico Numero inteiro, agora possui a categoria tipo texto, por se tratar de uma coluna de identificação e não uma coluna que demanda operações numéricas.

#### Modifique os valores monetários para o tipo double preciso
✔️ Modificado para numero decimal fixo.

#### Verifique a existência dos nulos e analise a remoção - 
✔️ Não foi necessário no nível de transformação aplicada à base de dados disponibilizada.

#### Os employees com nulos em Super_ssn podem ser os gerentes. Verifique se há algum colaborador sem gerente 
✔️ Observa-se que apenas um colaborador (James) não possui identificador de superior.  

#### Verifique se há algum departamento sem gerente. 
✔️ Todos os departamentos possuem identificador de gerente.

#### Se houver departamento sem gerente, suponha que você possui os dados e preencha as lacunas
✔️ Não foi necessário realizar essa transformação. 

#### Verifique o número de horas dos projetos
✔️  O número de horas dos projetos é apresentado na tabela works_on e foi categorizado como tipo numérico decimal.

#### Separar colunas complexas
✔️ A coluna Address necessitava ser separada em quatro colunas (number, street, city, state) antes, foi necessário utilizar o recurso substituir para renomear a rua com indicativo “Fire-Oak” para “Fire Oak”, tendo em vista ser um nome composto de rua.   Após essa modificação foi utilizado o recurso Dividir coluna por delimitador “-“ visto que os dados estavam separados por traços. As colunas de endereço foram reorganizadas para uma posição mais coerente para o utilizador.  

####  Mesclar consultas employee e departament para criar uma tabela employee com o nome dos departamentos associados aos colaboradores. A mescla terá como base a tabela employee. Fique atento, essa informação influencia no tipo de junção.
✔️ Uma nova tabela employee_dpt foi criada, para isso foi utilizado recurso Mesclar consultas como uma nova. A tabela employee foi utilizada como base, o numero do departamento como coluna em comum foi indicado nas duas tabelas e a opção de mescla foi junção à esquerda, preservando todas as colunas da primeira tabela, no caso employee. Na nova tabela, foi expandida apenas a visão do nome do departamento que foi reposicionada para vir logo após do número do departamento.  

####  Neste processo elimine as colunas desnecessárias. 
✔️ Foi utilizada apenas a coluna departamento na nova tabela Employee.

#### Realize a junção dos colaboradores e respectivos nomes dos gerentes . Isso pode ser feito com consulta SQL ou pela mescla de tabelas com Power BI. Caso utilize SQL, especifique no README a query utilizada no processo. 
✔️ Foi criada uma nova coluna na tabela Employee com o nome superior_name usando o recurso condicional column do power bi.

#### Mescle as colunas de Nome e Sobrenome para ter apenas uma coluna definindo os nomes dos colaboradores.
✔️ A coluna “Minit” foi removida por ser desnecessária tendo em vista que todos os dados de primeiro nome e último nome são únicos. Após selecionar as colunas Nome e Sobrenome,  na guia adicionar coluna, foi selecionado o separador “espaço” e o nome da coluna única com os dados unidos “employee_name”.  Após a criação da nova coluna de nome, as colunas  individuais com nome e sobrenome foram excluídas. 

#### Mescle os nomes de departamentos e localização. Isso fará que cada combinação departamento-local seja único. Isso irá auxiliar na criação do modelo estrela em um módulo futuro. 
✔️ foi realizada a mescla a partir do numero do departamento, e realizada a expansão apenas da coluna localização. Após essa etapa foi realizada a união das colunas nome do departamento e localização, usando o separador “espaço”.  

#### Explique por que, neste caso supracitado, podemos apenas utilizar o mesclar e não o atribuir.  
✔️ Ao atribuir uma coluna, a ação executada é acrescentar uma nova coluna com as informações mescladas das duas colunas, neste caso basta transformar as colunas originais em uma única coluna.
  
#### Agrupe os dados a fim de saber quantos colaboradores existem por gerente 
✔️ Utilizando o recurso group by, contudo uma melhor visão foi obtida criando uma nova tabela e isolando as colunas gerente e colaborador, e ordenando a exibição de gerente por ordem ascendente.

#### Elimine as colunas desnecessárias, que não serão usadas no relatório, de cada tabela.
✔️ Transformação realizada bem como foram renomeadas os nomes das tabelas, a exclusão das tabelas oriundas das FK definidas na criação das tabelas. Foram revisados os relacionamentos entre as tabelas e a remoção de duplicadas geradas após a execução de alguns procedimentos de transformação.






