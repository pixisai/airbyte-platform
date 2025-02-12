/*
 * Copyright (c) 2020-2025 Airbyte, Inc., all rights reserved.
 */

package io.airbyte.workers.internal;

import java.io.BufferedWriter;

/**
 * Factory that provides the default writer.
 */
public class DefaultAirbyteMessageBufferedWriterFactory implements AirbyteMessageBufferedWriterFactory {

  @Override
  public AirbyteMessageBufferedWriter createWriter(BufferedWriter writer) {
    return new DefaultAirbyteMessageBufferedWriter(writer);
  }

}
