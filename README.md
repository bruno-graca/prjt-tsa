# prjt-tsa
_Projeto final da cadeira Tecnologias de Scripting e Automação_\
\
**Aluno**: Bruno Graça - 230000972\
Instituto Politécnico de Santarém - Escola Superior de Gestão e Tecnologia de Santarém\
**Curso**: Redes e Sistemas Informáticos


## **Tema**
Calendário personalizado em bash


## Objetivos
1. Possibilidade de criar eventos pessoais ao utilizador
2. Descrição para cada evento
3. Lembretes antes do evento
4. Possibilidade de escolher quanto tempo antes do evento o utilizador recebe o lembrete
5. Enviar lembrete por e-mail 
6. (Opcional) Criar uma GUI interativa básica para facilitar a utilização do calendário


## Atualizações
_20/12/2024_

Pesquisa sobre como realizar o projeto, utilização de ficheiros .txt para guardar os dados dos eventos e criação de funções para criar ficheiros .txt com a informação.\
Pesquisa sobre como enviar lembretes por mail: comando mail, MAILTO ou um curl após configurar o sistema de SMTP ou utilizando o protocolo SMTP do gmail.\
Exemplo de mail enviado por curl pelo SMTP do gmail:\
curl --url 'smtps://smtp.gmail.com:465' --ssl-reqd \
  --mail-from 'from-email@gmail.com' \
  --mail-rcpt 'to-email@gmail.com' \
  --user 'from-email@gmail.com:YourPassword' 

_04/01/2025_ 

Projeto quase concluído em ambiente VM, com 4 funções principais:\
  **Listar eventos** - Lista os eventos\
  **Adicionar eventos** - Adiciona um evento à lista de eventos\
  **Remover evento** - Remove o evento\
  **Main loop** - cria a interface para interagir com a agenda\

Objetivo atual: Criar uma 5ª função que utiliza o crontab para enviar lembretes, visto que é um dos objetivos inicialmente propostos.
