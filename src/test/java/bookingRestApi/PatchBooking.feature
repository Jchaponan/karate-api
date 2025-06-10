Feature: Patch Booking

  Background:
    * url 'https://restful-booker.herokuapp.com'
    * configure headers = { Accept: 'application/json' }

    # Create a booking
    Given path 'booking'
    And request
      """
      {
        "firstname": "Patch",
        "lastname": "Test",
        "totalprice": 100,
        "depositpaid": false,
        "bookingdates": {
          "checkin": "2025-06-01",
          "checkout": "2025-06-10"
        },
        "additionalneeds": "Lunch"
      }
      """
    When method POST
    Then status 200
    * def createdBookingId = response.bookingid

    # Auth token
    Given path 'auth'
    And request
      """
      {
        "username": "admin",
        "password": "password123"
      }
      """
    When method POST
    Then status 200
    * def tokenAuth = response.token

  Scenario: Patch booking firstname and lastname
    Given path 'booking', createdBookingId
    And header Cookie = 'token=' + tokenAuth
    And request
      """
      {
        "firstname": "Updated",
        "lastname": "Name"
      }
      """
    When method PATCH
    Then status 200
    And match response.firstname == 'Updated'
    And match response.lastname == 'Name'
