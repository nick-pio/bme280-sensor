#!/bin/bash
echo "📦 Setting up BME280 virtual environment..."
python3 -m venv ~/bme280-env
source ~/bme280-env/bin/activate
echo "⬇️ Installing Python packages..."
pip install --upgrade pip
pip install -r requirements.txt
echo "✅ Setup complete. To run the script:"
echo "source ~/bme280-env/bin/activate && python3 bme280_to_redis.py"
