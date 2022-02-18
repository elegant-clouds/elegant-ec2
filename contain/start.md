---
order: 10
icon: code-square
title: Bien démarrer
---
# Démarrer

La plateforme bantu dispose de deux pointées d'entrée:

- https://api.bantu.dev &mdash; API Gateway
- https://identity.bantu.dev &mdash; Identity Provider

Le premier point d'entrée est certainement celui qui sera le plus utilisé.

Pour développeur avec Bantu, les étapes suivantes sont à suivre:

1. Créer un compte développeur pour récupérer une clé d'API de type compte
2. Créer une application pour récupérer des clés d'API de type application
3. Utiliser les clés d'api de type application pour exploiter le reste du catalogue d'APIs

## Compte développeur

Pour commencer à utiliser les APIs de la plateforme, la création d'un compte développeur est nécessaire.
Ceci est possible via <a href="http://46.101.77.127:10000/swagger-ui/index.html" target="_blank">l'API Accounts</a>.

+++ curl
```bash
# Exemple de requête 

curl -X 'POST' 'https://api.bantu.dev/accounts' \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "account-name",
    "email": "developer@email.com"
  }'

```
+++ rest client (vscode)
```graphql
@baseUrl = https://api.bantu.dev

### ------------------------------------------------------------------------------
### Créer votre compte développeur
### ------------------------------------------------------------------------------

POST {{baseUrl}}/accounts
Content-Type: application/json

{
    "name": "account-name",
    "email": "developer@email.com"
}
```
+++


Si votre requête est valide, vous recevrez une réponse JSON avec la structure suivante:

```json
{
  "success": true,
  "accountId": "acc_1ib0yvl75q92b",
  "message": "The api-key was sent to the provided email address"
}
```

| Champs   | Obligatoire | Description                  |
|-         |-            |-                             |
|`name`      | Oui         | Nom du compte développeur    |
|`email`     | Oui         | Cette adresse est utilisée pour vous transmettre votre clé d'API. Vous devez donc fournir une adresse valide    |


!!! 
Nous transmettons la clé d'API à votre email pour en effectuer la vérification en même temps.
!!!

Lorsque la création du comtpe développeur abouti, le mail transmis contient les informations suivantes:


``` Exemple d'email
Your account has been created.
Your account id is acc_t4htyy32n1va
Your api key is ak_VrDi2KTxKQeR5Zf9DV6GX
```

Il est donc important de bien conserver ces informations. En cas d'oubli, une API permet de renvoyer ces informations toujours par email.


!!!warning
Arpès création de votre compte développeur, si la clé d'API n'est pas utilisée pour créer une application au bout de 7 jours, le compte est
automatiquement détruit avec un email de notification.
!!!

## Créer une application