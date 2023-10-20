import ballerina/http;

service /twilio on new http:Listener(9090) {

    resource function post voice() returns xml {
        xml response = xml `<?xml version="1.0" encoding="UTF-8"?>
        <Response>
            <Play loop="10">https://api.twilio.com/cowbell.mp3</Play>
        </Response>`;
        return response;
    }
}
