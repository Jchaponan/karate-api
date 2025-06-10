Feature: Delete Booking

  Background:
    * url 'https://restful-booker.herokuapp.com'
    * configure headers = { Accept: 'application/json' }

    # Create a booking first
    Given path 'booking'
    And request
      """
      {
        "firstname": "Test",
        "lastname": "User",
        "totalprice": 150,
        "depositpaid": true,
        "bookingdates": {
          "checkin": "2025-06-01",
          "checkout": "2025-06-10"
        },
        "additionalneeds": "Breakfast"
      }
      """
    When method POST
    Then status 200
    * def createdBookingId = response.bookingid
    #####
    # Create token for authentication
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

  Scenario: Delete booking by valid ID
    Given path 'booking', createdBookingId
    And header Cookie = 'token=' + tokenAuth
    When method DELETE
    Then status 201

    # Verify it's deleted
    Given path 'booking', createdBookingId
    When method GET
    Then status 404
