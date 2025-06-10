Feature: Create Booking

  Background:
    * url 'https://restful-booker.herokuapp.com'
    * configure headers = { Accept: 'application/json' }

  Scenario: Create booking successfully
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

    Given path 'booking'
    And header Cookie = 'token=' + tokenAuth
    And request
    """
    {
      "firstname": "Andres",
      "lastname": "Wiese",
      "totalprice": 333,
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
    * print 'Booking created with ID:', createdBookingId
