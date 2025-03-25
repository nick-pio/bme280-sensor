import time
import redis
import board
import busio
from adafruit_bme280.basic import Adafruit_BME280_I2C
import adafruit_blinka.microcontroller.mcp2221.mcp2221 as mcp

mcp.DEFAULT_I2C_BUS_SPEED = 10000
r = redis.Redis(host="localhost", port=6379, db=0)
i2c = busio.I2C(board.SCL, board.SDA)
bme280 = Adafruit_BME280_I2C(i2c, address=0x77)
bme280.sea_level_pressure = 1013.25

print("Publishing BME280 readings to Redis...")

while True:
    try:
        temperature = round(bme280.temperature, 2)
        humidity = round(bme280.humidity, 2)
        pressure = round(bme280.pressure, 2)

        r.set("bme280:temperature", temperature)
        r.set("bme280:humidity", humidity)
        r.set("bme280:pressure", pressure)

        print(f"T: {temperature} °C | H: {humidity} % | P: {pressure} hPa")
    except Exception as e:
        print("⚠️ Sensor read failed, will retry:", e)
    time.sleep(5)
