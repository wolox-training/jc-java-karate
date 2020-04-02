Feature: login as different roles

    @regular
  Scenario: register and login as a new regular user
    * def register = call read('classpath:nodejs/flows/auth/register.feature')
    * def credentials =
    """
    {
      "email": "#(register.newUser.email)",
      "password": "#(register.newUser.password)"
    }
    """
    * call read('classpath:nodejs/flows/auth/login.feature') credentials

    @admin
  Scenario: login as admin user using known credentials
    * def credentials = read('classpath:nodejs/flows/auth/admin.json')
    * call read('classpath:nodejs/flows/auth/login.feature') credentials