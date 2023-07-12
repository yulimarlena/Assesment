Feature: Delete User

    Background:
    * def deleteuser = https://reqres.in/api/users
    * def updateparameters = { 2 }
                    
    Scenario Outline : Delete User
    Given set deleteparameters
    When method DELETE
    When call read (deleteuser) deleteparameters
  
    Then match responseStatus = 204
  

