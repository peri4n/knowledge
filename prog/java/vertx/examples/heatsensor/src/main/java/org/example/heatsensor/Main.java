package org.example.heatsensor;

import io.vertx.core.DeploymentOptions;
import io.vertx.core.Vertx;

public class Main {
  public static void main(String[] args) {
    Vertx vertx = Vertx.vertx(); 

    vertx.deployVerticle("org.example.heatsensor.HeatSensor", new DeploymentOptions().setInstances(4));
    vertx.deployVerticle("org.example.heatsensor.Listener");
    vertx.deployVerticle("org.example.heatsensor.SensorData");
    vertx.deployVerticle("org.example.heatsensor.HttpServer");

  }
}
