#include <ESP8266WiFi.h>

void setup() {
    WiFi.mode(WIFI_STA);
    //WiFi.scanNetworksAsync(prinScanResult);
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

/*
void prinScanResult(int networksFound)
{
  Serial.printf("%d network(s) found\n", networksFound);
  for (int i = 0; i < networksFound; i++) {
    Serial.printf("%d: %s, Ch:%d (%ddBm) (%s) %s\n", i + 1, WiFi.SSID(i).c_str(), WiFi.channel(i), WiFi.RSSI(i), WiFi.BSSIDstr(i).c_str(), WiFi.encryptionType(i) == ENC_TYPE_NONE ? "open" : "");
  }
}
*/
