import board
import busio
import adafruit_blinka.microcontroller.mcp2221.mcp2221 as mcp

mcp.DEFAULT_I2C_BUS_SPEED = 10000
i2c = busio.I2C(board.SCL, board.SDA)
address = 0x77
register = 0xD0

print("🔍 Checking for MCP2221A and BME280 at address 0x77...")

try:
    while not i2c.try_lock():
        pass
    result = bytearray(1)
    i2c.writeto_then_readfrom(address, bytes([register]), result)

    if result[0] == 0x60:
        print("✅ BME280 detected and functioning (chip ID = 0x60)")
    else:
        print(f"⚠️ Unexpected chip ID: 0x{result[0]:02X}")
except Exception as e:
    print("❌ Error communicating with BME280:", e)
finally:
    i2c.unlock()
