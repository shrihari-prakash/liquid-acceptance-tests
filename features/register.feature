@registration
Feature: Check the user registration flow

Scenario Outline: User registartion
    Given Access the login page with the URL of "http://localhost:2000"
    And Checks that user is able to access the login page
    When User clicks on create account link
    And Checks that user is landed on the "Sign up" page
    Then Enters the "<Username>" in username field on the registartion page
    And Enters the "<FirstName>" in firstname field on the registartion page
    And Enters the "<LastName>" in lastname field on the registartion page
    And Enters the "<Email>" in email field on the registartion page
    And Enters the "<Password>" in password field on the registartion page
    Then Clicks the create account button
    And Checks that user redirected to login page

    Examples:
        | Username | FirstName | LastName | Email | Password |
        | rajagopal_test1  | raja  | gopal | rajagopal1988@gmail.com | password |

Scenario: Check that user is able to login with the above created user account
    Given Access the login page with the URL of "http://localhost:2000"
    And Checks that user is able to access the login page
    When Enter the username as "rajagopal_test1"
    And Enter the password as "password"
    And Click on the login button
    #Then Check that the consent page is displayed
    #And Click on the consent button
    Then Check that agent is able to view the status as "UP" on the redirect page

Scenario: Check that user is not able to create an account with the same email address
    Given Access the login page with the URL of "http://localhost:2000"
    And Checks that user is able to access the login page
    When User clicks on create account link
    And Checks that user is landed on the "Sign up" page
    Then Enters the "<Username>" in username field on the registartion page
    And Enters the "<FirstName>" in firstname field on the registartion page
    And Enters the "<LastName>" in lastname field on the registartion page
    And Enters the "<Email>" in email field on the registartion page
    And Enters the "<Password>" in password field on the registartion page
    Then Clicks the create account button
    Then Checks that "Account already exists" error message is displayed

    Examples:
        | Username | FirstName | LastName | Email | Password |
        | rajagopal_test2  | raja  | gopal | rajagopal.1988@gmail.com | password |

Scenario: Check that user is unable to create an account which doesn't present under email domains
    Given Stop all the running docker containers
    Then Update the environment variable "USER_ACCOUNT_CREATION_ALLOW_ONLY_WHITELISTED_EMAIL_DOMAINS" with value "true"
    Then Update the environment variable "USER_ACCOUNT_CREATION_WHITELITED_EMAIL_DOMAINS" with value "gmail.com,outlook"
    Then Start all the docker containers
    Then User wait for 10 seconds
    Then Update the redirectURI value on DB
    Given Access the login page with the URL of "http://localhost:2000"
    And Checks that user is able to access the login page
    When User clicks on create account link
    And Checks that user is landed on the "Sign up" page
    Then Enters the "<Username>" in username field on the registartion page
    And Enters the "<FirstName>" in firstname field on the registartion page
    And Enters the "<LastName>" in lastname field on the registartion page
    And Enters the "<Email>" in email field on the registartion page
    And Enters the "<Password>" in password field on the registartion page
    Then Clicks the create account button
    Then Checks that "Bad email domain" error message is displayed

    Examples:
        | Username | FirstName | LastName | Email | Password |
        | rajagopal_test3  | test  | account | rajagopal@hotmail.com | password |

Scenario: Check that user is able to view the error message as invalid phone number, when phone number field is blank
    Given Stop all the running docker containers
    Then Update the environment variable "CAN_USE_PHONE_NUMBER" with value "true"
    Then Start all the docker containers
    Then User wait for 10 seconds
    Then Update the redirectURI value on DB
    Given Access the login page with the URL of "http://localhost:2000"
    And Checks that user is able to access the login page
    When User clicks on create account link
    And Checks that user is landed on the "Sign up" page
    Then Enters the "<Username>" in username field on the registartion page
    And Enters the "<FirstName>" in firstname field on the registartion page
    And Enters the "<LastName>" in lastname field on the registartion page
    And Enters the "<Email>" in email field on the registartion page
    And Enters the "<Password>" in password field on the registartion page
    Then Clicks the create account button
    Then Checks that "Invalid PhoneCountryCode" error message is displayed

    Examples:
        | Username | FirstName | LastName | Email | Password |
        | rajagopal_test4  | test  | noPhoneNumber | rajagopal_3@gmail.com | password |

