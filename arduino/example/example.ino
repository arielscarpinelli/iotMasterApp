#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include "ConnectionManager.h"

#define MQTT_SERVER      "mqtt.gbridge.io"
#define MQTT_SERVERPORT  8883                   

void onMqttMessage(char* topic, byte* payload, unsigned int length);

// Create an ESP8266 WiFiClient class to connect to the MQTT server.
WiFiClientSecure client;

// Setup the MQTT client class by passing in the WiFi client and MQTT server and login details.
PubSubClient mqtt(MQTT_SERVER, MQTT_SERVERPORT, onMqttMessage, client);

class MyConnectionManager : public ConnectionManager {
  public: 
  MyConnectionManager(WiFiClientSecure &client, PubSubClient &mqtt) : 
    ConnectionManager(client, mqtt) {}
  
  virtual void onConnect() {
    Serial.println("Connected!");
    // TODO: connect this to the reported traits
    // Here you should subscribe to mqtt topics
  }
};

MyConnectionManager conn(client, mqtt);

void setup() {
    Serial.begin(115200);

    // TODO: recover these from saved config
    ConnectionManagerConfig config;
    
    config.hostname = "example"; 
    config.mqttUsername = "user";
    config.mqttPassword = "pass";
    config.tz = "ART";

    // pushbutton should be connected between D1 and GND. 
    // note: this uses INPUT_PULLUP mode which doesn't play well with D8 in ESP12
    conn.setup(D1, LED_BUILTIN, config);
}

void loop() {
    conn.loop();
}

void onMqttMessage(char* topic, byte* payload, unsigned int length) {}


/*
#include <ESP8266WiFi.h>

void setup() {
    WiFi.mode(WIFI_STA);
    WiFi.beginSmartConfig();
    Serial.begin(115200);
}

void loop() {
  // put your main code here, to run repeatedly:
  if(!WiFi.smartConfigDone()) {
    Serial.print(".");
  } else {

    Serial.print("Connected to ");
    Serial.println(WiFi.SSID());

    int wifiStatus;
    
    if ((wifiStatus = WiFi.status()) != WL_CONNECTED) {
      Serial.print("Wifi status: ");
      Serial.println(wifiStatus);
    } else {
      Serial.print("IP address: "); 
      Serial.println(WiFi.localIP());
    }

  }
  delay(200);
}
*/
