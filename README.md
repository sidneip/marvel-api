# Marvel

[Marvel http://ec2-35-163-123-62.us-west-2.compute.amazonaws.com:81](http://ec2-35-163-123-62.us-west-2.compute.amazonaws.com:81)

## Install
`
bundle install
`

## Run Tests
`
rails test
`

## Run Sever
`
rails server
`

# POSTMAN

Arquivo na raiz da projeto marvel.postman_collection

## CURL API

### INDEX

`
curl --request GET \
  --url 'http://ec2-35-163-123-62.us-west-2.compute.amazonaws.com:81/api/characters?page=2' --header 'content-type: application/json'

`

### SHOW

`
curl --request GET --url http://ec2-35-163-123-62.us-west-2.compute.amazonaws.com:81/api/characters/2 --header 'content-type: application/json'
`

### DELETE

`

curl --request DELETE --url http://ec2-35-163-123-62.us-west-2.compute.amazonaws.com:81/api/characters/200 --header 'content-type: application/json'

`
