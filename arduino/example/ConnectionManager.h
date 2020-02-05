#include "certificates.h"
#include <ESP8266mDNS.h>
#include <FunctionalInterrupt.h>

#ifdef DEBUG_ESP_PORT
  #define DEBUG_MSG(...) Serial.println( __VA_ARGS__ )
  #define DEBUG_WRITE(...) Serial.write( __VA_ARGS__ )
  #define DEBUG_MSG_(...) Serial.print( __VA_ARGS__ )
#else
  #define DEBUG_MSG(...)
  #define DEBUG_WRITE(...)
  #define DEBUG_MSG_(...)
#endif


struct ConnectionManagerConfig {
  String hostname;
  String mqttUsername;
  String mqttPassword;
  String tz;
};


class ConnectionManager {

  protected:
    BearSSL::X509List certificates;
    WiFiClientSecure &client;
    PubSubClient &mqtt;
    ConnectionManagerConfig config;
    bool connectingLed = false;
    bool hasEverConnected = false;
    bool configuringWifi = false;
    unsigned long lastLoopMillis = 0;
    unsigned long nextDelayMillis = 500;
    unsigned long lastButtonDownMillis = 0;
    int ledPin;

  public:
    ConnectionManager(WiFiClientSecure &client, PubSubClient &mqtt) :
      client(client),
      mqtt(mqtt) {}

    void setup(int buttonPin, int ledPin, const ConnectionManagerConfig& config) {

      pinMode(buttonPin, INPUT_PULLUP);
      attachInterrupt(digitalPinToInterrupt(buttonPin), std::bind(&ConnectionManager::handleButtonDown, this), FALLING);
      attachInterrupt(digitalPinToInterrupt(buttonPin), std::bind(&ConnectionManager::handleUp, this), RISING);

      this->ledPin = ledPin;
      pinMode(ledPin, OUTPUT);

      WiFi.mode(WIFI_STA);
      WiFi.hostname(config.hostname);

      this->config = config;

      if (WiFi.SSID() != "") {
        DEBUG_MSG("Connecting to ");
        DEBUG_MSG(WiFi.SSID());
        WiFi.begin();
      } else {
        beginSmartConfig();
      }

      //WiFi.scanNetworksAsync(prinScanResult);
    
      configTime(config.tz.c_str(), "pool.ntp.org", "time.nist.gov");
    
      for (int i = 0; i < CA_CERT_COUNT; i++) {
        certificates.append(ca_cert[i]);
      }
    
      client.setTrustAnchors(&certificates);

    }

    void enterConfigMode() {
      DEBUG_MSG("enter config mode");
      if (!configuringWifi) {
        beginSmartConfig();
      } else {
        // TODO: AP config mode
        exitConfigMode();
      }
    }

    bool exitConfigMode() {
      if (configuringWifi) {
        DEBUG_MSG_("exit config mode, reconnect to ");
        DEBUG_MSG(WiFi.SSID());
        WiFi.stopSmartConfig();
        WiFi.begin();
        configuringWifi = false;
        return true;
      }
      return false;
    }

    void beginSmartConfig() {
      DEBUG_MSG("Smartconfig");
      WiFi.beginSmartConfig();
      nextDelayMillis = 200;
      configuringWifi = true;
      hasEverConnected = false;
    }

    void loop() {

      unsigned long currentTimeMillis = millis();

      // "delay"
      if (!mqtt.connected()) {
        if (currentTimeMillis < (lastLoopMillis + nextDelayMillis)) {
          return;
        }
      }  

      lastLoopMillis = currentTimeMillis;
    
      int wifiStatus;

      if (configuringWifi) {
        if(!WiFi.smartConfigDone()) {
          connectingLed = !connectingLed;
          digitalWrite(ledPin, connectingLed ? HIGH : LOW);
          DEBUG_MSG_(".");
          return;
        }
        configuringWifi = false;
        WiFi.stopSmartConfig();
        nextDelayMillis = 500;
      }
    
      if ((wifiStatus = WiFi.status()) != WL_CONNECTED) {
        connectingLed = !connectingLed;
        digitalWrite(ledPin, connectingLed ? HIGH : LOW);
        hasEverConnected = false;
        DEBUG_MSG_("Wifi status: ");
        DEBUG_MSG(wifiStatus);
        return;
      }

      if (!hasEverConnected) {
        hasEverConnected = true;
        DEBUG_MSG("WiFi connected");
        digitalWrite(ledPin, HIGH);
        DEBUG_MSG("IP address: "); 
        DEBUG_MSG(WiFi.localIP());

        if(!MDNS.begin(WiFi.hostname())) {
          DEBUG_MSG("can't init MDNS");
        }

      }
    
      if (!mqtt.connected()) {
        connectingLed = !connectingLed;
        digitalWrite(ledPin, connectingLed ? LOW : HIGH);
        DEBUG_MSG("Attempting MQTT connection...");
        // Attempt to connect
        if (mqtt.connect(config.hostname.c_str(), config.mqttUsername.c_str(), config.mqttPassword.c_str())) {
          DEBUG_MSG("connected");
          digitalWrite(ledPin, HIGH);
          this->onConnect();
        } else {
          DEBUG_MSG("failed, rc=");
          DEBUG_MSG(mqtt.state());
          struct tm timeinfo;
          time_t now = time(nullptr);
          gmtime_r(&now, &timeinfo);
          DEBUG_MSG("Current time: ");
          DEBUG_MSG(asctime(&timeinfo));
        }
      } else {
        MDNS.update();      
      }

    }

    virtual void onConnect() {}

    virtual void onButtonUp() {}

    void handleButtonDown() {
      lastButtonDownMillis = millis();
    }

    void handleButtonUp() {
      DEBUG_MSG("button up");
      if (millis() >= (lastButtonDownMillis + 3000)) {
        enterConfigMode();
      } else {
        if(!exitConfigMode()) {
          // overloader may be interested in a regular button push, for instance to toggle a light
          onButtonUp()
        }
      }
    }

};

/*
  void prinScanResult(int networksFound)
  {
  Serial.printf("%d network(s) found\n", networksFound);
  for (int i = 0; i < networksFound; i++)
  {
    Serial.printf("%d: %s, Ch:%d (%ddBm) (%s) %s\n", i + 1, WiFi.SSID(i).c_str(), WiFi.channel(i), WiFi.RSSI(i), WiFi.BSSIDstr(i).c_str(), WiFi.encryptionType(i) == ENC_TYPE_NONE ? "open" : "");
  }
  }
*/
