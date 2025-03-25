# BME280 Sensor to Redis Publisher

Reads from a BME280 sensor via MCP2221A USB-to-I²C and publishes values to Redis.

## Requirements
- Raspberry Pi
- MCP2221A USB I²C bridge
- BME280 sensor (connected to MCP2221A)
- Redis accessible at localhost:6379

## Setup

```bash
chmod +x setup.sh
./setup.sh
```

## Run the Sensor Script

```bash
source ~/bme280-env/bin/activate
python3 bme280_to_redis.py
```

## Run the Diagnostic Script

```bash
source ~/bme280-env/bin/activate
python3 check_sensor.py
```

## Redis Keys Created

- `bme280:temperature`
- `bme280:humidity`
- `bme280:pressure`
