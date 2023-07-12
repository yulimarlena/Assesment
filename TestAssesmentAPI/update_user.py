Feature: Update User

    Background:
    * def updateuser = https://reqres.in/api/users/2
    * def updateparameters = { "name": "morpheus", "job": "zion resident" }
    * def updateresponse = {
                    "name": "#string",
                    "job": "#string",
                    "updatedAt": "#string"
                    }
                    
    Scenario Outline : Update User
    Given set updateparameters
    When method PUT
    When call read (updateuser) updateparameters
  
    Then match responseStatus = 200
  
    And match response == updateresponse
