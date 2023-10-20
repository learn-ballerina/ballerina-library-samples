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