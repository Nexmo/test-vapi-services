# Testing Rails Application for Nexmo VAPI services

This Rails app encompasses various actions to test Nexmo VAPI features.

Right now, the following are included:

* VAPI REST Start and Stop Conversation Recording

## VAPI REST Start/Stop Conversation Recording

The actions for testing the REST Start and Stop of an in-progress call are in `/controllers/rest_controller.rb`.

Usage:

1. Create a Nexmo voice application and link a Nexmo provisioned phone number to it
2. Supply your Nexmo credentials to Rails Credentials, namespaced under `nexmo`: `api_key`, `api_secret`, `application_id`, `private_key` (i.e. `Rails.application.credentials.nexmo[:api_key]`)
3. Start the Rails server
4. Start the ngrok server, ensuring that the ngrok subdomain matches the subdomain provided to the Nexmo application
5. Call the Nexmo provisioned phone number
6. Navigate to `http://localhost:3000` and choose `Start` and press `Submit`
7. To stop the recording choose `Stop` and press `Submit`
8. Your Rails server logs will show the output from the Nexmo API including whether the action was successful and the recording URL

*(Note: You can test either named or ephemeral conversations by uncommenting and commenting out the appropriate NCCO action in the `#answer` action in the `RestController`.)*

## LICENSE

This project is licensed under the [MIT LICENSE](LICENSE).
