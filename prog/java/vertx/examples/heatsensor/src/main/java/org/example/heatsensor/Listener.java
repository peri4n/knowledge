package org.example.heatsensor;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.eventbus.EventBus;
import io.vertx.core.json.JsonObject;

import java.text.DecimalFormat;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Listener extends AbstractVerticle {

  private final Logger logger = LoggerFactory.getLogger(Listener.class);

  private final DecimalFormat format = new DecimalFormat("#.##");

  @Override
  public void start() throws Exception {
    EventBus eventBus = vertx.eventBus();
    eventBus.<JsonObject>consumer("sensor.updates", msg -> {
      JsonObject body = msg.body();
      String id = body.getString("id");
      String temp = format.format(body.getDouble("temp"));

      logger.info("{} reports a temperature ~{}C", id , temp);
    });
  }

}
