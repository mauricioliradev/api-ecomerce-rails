##  loja do "seu" Manuel - API v1

#### Exemplo de API em Ruby on Rails para gestão de produtos e pedidos, primeira versão.

- - - 

## INSTALAÇÃO

Clone o repositório em seu computador, instale as gems do projeto, crie a database e inicie o servidor Rails, como mostrado abaixo.

    git clone git@github.com:mauricioliradev/api-ecomerce-rails.git

    cd code-challenge

    bundle

    rails db:create && rails db:migrate

    rails s

Sample Data (SEED)
Para gerar as seeds reproduza o seguinte comando na pasta do projeto:

    rails db:seed

TESTES
Os testes do *rspec* vão sempre gerar um banco de dados vazio e povoá-lo com dados da seed
Foram feitos testes de controllers e models

    rspec

- - - 

## ENDPOINTS DA API

Utilize o browser ou um serviço como o Postman para acessar os endpoints abaixo:

#### Produtos

GET /api/v1/products - Retorna todos os produtos cadastrados        

GET /api/v1/products/:id - Exibe informações sobre um produto 

PUT /api/v1/products/:id - atualiza informações de um produto existente

POST /api/v1/products - cria um novo produto

DELETE /api/v1/products/:id - deleta um produto existente (retorna no-content)


#### Pedidos

GET /api/v1/orders - Retorna todos os pedidos cadastrados

GET /api/v1/orders/:id - Exibe informações sobre um pedido 

PUT /api/v1/orders/:id - atualiza informações de um pedido existente

POST /api/v1/orders - cria um novo pedido

DELETE /api/v1/orders/:id - deleta um produto existente 

#### Relatórios

POST /api/v1/reports - relatório de ticket médio

- - - 

## FORMATOS

Entradas e saídas são realizadas utilizando JSON.

### Modelo de Produtos 

Exemplo de entrada:
```javascript
    POST http://localhost:3000/api/v1/products
    { "product": 
        {
            "code": "7892",
            "name": "Notebook acer", 
            "price": "2100.89", 
            "stock": "5",
            "description": "i3-7200U 8GB 1TB Tela 15.6 Linux",
            "customizable_attributes": "preto, branco, sinza"
        } 
    }
```

Exemplo de saída:
```javascript
    GET http://localhost:3000/api/v1/products/:id

    {
        "id": :id,
        "code": "7892",
        "name": "Notebook acer",
        "description": "i3-7200U 8GB 1TB Tela 15.6 Linux",
        "stock": 5,
        "price": 2100.89,
        "created_at": "2019-02-22T11:34:42.470Z",
        "updated_at": "2019-02-22T11:34:42.470Z",
        "customizable_attributes": "preto, branco, sinza"
    }
```

    
### Modelo de Pedidos 

Exemplo de entrada:

    POST http://localhost:3000/api/v1/orders
```javascript
    { "order": 
        {
            "code": "80025577",
            "buy_date": "2019-02-19",
            "status": "pendente",
            "freight_value": 37.23,
            "buyer": "Benjamin Button",
            "order_items_attributes": [
                {
                   "product_id": 1,
                   "amount": 2,
                   "sold_price": 1.35
                },
                {
                   "product_id": 2,
                   "amount": 4,
                   "sold_price": 5.09
                }
            ]
        }
    }
```

Exemplo de saída:

    GET http://localhost:3000/api/v1/orders/:id
```javascript
    {
        "id": :id,
        "code": "80025577",
        "buy_date": "2019-02-19T00:00:00.000Z",
        "status": "pendente",
        "freight_value": 37.23,
        "created_at": "2019-02-22T11:36:09.820Z",
        "updated_at": "2019-02-22T11:36:09.820Z",
        "buyer": "Benjamin Button",
        "order_items": [
            {
                "id": 21,
                "order_id": :id,
                "product_id": 1,
                "amount": 2,
                "sold_price": 1.35,
                "created_at": "2019-02-22T11:36:09.894Z",
                "updated_at": "2019-02-22T11:36:09.894Z"
            },
            {
                "id": 22,
                "order_id": :id,
                "product_id": 2,
                "amount": 4,
                "sold_price": 5.09,
                "created_at": "2019-02-22T11:36:09.942Z",
                "updated_at": "2019-02-22T11:36:09.942Z"
            }
        ]
    }
```

### Relatórios de Ticket Médio 

exemplo de entrada:

    POST http://localhost:3000/api/v1/reports
```javascript
    {"start_date": "2019-01-01",
    "end_date": "2019-02-20"}
```
exemplo de saída:
```javascript
    {
        "start_date": "2019-01-01",
        "end_date": "2019-02-20",
        "number_of_orders": 11,
        "total_revenue": 1730.89,
        "average_ticket": 157.35
    }
```
- - - 

## Obervações

#### Ticket Médio:

* a =  Volume Total de Vendas no período, ou Venda Totais 

* b =  Número de Vendas Realizadas

* Ticket Médio = a / b

#### Pedidos (orders):

* possuem código ("code"), data de compra ("buy_date"), nome do comprador ("buyer"), status ("status"), freight_value ("shipping_cost")

* possuem itens (products) por meio da tabela intermediáris OrderItems

* cada item possui uma quantidade (amount)

* cada item tem um preço de venda (sold_price)


#### Itens de pedido (order_items):

* apontam como referência um pedido e um produto

* funciona como tabela intermediária entre produto e pedido

* possuem id do produto(product_id), id do pedido (order_id), quantidade (amount) e preço de venda (sold_price)

### Database
Usei o postgres como database, podem editar o arquivo de database.yml de acordo com a necessidade
    username: X
    password: X

- - - 
    