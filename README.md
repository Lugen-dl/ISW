
# Название Проекта

 Infrastructure Security Watchdog

## **Вступление** 
Автоматизированная платформа для развертывания облачной инфраструктуры . За основу был взят open-source инструмент kottster [@kottster](https://github.com/kottster).

Что было добавленно поверх инструмента:

- Приватный докер регистр
- Интеграция с cloudflare
- Полная автоматизированная развертка через Github Actions
- Модульность в terraform для  масштабируемости
- VPC и firewall защита

## Технический стек инструментов

- **Инфраструктура**: Terraform 
- **Контейризация**: Docker compose 
- **Сеть**: Cloudflared 
- **CI/CD**: Github Actions 
- **Облачные сервисы**: DigitalOcean, AWS S3 

## Установка  и деплой


1.  Создание локального репозитория (если он у вас есть перейдите к шагу два)

```bash
git init workdir/

git remote add origin https://github.com/логин/название_репо.git
git branch -M main
git push -u origin main
```

2. Загрузка удаленого проекта в локальную дирректорию

```bash
user@distro:  curl https://github.com/Lugen-dl/ISW.git
```

3.  Развертывание

    GUI
```bash
Actions -> .github/workflow/ci.yml -> Run workflow
```
TUI
```bash
git push origin master
```
## Переменный окружения и Секреты

- ./ISW/.env.example - Секреты окружения контейнеров [@env_example_github](https://github.com/Lugen-dl/ISW/blob/master/.env.example)
- ./ISW/terraform.tfvars.example - Секреты окружения инфраструктуры [@tfvars_example_github](https://github.com/Lugen-dl/ISW/blob/master/terraform.tfvars.example)

## Security

- Изоляция сервера через приватную сеть
- Отдельно расписанные правила для фаервола
- Шифрование через ssl сертификат
- Распределение входящего и выходящего трафика через балансировщик