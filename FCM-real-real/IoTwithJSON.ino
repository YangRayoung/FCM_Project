#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <time.h>
#include <ArduinoJson.h>

//nodeMCU 핀 설정
#define TRIGGER 5
#define ECHO    4

//json을 위한 설정
StaticJsonDocument<200> doc;
DeserializationError error;
JsonObject root;

const char *ssid = "6105";  // 와이파이 이름
const char *pass = "61056105"; // 와이파이 비밀번호
const char *thingId = "***";
//const char *thingId = "***"; // 사물 이름 (thing ID) mac address로 자동 생성
const char *host = "a27weg9qdajurj-ats.iot.ap-northeast-2.amazonaws.com"; // AWS IoT Core 주소
const char* outTopic = "waste/c"; 
const char* inTopic = "inTopic"; 

String sChipID; // mac address를 문자로 기기를 구분하는 기호로 사용
char cChipID[40];


// 사물 인증서 (파일 이름: xxxxxxxxxx-certificate.pem.crt)
const char cert_str[] PROGMEM = R"EOF(
-----BEGIN CERTIFICATE-----
MIIDWTCCAkGgAwIBAgIURHxDqqTk6JjmCzmryHpm3vAvtOUwDQYJKoZIhvcNAQEL
BQAwTTFLMEkGA1UECwxCQW1hem9uIFdlYiBTZXJ2aWNlcyBPPUFtYXpvbi5jb20g
SW5jLiBMPVNlYXR0bGUgU1Q9V2FzaGluZ3RvbiBDPVVTMB4XDTIwMDYwOTEyMjcz
M1oXDTQ5MTIzMTIzNTk1OVowHjEcMBoGA1UEAwwTQVdTIElvVCBDZXJ0aWZpY2F0
ZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOyl/qE2hXe4afq9twdE
XwFce8BBgK5z6YWOJ7lBwtc4BXJ2Az0aljpKr344qJd6tW9N7gRr00ZGspU6pb/p
C23UdwdNNuNJ5jWjP8pvFnSNAErzZqmrSLGTQt02H5Iymvm9liWuefhxnPmyrHvQ
4KE0Vu2ag8XMusIBb+5inW+4DLqZF0QaoP4YqxDl7gG9FkIISjUAlD2Mea+Bm652
l8zZlhzy+9pZUCU9r6USDB15m1e0gl1xopwG0sjkQSUXageSsN5oZudUsPJ2JnIU
cR6R3sKaa6hOhjKD0UlYYkkJEW5OBdSqfvlEc1vZC9zu1nAOCQapGUrdxOIyqQMX
DQMCAwEAAaNgMF4wHwYDVR0jBBgwFoAUMcCTkNEQ7NXJjrCbkWAf5bwNfWcwHQYD
VR0OBBYEFK9hrWp08kKpPvx/VThhTw506IwSMAwGA1UdEwEB/wQCMAAwDgYDVR0P
AQH/BAQDAgeAMA0GCSqGSIb3DQEBCwUAA4IBAQA4EU7Y+a+ep9ZLfLT3q45afI2c
mmWJGt5tHU3Xf7D/o+fpGrSewmPWvNMjOw33hHol3gYGaaAyVFePHgSPLZvdjeN0
V49LDVU70NHmXSXeGKfRqeqMraYi6t4mzTQOPXG9s0ve7jTsgZhvJfVk3Jj/Cao0
M442X4/vkZ1yncP0lZ089G2beenJtlR9Js4rhuUzOq7R3SLbxMwIlPSQDiAVrWqH
5KW1sswod/h9ivRinHmgxJh5ngWpAWZToOUkZTBhQA5gEA9O3XkkuZyh2PXkYJyp
f94tXf3ufzA8bEkOM1o/VtsHMqfJLHukV5mwbD+pucA46Ma4VO84cZY5iCbL
-----END CERTIFICATE-----
)EOF";
// 사물 인증서 프라이빗 키 (파일 이름: xxxxxxxxxx-private.pem.key)
const char key_str[] PROGMEM = R"EOF(
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEA7KX+oTaFd7hp+r23B0RfAVx7wEGArnPphY4nuUHC1zgFcnYD
PRqWOkqvfjiol3q1b03uBGvTRkaylTqlv+kLbdR3B00240nmNaM/ym8WdI0ASvNm
qatIsZNC3TYfkjKa+b2WJa55+HGc+bKse9DgoTRW7ZqDxcy6wgFv7mKdb7gMupkX
RBqg/hirEOXuAb0WQghKNQCUPYx5r4GbrnaXzNmWHPL72llQJT2vpRIMHXmbV7SC
XXGinAbSyORBJRdqB5Kw3mhm51Sw8nYmchRxHpHewpprqE6GMoPRSVhiSQkRbk4F
1Kp++URzW9kL3O7WcA4JBqkZSt3E4jKpAxcNAwIDAQABAoIBACIqnSa9bmuojnSL
K3+7GVRi++L4EhId3htQOOAAZJcaGX87FqCd1A66dbftijnEl6loQPMWdjxxPJtb
Ck844FONF1pQhZovMzOPTEh33XAaY25u0eWxOx+YOVEi3VAISmPAQYtTM3zxOk66
wzhlIelkWyCW7GuEcXpNJtHuHvjf/KwFdElvNyUFS3nEU0HuCm8bABu7z13iAV+u
xn9wyWWKCrtQFEbeq9SOC+pjeFrfNCmMav/w1sDxkVjFI0CvKd0+y1J0MJ5AI5UN
MpPiLtQ6NnMpfi7lvSg+9iBtbu7IGOhufut6h1bi5cTRRfNOtpagTSKG2XPe1g6v
QnWXkVECgYEA/W7b+HjUfbLdaadjSNLUP3AUU4062e5oh03v5NIwPvZxgQ+JJpTY
fFtOEwIr7QwlMqgLnkuJGG3DFPLeAdjIH7nHdZpxilU+tAxEiocVF1f+/bhz02KN
nNg0aX1uAhV0+YcZFu0Y/M6AqEfEjehnTc3xzIi9sc5oejGULO086DUCgYEA7wud
FAB6jlHEXB1F55/3flE8314hF381SFFwpcFmoPV7SMzWOpiXpK3NLzY0x2X4t3Oi
fa6QiURHd6UKace539srJ8Bu58J+spKETQx4wcQqJ9WAi5mS6mGcqog7/iVtd2Uj
vlA7/ZxInlYRR1dfYtPQfLMOoZUETz+LkacV91cCgYEA+pRFPO1DtLFIyPFvco66
u6q2/lGy8c4PXlEKNCY6+9YyLhjNU+9yCatBi/vmsLAEi4yqSC6JdDT64ViteAf+
/5dyBu7Y+p0ErYM/tfSQPw+LmRRquYRFXuJLGE6jmb3bdelFPmzZ+wS3IywqxOEY
W06YmNJPNWJP3RnuV2mOgk0CgYEA7SYPYn2LGFAkRuI/rKe1h9qeUlb263Gm8aTh
5X92Cm8fLL0SNzWVE6ndKl5ThBI06gLNDHS3LYbQg/D24LRlQaEUMi6lmEULHqte
l3WtA0ZSMAyOp2/nIaFPJJtdMSf+bnmnOTIuIc7++B4YrDcRCWFrr5qQBFtq2BgJ
pakmkKcCgYAH1R6dpaj+OoYNh/CrVJk68RCczkv+ES25xWouK9FKrwp+gnC5+Kpz
VB/MP9X9nrdP1HJAboW0rY/Coiy5OJ3CufIl+LoG1qzJVNBAKrIGlCUjeYqqr5gX
EDk73TYUcBks4O/J9NtvLPBo/4RByHSsCBLKDHRlmJqlZ+8Wuw8jTA==
-----END RSA PRIVATE KEY-----
)EOF";

