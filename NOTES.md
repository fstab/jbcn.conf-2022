JBCNConf Notes
--------------

## Slides

[https://docs.google.com/presentation/d/10jsDLSbON0sJEmLcfq3DxCvE_t4WCVNEFR7mGZJ6Vss/edit#slide=id.p](https://docs.google.com/presentation/d/10jsDLSbON0sJEmLcfq3DxCvE_t4WCVNEFR7mGZJ6Vss/edit#slide=id.p)

## Deployment Modes

* Tempo deployment modes: monolithic, scalable monolithic, microservices.
* Mimir deployment modes: monolithic, microservices.

## Running the Demo

```
./run-application.sh
./run-agent.sh
./run-mimir.sh
./run-tempo.sh
./run-loki.sh
./run-grafana.sh
while true ; do curl http://localhost:8081 ; done
```

Test if the application exposes metrics with exemplars:

```
curl -H 'Accept: application/openmetrics-text; version=1.0.0; charset=utf-8' http://localhost:9464
```

## Configure Grafana

* Login: `admin` / `admin`.
* Tempo data source
  * URL: [http://localhost:3200](http://localhost:3200)
  * Derived fields:
    * Name: `TraceID`
    * Regex: `traceID=(\w+)`
    * Query: `${__value.raw}`
    * Internal link to Tempo
* Prometheus data source
  * URL: [http://localhost:9009/prometheus](http://localhost:9009/prometheus)
  * Exemplars:
    * enable
    * internal link
    * data source: Tempo
    * label name: `trace_id`.
* Loki data source
  * URL: [http://localhost:3100](http://localhost:3100)
* RED dashboard
  * request rate
    * Visualization: Time series
    * Title: _Request Rate_
    * Query: `sum(rate(http_server_duration_count{http_route="/"}[5m]))`
    * Unit: throughput / requests per second
  * error rate:
    * Visualization: Time series
    * Title: _Error Rate_
    * Query:  `sum(rate(http_server_duration_count{http_route="/", http_status_code="500"}[5m])) / sum(rate(http_server_duration_count{http_route="/"}[5m]))`
    * Unit: misc / percent (0..1)
  * duration: `histogram_quantile(0.95, sum by (le) (rate(http_server_duration_bucket[5m])))`
  * enable exemplars
  * visualized as time series

## New: Docker Demo

* Datasource
* Request rate: `sum(rate(http_server_requests_count{job="hello-world-app"}[5m]))`
* Error rate: `sum(rate(http_server_requests_count{job="hello-world-app", status="500"}[5m])) / sum(rate(http_server_requests_count{job="hello-world-app"}[5m])`
* Duration (Histogram):
  * Visualization: Bar Gauge
  * Query: `sum by (le) (rate(http_server_duration_bucket{job="hello-world-app"}[5m]))`
  * Format: Headmap
  * Legend: `{{le}}
  * Unit: requests / second
  * Min: 0
  * Max: 3000
* Duration (Quantiles):
  * `histogram_quantile(0.5, sum by (le) (rate(http_server_duration_bucket{job="hello-world-app"}[5m])))`
  * `histogram_quantile(0.95, sum by (le) (rate(http_server_duration_bucket{job="hello-world-app"}[5m])))`

## Firefox

* Install add-on [Modify Header Value (HTTP Headers)](https://addons.mozilla.org/en-US/firefox/addon/modify-header-value/) and configure `Accept: application/openmetrics-text; version=1.0.0; charset=utf-8` for [http://localhost:9464](http://localhost:9464) and [http://localhost:9465](http://localhost:9465).
* Right-click a download of metrics, and configure "always open similar files in firefox" (see also settings -> General -> applications)
* Go to [about:config](about:config) and set `plain_text.wrap_long_lines: false`.

## Once More

* Metrics -> RED
* Traces -> Search, list of spans ; add exemplars, navigate from there
* Logs

## Call with Mario

* Metric generator (in the agent, or in tempo, tempo is recommended)
* service graph (enable in tempo)
* traces to logs -> traces to logs in the tempo data source config
* Trace to Logs (in Tempo data source):
  * Data source: Loki
  * Tags (map tag names): service.name = app

## LogQL

```
rate({app="hello-world-app"}  |= "threw exception"[5m])
```