Scenario: Check that user is able to create an account with valid phone number
    Given Stop all the running docker containers
    Then Update the environment variable "CAN_USE_PHONE_NUMBER" with value "true"
    Then Update the environment variable "USER_ACCOUNT_CREATION_ENABLE_IP_BASED_THROTTLE" with value "true"
    Then Update the environment variable "USER_ACCOUNT_CREATION_IP_BASED_THROTTLE_WINDOW_SIZE" with value "60"
    Then Start all the docker containers
    Then User wait for 10 seconds
    Then Update the redirectURI value on DB
    Given Access the login page with the URL of "http://localhost:2000"
    And Checks that user is able to access the login page
    When User clicks on create account link
    And Checks that user is landed on the "Sign up" page
    Then Enters the "<Username>" in username field on the registartion page
    And Enters the "<FirstName>" in firstname field on the registartion page
    And Enters the "<LastName>" in lastname field on the registartion page
    And Enters the "<Email>" in email field on the registartion page
    And Enters the country code "<CountryCode>" and phone number "<PhoneNumber>" in phone number field on the registration page
    And Enters the "<Password>" in password field on the registartion page
    Then Clicks the create account button
    And Checks that user redirected to login page

    Examples:
        | Username | FirstName | LastName | Email | CountryCode | PhoneNumber | Password |
        | rajagopal_test5  | test  | withPhoneNumber | rajagopal_4@gmail.com | +91 | 9600338223 | password |

Scenario: Check that user is unable to create an account for 1 min
    Given Access the login page with the URL of "http://localhost:2000"
    And Checks that user is able to access the login page
    When User clicks on create account link
    And Checks that user is landed on the "Sign up" page
    Then Enters the "<Username>" in username field on the registartion page
    And Enters the "<FirstName>" in firstname field on the registartion page
    And Enters the "<LastName>" in lastname field on the registartion page
    And Enters the "<Email>" in email field on the registartion page
    And Enters the country code "<CountryCode>" and phone number "<PhoneNumber>" in phone number field on the registration page
    And Enters the "<Password>" in password field on the registartion page
    Then Clicks the create account button
    Then Checks that "Account creation limited" error message is displayed
    Then User wait for 60 seconds
    Then Clicks the create account button
    And Checks that user redirected to login page

    Examples:
        | Username | FirstName | LastName | Email | CountryCode | PhoneNumber | Password |
        | rajagopal_test6  | test  | withPhoneNumber | rajagopal_5@gmail.com | +91 | 9600338223 | password |

Scenario: Check that error message is thrown when the password doesn't match the REGEX format
    Given Stop all the running docker containers
    Then Update the environment variable "USER_PROFILE_PASSWORD_VALIDATION_REGEX" with value "'^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{6,16}$'"
    Then Start all the docker containers
    Then User wait for 10 seconds
    Then Update the redirectURI value on DB
    Given Access the login page with the URL of "http://localhost:2000"
    And Checks that user is able to access the login page
    When User clicks on create account link
    And Checks that user is landed on the "Sign up" page
    Then Enters the "<Username>" in username field on the registartion page
    And Enters the "<FirstName>" in firstname field on the registartion page
    And Enters the "<LastName>" in lastname field on the registartion page
    And Enters the "<Email>" in email field on the registartion page
    And Enters the country code "<CountryCode>" and phone number "<PhoneNumber>" in phone number field on the registration page
    And Enters the "<Password>" in password field on the registartion page
    Then Clicks the create account button
    Then Checks that "Invalid Password" error message is displayed
    And Enters the "<Password1>" in password field on the registartion page
    Then Clicks the create account button
    And Checks that user redirected to login page

    Examples:
        | Username | FirstName | LastName | Email | CountryCode | PhoneNumber | Password | Password1 |
        | rajagopal_test6  | test  | withPhoneNumber | rajagopal_5@gmail.com | +91 | 9600338223 | password | Password@1 |

