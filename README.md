# README

This repository is only test.

## Install

``` bash
  cp config/database.yml.example config/database.yml
  echo 'b2b058bf450654395cbd8236e48d15f4' > config/master.key
  rails db:create db:migrate db:seed
```

## Demo Server

Goto: [demo](https://lucifer.app)

### Admin User

``` yaml
  email: can@can.com
  password: 123123
```