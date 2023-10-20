# Twilio Connector - Ballerina

In today’s interconnected world, communication is key, and what better way to enhance your application’s communication capabilities than by integrating Twilio with the Ballerina programming language? 

Ballerina, known for its simplicity and power in building cloud-native integrations, combines with Twilio’s versatile communication APIs to help you send SMS, make voice calls, send WhatsApp messages, and more. 

In this guide, we’ll explore how the `ballerinax/twilio` package can empower you to build robust communication features effortlessly.

## Prerequisites
- Install Ballerina Swan Lake and Ballerina VS Code plugin.
- Create a Twilio account.
- Obtain Twilio phone number.
- Obtain Twilio Auth Tokens.
- Obtain the Twilio WhatsApp number from the Console’s WhatsApp Sandbox.

```ballerina
import ballerina/log;
import ballerinax/twilio;

configurable string accountSId = ?;
configurable string authToken = ?;
configurable string fromNumber = ?;
configurable string fromWhatsAppNumber = ?;
configurable string toNumber = ?;

configurable string message = "This is a test message from Ballerina";

//Create Twilio client
final twilio:Client twilio = check new ({twilioAuth: {accountSId, authToken}});

public function main() returns error? {
    //Send SMS
    twilio:SmsResponse smsResponse = check twilio->sendSms(fromNumber, toNumber, message);
    log:printInfo(string `SMS Response: ${smsResponse.toString()}`);

    //Get the details of SMS sent above
    twilio:MessageResourceResponse details = check twilio->getMessage(smsResponse.sid);
    log:printInfo("Message Detail: " + details.toString());

    //Make a voice call
    twilio:VoiceCallResponse voiceResponse = check twilio->makeVoiceCall(fromNumber, toNumber, {
        userInput: message,
        userInputType: twilio:MESSAGE_IN_TEXT
    });
    log:printInfo(string `Voice Call Response: ${voiceResponse.toString()}`);

    //Send whatsapp message
    twilio:WhatsAppResponse whatsappResponse = check twilio->sendWhatsAppMessage(fromWhatsAppNumber, toNumber, message);
    log:printInfo(string `WhatsApp Response: ${whatsappResponse.toString()}`);

    // Get Account Details
    twilio:Account accountDetails = check twilio->getAccountDetails();
    log:printInfo(string `Account Details: ${accountDetails.toString()}`);

}
```