@api-automation
Feature: Rest API Testing 

  @get-products
  Scenario: GET products
    Given user login to hit the API
    When user sends a GET request to "/products"
    Then response status should be "200"
    And response should have "$..data[*].id"
    And response "$..data[*].id" should be integer
    And response should have "$..data[*].name"
    And response should have "$..data[*].description"

  @create-users
  Scenario: GET products
    Given user login to hit the API
    When user sends a POST request to "/users" with body:
    """
      {
			  "name":"Ayu",
			  "gender":"Female",
			  "email":"testayu123@gmail.com",
			  "status":"Active"
			}
    """
    Then response status should be "200"
    And response should have "$..data.email" matching "testayu123@gmail.com"


    