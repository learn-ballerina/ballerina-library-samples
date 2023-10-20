# Twilio Connector - Ballerina

In today’s interconnected world, communication is key, and what better way to enhance your application’s communication capabilities than by integrating [Twilio](https://www.twilio.com/en-us) with the [Ballerina](https://ballerina.io/) programming language? 

Ballerina, known for its simplicity and power in building cloud-native integrations, combines with Twilio’s versatile [communication APIs](https://dzone.com/articles/3-types-of-user-communication-apis-and-when-to-use) to help you send SMS, make voice calls, send WhatsApp messages, and more. 

In this guide, we’ll explore how the `ballerinax/twilio` package can empower you to build robust communication features effortlessly.

## Prerequisites
- Install [Ballerina Swan Lake](https://ballerina.io/downloads/) and [Ballerina VS Code plugin](https://wso2.com/ballerina/vscode/).
- Create a [Twilio](https://www.twilio.com/en-us) account.
- Obtain [Twilio phone number](https://support.twilio.com/hc/en-us/articles/223136107-How-does-Twilio-s-Free-Trial-work-).
- Obtain [Twilio Auth Tokens](https://support.twilio.com/hc/en-us/articles/223136027-Auth-Tokens-and-How-to-Change-Them).
- Obtain the Twilio WhatsApp number from the [Console’s WhatsApp Sandbox](https://www.twilio.com/console/sms/whatsapp/sandbox).

## Sample 1: Send/Receive Calls and Messages With Ballerina

Create a new Ballerina package using the command below.

```
bal new send-receive-with-twilio
```
This creates a new Ballerina package in the default module with the `Ballerina.toml` file, which identifies a directory as a package and a sample source file (i.e., `main.bal`) with a main function.

To provide the configurations required, create a new file named `Config.toml`` and add the send/receive phone numbers, SID, and auth token received from Twilio. The file structure within the package will look like below.

![Alt text](./images/ballerina-package-structure.png)

Add the following code to `main.bal` file.

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

Add the configuration values to the `Config.toml` file. It will look like below.

```
accountSId="xxxxxxxxxxxxxxxxxxxxxxx"
authToken="xxxxxxxxxxxxxxxxxxxxxxx"
fromNumber="+1xxxxxxxxxx"
fromWhatsAppNumber="+1xxxxxxxxxx"
toNumber="+1xxxxxxxxxx"
```

Then, run the program using `bal run    ` command, and you will see the following logs.

```
time = 2023-08-29T16:54:47.536-05:00 level = INFO module = anupama/twilio_samples message = "SMS Response: {\"sid\":\"SM12099885cce2c78bf5f50903ca83d3ac\",\"dateCreated\":\"Tue, 29 Aug 2023 21:54:47 +0000\",\"dateUpdated\":\"Tue, 29 Aug 2023 21:54:47 +0000\",\"dateSent\":\"\",\"accountSid\":\"xxxxxxxxxxxxx\",\"toNumber\":\"+1xxxxxxxxxx\",\"fromNumber\":\"+1xxxxxxxxxx\",\"body\":\"Sent from your Twilio trial account - This is a test message from Ballerina\",\"status\":\"queued\",\"direction\":\"outbound-api\",\"apiVersion\":\"2010-04-01\",\"price\":\"\",\"priceUnit\":\"USD\",\"uri\":\"/2010-04-01/Accounts/xxxxxxxxxxxxx/Messages/SM12099885cce2c78bf5f50903ca83d3ac.json\",\"numSegments\":\"1\"}"
time = 2023-08-29T16:54:47.694-05:00 level = INFO module = anupama/twilio_samples message = "Message Detail: {\"body\":\"Sent from your Twilio trial account - This is a test message from Ballerina\",\"numSegments\":\"1\",\"direction\":\"outbound-api\",\"fromNumber\":\"outbound-api\",\"toNumber\":\"+1xxxxxxxxxx\",\"dateUpdated\":\"Tue, 29 Aug 2023 21:54:47 +0000\",\"price\":\"\",\"errorMessage\":\"\",\"uri\":\"/2010-04-01/Accounts/xxxxxxxxxxxxx/Messages/SM12099885cce2c78bf5f50903ca83d3ac.json\",\"accountSid\":\"xxxxxxxxxxxxx\",\"numMedia\":\"0\",\"status\":\"sent\",\"messagingServiceSid\":\"\",\"sid\":\"SM12099885cce2c78bf5f50903ca83d3ac\",\"dateSent\":\"Tue, 29 Aug 2023 21:54:47 +0000\",\"dateCreated\":\"Tue, 29 Aug 2023 21:54:47 +0000\",\"errorCode\":\"\",\"priceUnit\":\"USD\",\"apiVersion\":\"2010-04-01\",\"subresourceUris\":\"{\"media\":\"/2010-04-01/Accounts/xxxxxxxxxxxxx/Messages/SM12099885cce2c78bf5f50903ca83d3ac/Media.json\",\"feedback\":\"/2010-04-01/Accounts/xxxxxxxxxxxxx/Messages/SM12099885cce2c78bf5f50903ca83d3ac/Feedback.json\"}\"}"
time = 2023-08-29T16:54:47.828-05:00 level = INFO module = anupama/twilio_samples message = "Voice Call Response: {\"sid\":\"CAaa2e5a5c7591928f7e28c79da97e615a\",\"status\":\"queued\",\"price\":\"\",\"priceUnit\":\"USD\"}"
time = 2023-08-29T16:54:47.993-05:00 level = INFO module = anupama/twilio_samples message = "WhatsApp Response: {\"sid\":\"SM3c272753409bd4814a60c7fd06d97232\",\"dateCreated\":\"Tue, 29 Aug 2023 21:54:47 +0000\",\"dateUpdated\":\"Tue, 29 Aug 2023 21:54:47 +0000\",\"dateSent\":\"\",\"accountSid\":\"xxxxxxxxxxxxx\",\"toNumber\":\"whatsapp:+1xxxxxxxxxx\",\"fromNumber\":\"whatsapp:+1xxxxxxxxxx\",\"messageServiceSid\":\"\",\"body\":\"This is a test message from Ballerina\",\"status\":\"queued\",\"numSegments\":\"1\",\"numMedia\":\"0\",\"direction\":\"outbound-api\",\"apiVersion\":\"2010-04-01\",\"price\":\"\",\"priceUnit\":\"\",\"errorCode\":\"\",\"errorMessage\":\"\",\"uri\":\"\",\"subresourceUris\":\"{\"media\":\"/2010-04-01/Accounts/xxxxxxxxxxxxx/Messages/SM3c272753409bd4814a60c7fd06d97232/Media.json\"}\"}"
time = 2023-08-29T16:54:48.076-05:00 level = INFO module = anupama/twilio_samples message = "Account Details: {\"sid\":\"xxxxxxxxxxxxx\",\"name\":\"My first Twilio account\",\"status\":\"active\",\"type\":\"Trial\",\"createdDate\":\"Fri, 18 Aug 2023 21:14:20 +0000\",\"updatedDate\":\"Fri, 18 Aug 2023 21:14:54 +0000\"}"
```

Also, you will get an SMS, a voice call, and a WhatsApp message to the specified number.

Are you interested in seeing this sample's sequence diagram generated by the Ballerina VS Code plugin? You can see the interactions with Twilio clearly in this diagram without reading the code. The Sequence diagram can capture how the logic of your program flows, how the concurrent execution flow works, which remote endpoints are involved, and how those endpoints interact with the different workers in the program. See the [Sequence diagram view](https://wso2.com/ballerina/vscode/docs/implement-the-code/sequence-diagram-view/) for more details.

![Alt text](./images/ballerina-with-twilio-sequence-diagram.png)

