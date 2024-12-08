#!/bin/bash

# Проверяем наличие аргумента с именем файла
if [ $# -ne 1 ]; then
    echo "Использование: $0 <имя файла>"
    exit 1
fi

FILENAME=$1

# Функция для добавления новой записи
add_expense() {
    echo -n "Введите дату (YYYY-MM-DD): "
    read date

    echo -n "Введите категорию: "
    read category

    echo -n "Введите сумму: "
    read amount

    echo -n "Введите описание: "
    read description

    # Добавление записи в файл
    echo "$date,$category,$amount,$description" >> "$FILENAME"
    echo "Запись добавлена!"
}

# Функция для просмотра всех записей
view_expenses() {
    if [ ! -f "$FILENAME" ]; then
        echo "Файл не найден. Сначала добавьте запись."
        return
    fi

    echo "Список расходов:"
    echo "Дата        | Категория         | Сумма   | Описание"
    echo "--------------------------------------------------"
    while IFS=',' read -r date category amount description; do
        printf "%-10s | %-17s | %-7s | %s\n" "$date" "$category" "$amount" "$description"
    done < "$FILENAME"
}

# Главное меню
while true; do
    echo "Меню:"
    echo "1. Добавить новую запись"
    echo "2. Просмотреть записи"
    echo "0. Выход"
    echo -n "Выберите действие: "

    read choice
    case $choice in
        1)
            add_expense
            ;;
        2)
            view_expenses
            ;;
        0)
            echo "Выход из программы."
            exit 0
            ;;
        *)
            echo "Неверный выбор. Попробуйте снова."
            ;;
    esac
done
