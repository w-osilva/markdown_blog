# Instalação 

## Pré Requisitos

### Do Sistema

* Preferência de sistema operacional baseado em UNIX 
* Ambiente configurado com ruby na versão 2.3 ou superior
* Ambiente configurado com Node (para baixar dependências com NPM e Bower)
* Redis configurado (checar se o serviço rodando)

### Da Aplicação

* Database: Sqlite
* Job queue: Sidekiq
* Test frameworks: Rspec & Capybara (com selenium-web-driver)
* Gerenciador de dependências: Bundler

###### Gems adicionadas na aplicação (para tratar de necessidades específicas )
 
 ```
 # Authentication and authorization
 gem 'devise' 
 gem 'pundit'
   
 # Jobs
 gem 'redis', '~> 3.0'
 gem 'sidekiq'
   
 # Markdown convert 
 gem 'redcarpet', '~> 3.4.0'
   
 # Theme
 gem 'bower-rails', '~> 0.11.0'
 gem 'bootstrap3-rails'
 gem 'font-awesome-rails'
   
 # Pagination
 gem 'kaminari' 
 gem 'bootstrap-kaminari-views'
   
 # Others
 gem 'enumerize'
 gem 'simple_form'
 gem 'responders'
 ```

## Deploy e Configuração
Clone este repositório em um local de sua preferência (aqui vou usar como exemplo o diretório **home**)
```
$ cd ~
$ git clone https://github.com/w-osilva/markdown_blog.git
```

Acesse o diretório da aplicação e faça o checkout da versão estável (branch master)
```
$ cd markdown_blog
$ git checkout master
```

Download das dependências do projeto
```
$ bundle install
```

### Database (Migrations e Seeds)
###### config/database.yml
Precisamos criar o banco de dados e semear algumas tabelas com dados para a aplicação funcionar.
```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

### Redis
###### config/redis.yml
Caso esteja utilizando o serviço do redis em outro host ou porta, basta alterar no arquivo de configuração.  

Para iniciar o redis basta executar:
```
$ redis-server 
```
Se preferir que rode em backgroung adicione no comando o parametro: ```--daemonize yes```


### Sidekiq
###### config/sidekiq.yml
Depende do redis para poder persistir as mensagens recebidas (fila).  
Os Jobs funcionam como um serviço, quando estão em execução eles processam as mesnagens que estão na fila (cada Job tem a sua fila).  

Para iniciar o sidekiq basta executar:
```
$ sidekiq -C config/sidekiq.yml
```
Se preferir que rode em backgroung adicione no comando o parametro: ```-d```


### Puma (Webserver)
Para iniciar o puma basta executar:
```
$ rails s puma -b 0.0.0.0 -p 3000
```
Se preferir que rode em backgroung adicione no comando o parametro: ```-d```


### Login na aplicação
Acessando o link [http://localhost:3000](http://localhost:3000)

Inicialmente temos 2 usuários cadastrados:
```
-------Admin------------
email: admin@blog.com
senha: admin1234  
   
-------User-------------
email: user@blog.com
senha: user1234
```


###### [Voltar para Readme](README.md)