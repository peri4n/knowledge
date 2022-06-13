import org.gradle.api.tasks.testing.logging.TestLogEvent.*

plugins {
  java
  application
}

group = "org.example"
version = "1.0.0-SNAPSHOT"

repositories {
  mavenCentral()
}

val vertxVersion = "4.3.1"
val junitJupiterVersion = "5.7.0"
val logbackVersion = "1.2.11"
val slf4jVersion = "1.7.36"

dependencies {
  implementation("io.vertx:vertx-core:$vertxVersion")
  implementation("org.slf4j:slf4j-api:$slf4jVersion")
  implementation("ch.qos.logback:logback-classic:$logbackVersion")
  testImplementation("io.vertx:vertx-junit5")
  testImplementation("org.junit.jupiter:junit-jupiter:$junitJupiterVersion")
}

java {
  sourceCompatibility = JavaVersion.VERSION_11
  targetCompatibility = JavaVersion.VERSION_11
}

tasks.withType<Test> {
  useJUnitPlatform()
  testLogging {
    events = setOf(PASSED, SKIPPED, FAILED)
  }
}

application {
  mainClass.set("org.example.heatsensor.Main")
}
