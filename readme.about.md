# Sobre a solução desenvolvida

Busquei levar alguns principios em consideração para realizar esse desafio.

#### Foco no MVP
Embora a descrição do desafio esteja bem definida, durante o desenvolvimento e utilização da primeira versão desta solução 
eu pude perceber alguns pontos onde caberiam a implementação de recursos para melhorar a usabilidade, mas mantive o foco em uma 
versão que atendesse aos requisitos e depois poderia ser lapidada e melhorada.

#### Qualidade de código
Sou um desenvolvedor que me preocupo com o código que faço, eu penso que um código legível e intuítivo vale mais do que uma 
documentação cheia de detalhes.

Me preocupo com *o próximo desenvolvedor* que terá que trabalhar com o meu código, assim sendo busco seguir algumas boas práticas.
* DRY
* Single Responsability
* Kiss 

Também me preocupo com a organização do código dentro da estrutura de MVC e costumo criar alguns diretórios adicionais:

* **Services:** componentes que podem ser utilizados em todo o escopo da aplicação como singletons ou classes estáticas
* **Models/Adapters:** classes auxiliares para a formatação de objetos providos de um domínio externo para dentro do dominio da aplicação

Ainda seguindo nessa linha de raciocício sobre organização de código, eu gosto de encapsular dentro do Model toda lógica 
voltada para a regra de negócio em torno dele, assim consigo trabalhar com *MVC do jeito certo* (ou o mais certo possível).

* Model, encapsula as regras de negócio e funções referente ao mesmo;
* Controller, só faz a transição entre view e model (é o carteiro que pega algo aqui e entrega ali);
* View, só apresenta os dados fornecidos pelo controller. Já a lógica necessária para formatar dados e tornar a página dinamica ficam por conta de outros recursos;
    * Helpers
    * Presenters
    * Decorators
    * Javascript

## Testes

Para testes eu usei o **Rspec** e o **Capybara**, pode-se dizer que para mim foi gratificante pois particularente eu acretito que este
é um ponto onde preciso melhorar (e a melhorar maneira de melhorar é praticando).

#### Unitários

Embora não tenha conseguido cobrir toda a aplicação com testes, tentei focar nos principais cenários e testar os componentes que 
interagem com eles.

#### Aceitação
Usei o Capybara para testar o fluxo da aplicação, como se fosse um usuário operando a view.  
Pesquisei, li e vi alguns  exemplos de como utilizar a técnica de PageObjects, fiz uma aplicação mas sinceramente acredito que possa evoluir
bastante (pois foi a primeira vez que usei Capybara para testes).


## Jobs

Como citei inicialmente, foquei no MVC e nos requisitos fornecidos. Assim sendo mantive o raciocinio de construir da maneira mais simples possível e utilizar os recursos 
que a linguagem e o framework nos oferecem.

Os jobs por exemplo são um exemplo que podem ser melhorados, fazendo com que se tornem tolerantes a falhas e recursivos.


#### Conversão de markdown e publicação de Post

Criei duas filas
* post_markdown
* post_publish

O processó que criei é simples: 

1. usei o callback **after_save** para enviar a mensagem para fila do Job de conversão **(post_markdown)** ;  
2. Job busca o model (post);
3. utiliza o *Service* para converter o *text_md* para *text_html*, seta esse atributo no post e o salva;
4. depois de salvar, envia uma mensagem para a fila do Job de publicação **(post_publish)**;
5. Job busca o model (post);
6. chama o método *publish* do post, que faz a criação do diretório do usário e salva o arquivo html.

## WYSIWYG

Um dos requisitos era utilizar essa técnica de pré-visualização, então optei pela utilização do editor
[SimpleMDE](https://simplemde.com/) por ser simples de implementar e atender às necessidades.



###### [Voltar para Readme](README.md)