// Amazon Trust Services(ATS) 엔드포인트 CA 인증서 (서버인증 > "RSA 2048비트 키: Amazon Root CA 1" 다운로드)
const char ca_str[] PROGMEM = R"EOF(
-----BEGIN CERTIFICATE-----
MIIDQTCCAimgAwIBAgITBmyfz5m/jAo54vB4ikPmljZbyjANBgkqhkiG9w0BAQsF
ADA5MQswCQYDVQQGEwJVUzEPMA0GA1UEChMGQW1hem9uMRkwFwYDVQQDExBBbWF6
b24gUm9vdCBDQSAxMB4XDTE1MDUyNjAwMDAwMFoXDTM4MDExNzAwMDAwMFowOTEL
MAkGA1UEBhMCVVMxDzANBgNVBAoTBkFtYXpvbjEZMBcGA1UEAxMQQW1hem9uIFJv
b3QgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALJ4gHHKeNXj
ca9HgFB0fW7Y14h29Jlo91ghYPl0hAEvrAIthtOgQ3pOsqTQNroBvo3bSMgHFzZM
9O6II8c+6zf1tRn4SWiw3te5djgdYZ6k/oI2peVKVuRF4fn9tBb6dNqcmzU5L/qw
IFAGbHrQgLKm+a/sRxmPUDgH3KKHOVj4utWp+UhnMJbulHheb4mjUcAwhmahRWa6
VOujw5H5SNz/0egwLX0tdHA114gk957EWW67c4cX8jJGKLhD+rcdqsq08p8kDi1L
93FcXmn/6pUCyziKrlA4b9v7LWIbxcceVOF34GfID5yHI9Y/QCB/IIDEgEw+OyQm
jgSubJrIqg0CAwEAAaNCMEAwDwYDVR0TAQH/BAUwAwEB/zAOBgNVHQ8BAf8EBAMC
AYYwHQYDVR0OBBYEFIQYzIU07LwMlJQuCFmcx7IQTgoIMA0GCSqGSIb3DQEBCwUA
A4IBAQCY8jdaQZChGsV2USggNiMOruYou6r4lK5IpDB/G/wkjUu0yKGX9rbxenDI
U5PMCCjjmCXPI6T53iHTfIUJrU6adTrCC2qJeHZERxhlbI1Bjjt/msv0tadQ1wUs
N+gDS63pYaACbvXy8MWy7Vu33PqUXHeeE6V/Uq2V8viTO96LXFvKWlJbYK8U90vv
o/ufQJVtMVT8QtPHRh8jrdkPSHCa2XV4cdFyQzR1bldZwgJcJmApzyMZFo6IQ6XU
5MsI+yMRQ+hDKXJioaldXgjUkK642M4UwtBV8ob2xJNDd2ZhwLnoQdeXeGADbkpy
rqXRfboQnoZsG4q5WTP468SQvvG5
-----END CERTIFICATE-----
)EOF";

void callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");
  for (int i = 0; i < length; i++) {
    Serial.print((char)payload[i]);
  }
  Serial.println();

  deserializeJson(doc,payload);
  root = doc.as<JsonObject>();
  int value = root["on"];
  Serial.println(value);
}

X509List ca(ca_str);
X509List cert(cert_str);
PrivateKey key(key_str);
WiFiClientSecure wifiClient;
PubSubClient client(host, 8883, callback, wifiClient); //set  MQTT port number to 8883 as per //standard

void reconnect() {
  // Loop until we're reconnected
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection..");
    // Attempt to connect
    if (client.connect(thingId)) {
      Serial.println("connected");
      // Once connected, publish an announcement...
      client.publish(outTopic, "hello world");
      // ... and resubscribe
      client.subscribe(inTopic);
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");

      char buf[256];
      wifiClient.getLastSSLError(buf,256);
      Serial.print("WiFiClientSecure SSL error: ");
      Serial.println(buf);

      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
}

// Set time via NTP, as required for x.509 validation
void setClock() {
  configTime(3 * 3600, 0, "pool.ntp.org", "time.nist.gov");

  Serial.print("Waiting for NTP time sync: ");
  time_t now = time(nullptr);
  while (now < 8 * 3600 * 2) {
    delay(500);
    Serial.print(".");
    now = time(nullptr);
  }
  Serial.println("");
  struct tm timeinfo;
  gmtime_r(&now, &timeinfo);
  Serial.print("Current time: ");
  Serial.print(asctime(&timeinfo));
}

void setup() {
  Serial.begin(115200);
  Serial.setDebugOutput(true);
  Serial.println();
  Serial.println();

  Serial.begin (9600);
  pinMode(TRIGGER, OUTPUT);
  pinMode(ECHO, INPUT);
  pinMode(BUILTIN_LED, OUTPUT);

  //이름 자동으로 생성
  uint8_t chipid[6]="";
  WiFi.macAddress(chipid);
  sprintf(cChipID,"%02x%02x%02x%02x%02x%02x%c",chipid[5], chipid[4], chipid[3], chipid[2], chipid[1], chipid[0],0);
  sChipID=String(cChipID);
  thingId=cChipID;

  // We start by connecting to a WiFi network
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, pass);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");

  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());

  wifiClient.setTrustAnchors(&ca);
  wifiClient.setClientRSACert(&cert, &key);
  Serial.println("Certifications and key are set");

  setClock();
  //client.setServer(host, 8883);
  client.setCallback(callback);
}

long lastMsg = 0;
char msg[50];
int value = 0;
int volume;

int sonar_sensor(){
  
  float duration, distance;
  int percentage;
  digitalWrite(TRIGGER, LOW);  
  delayMicroseconds(2); 
  
  digitalWrite(TRIGGER, HIGH);
  delayMicroseconds(10); 
  digitalWrite(TRIGGER, LOW);
  
  duration = pulseIn(ECHO, HIGH);
  distance = (duration/2) / 29.1;
  percentage = (48 - distance)* 100 / 48;

  Serial.print(duration);
  Serial.print("/ Centimeter:");
  Serial.print(distance);
  Serial.print(" / ");
  Serial.print("Percentage:");
  Serial.print(percentage);
  Serial.println();

  return percentage;

}

void makeJson(int j_volume, int j_location) { //함수로 받아온 데이터값을 Json으로 변환 시킵니다.

  StaticJsonDocument<200> doc;
  doc["remain"] = j_volume;
  doc["wastebin"] = j_location;
  
  Serial.print("Json data : ");
  serializeJson(doc, Serial);
  //doc.printTo(Serial);
  Serial.println();
  //doc.printTo(msg); //json으로 변환한 데이터를 char msg[] 변수에 넣어줍니다.
  serializeJsonPretty(doc, msg);
}


void loop() {
  if (!client.connected()) {
    reconnect();
  }
  client.loop();

  long now = millis();
  if (now - lastMsg > 5000) {
    lastMsg = now;
    volume = sonar_sensor();
    int waste_bin = 3;
    makeJson(volume,waste_bin);
    
    //snprintf (msg, 75, "%d #%d", volume, value);
    Serial.print("Publish message: ");
    Serial.println(msg);
    client.publish(outTopic, msg);
    Serial.print("Heap: "); 
    Serial.println(ESP.getFreeHeap()); //Low heap can cause problems
    Serial.println();
  }
}
