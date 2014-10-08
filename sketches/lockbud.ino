#define LOCK_PIN 6

long openTime = 0.0f;
long openDuration = 4000;
char incomingByte = 0;
char password = 'o';

void setup() {
  Serial.begin(9600);
  Serial.println(F("Arduino: Starting Lockbud Server"));

  pinMode(LOCK_PIN, OUTPUT);
  resetLock();
}

void loop() {
  if (Serial.available() > 0) {
    incomingByte = Serial.read();
    Serial.println(incomingByte);
    if (incomingByte == password) {
      openLock();
    }
  }

  if (openTime && (millis() - openTime > openDuration)) {
    resetLock();
  }
}

void openLock() {
  if (openTime > 0.0f) {
    Serial.println(F("Arduino: Lock is already open."));
    return;
  }

  Serial.println(F("Arduino: Opening lock"));

  openTime = millis();
  digitalWrite(LOCK_PIN, HIGH);
}

void resetLock() {
  Serial.println(F("Arduino: Resetting lock"));
  digitalWrite(LOCK_PIN, LOW);
  openTime = 0.0f;
}
