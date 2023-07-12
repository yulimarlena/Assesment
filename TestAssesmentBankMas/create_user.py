Feature: Create Price Tiers Bulk

Feature: Create User

    Background:
    * def createfeature = https://reqres.in/api/users
    * def createparameters = { "name": "morpheus", "job": "leader", "id": "267", "createdAt": "2023-07-12T09:06:55.527Z" }
    * def createresponse = {
                    "name": "#string",
                    "job": "#string",
                    "id": "#number",
                    "createdAt": "#string"
                    }
                    
    Scenario Outline : Create User
    Given set createparameters
    When method POST
    When call read (createfeature) createparameters
  
    Then match createresponse == 201
  
    And match response == createresponse