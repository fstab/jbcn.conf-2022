package de.fstab.demo.otel;

import com.google.auto.service.AutoService;
import io.opentelemetry.sdk.autoconfigure.spi.AutoConfigurationCustomizer;
import io.opentelemetry.sdk.autoconfigure.spi.AutoConfigurationCustomizerProvider;
import io.opentelemetry.sdk.metrics.Aggregation;
import io.opentelemetry.sdk.metrics.InstrumentSelector;
import io.opentelemetry.sdk.metrics.View;

import java.util.Arrays;

@AutoService(AutoConfigurationCustomizerProvider.class)
public class HistogramConfigurer implements AutoConfigurationCustomizerProvider {

    @Override
    public void customize(AutoConfigurationCustomizer autoConfiguration) {
        autoConfiguration.addMeterProviderCustomizer((sdkMeterProviderBuilder, configProperties) -> sdkMeterProviderBuilder.registerView(
                InstrumentSelector.builder()
                        .setName("http.server.duration")
                        .build(),
                View.builder()
                        .setAggregation(Aggregation.explicitBucketHistogram(Arrays.asList(
                                200.0, 400.0, 600.0, 800.0, 900.0, 1000.0, 1200.0, 1400.0, 1600.0, 1800.0, 2000.0)))
                        .build()));
    }
}