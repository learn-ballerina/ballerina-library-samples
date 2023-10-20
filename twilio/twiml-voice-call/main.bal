import ballerina/log;
import ballerinax/twilio;

configurable string accountSId = ?;
configurable string authToken = ?;
configurable string fromNumber = ?;
configurable string toNumber = ?;
configurable string voiceTwimUrl = ?;

//Create Twilio client
final twilio:Client twilio = check new ({twilioAuth: {accountSId, authToken}});

public function main() returns error? {
    //Make a voice call
    twilio:VoiceCallResponse voiceResponse = check twilio->makeVoiceCall(fromNumber, toNumber, {
        userInput: voiceTwimUrl,
        userInputType: twilio:TWIML_URL
    });
    log:printInfo(string `Voice Call Response: ${voiceResponse.toString()}`);

}
