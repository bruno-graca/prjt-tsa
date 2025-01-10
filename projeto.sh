#!/bin/bash

EVENT_FILE="$HOME/.agenda_events"
EMAIL="exemplo@gmail.com" # Definir o e-mail para envio de lembretes

# Função para inicializar o arquivo de eventos
init_event_file() {
    if [[ ! -f "$EVENT_FILE" ]]; then
        printf "Arquivo de eventos está a ser criado...\n"
        touch "$EVENT_FILE"
    fi
}

# Função para listar os eventos
listar_eventos() {
    if [[ ! -s "$EVENT_FILE" ]]; then
        printf "Nenhum evento encontrado.\n"
        return 0
    fi
    printf "Eventos:\n"
    cat "$EVENT_FILE" | nl -w2 -s". " #Linha para enumerar eventos
}

# Função para adicionar eventos
add_evento() {
    local data_hora descricao lembrete email
    printf "Digite a data e hora do evento (formato: YYYY-MM-DD HH:MM): "
    read -r data_hora
    printf "Descrição do evento: "
    read -r descricao
    printf "Quantos minutos antes quer ser relembrado pelo lembrete? (0 para desativar): "
    read -r lembrete

    #Se não houver lembrete, não há necessidade de enviar mail
    if [[ "$lembrete" -gt 0 ]]; then
        email="$EMAIL"
    else
        email=""
    fi

    printf "%s|%s|%s|%s\n" "$data_hora" "$descricao" "$lembrete" "$email" >> "$EVENT_FILE"
    printf "Evento adicionado com sucesso.\n"

    if [[ "$lembrete" -gt 0 ]]; then
        schedule_lembrete "$data_hora" "$descricao" "$lembrete" "$email"
    fi
}

# Função para remover eventos
rmv_evento() {
    listar_eventos
    printf "Digite o número do evento a remover: "
    read -r evento_num
    #Se o evento existir, remove
    if sed -i "${evento_num}d" "$EVENT_FILE"; then
        printf "Evento removido com sucesso.\n"
    else
        printf "Falha ao remover o evento.\n" >&2
    fi
}

# Função para agendar lembretes usando o crontab
schedule_lembrete() {
    local data_hora descricao lembrete email
    data_hora="$1"
    descricao="$2"
    lembrete="$3"
    email="$4"

    local evento_timestamp lembrete_timestamp
    evento_timestamp=$(date -d "$data_hora" +%s)
    lembrete_timestamp=$((evento_timestamp - lembrete * 60))
    local lembrete_time
    lembrete_time=$(date -d "@$lembrete_timestamp" '+%M %H %d %m *')

    (
        crontab -l 2>/dev/null #Se o utilizador não tiver um arquivo de crontab configurado, esta linha "esconde" as mensagens de erro desnecessárias.
        printf "%s echo 'Lembrete: %s' | mail -s 'Lembrete de evento' %s\n" \
            "$lembrete_time" "$descricao" "$email"
    ) | crontab -
    printf "Lembrete agendado com sucesso.\n"
}

# Função principal
main() {
    init_event_file

    while true; do
        printf "\nAgenda - Escolha uma opção:\n"
        printf "1. Listar eventos\n"
        printf "2. Adicionar evento\n"
        printf "3. Remover evento\n"
        printf "4. Sair\n"
        printf "Escolha: "
        read -r opcao

        case "$opcao" in
            1) listar_eventos ;;
            2) add_evento ;;
            3) rmv_evento ;;
            4) printf "A sair...\n"; break ;;
            *) printf "Opção inválida.\n" ;;
        esac
    done
}

main
