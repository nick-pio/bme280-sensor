#!/bin/bash

sudo apt-get update
sudo apt-get install -y python3-venv
sudo apt-get install -y redis-tools

echo "📦 Setting up BME280 virtual environment..."

python3 -m venv ~/bme280-env
source ~/bme280-env/bin/activate

echo "⬇️ Installing Python packages..."
pip install --upgrade pip
pip install -r requirements.txt

echo "✅ Virtual environment setup complete."

# Get the current user
USER_NAME=$(whoami)
echo "👤 Current user detected: $USER_NAME"

# Create systemd service file
SERVICE_FILE="/etc/systemd/system/bme280-sensor.service"
echo "🛠 Creating systemd service at $SERVICE_FILE..."

sudo bash -c "cat > $SERVICE_FILE" <<EOF
[Unit]
Description=BME280 Sensor to Redis Publisher
After=network.target

[Service]
Environment=BLINKA_MCP2221=1
ExecStart=/bin/bash -c 'source /home/$USER_NAME/bme280-env/bin/activate && python3 /home/$USER_NAME/bme280-sensor/bme280_to_redis.py'
WorkingDirectory=/home/$USER_NAME/bme280-sensor
Restart=always
User=$USER_NAME

[Install]
WantedBy=multi-user.target
EOF

echo "🔄 Reloading systemd and enabling service..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable bme280-sensor.service

echo "✅ Setup complete! The sensor service will start on next boot, or you can start it now:"
echo "   sudo systemctl start bme280-sensor.service"
echo
echo "📋 To check status: sudo systemctl status bme280-sensor.service"
echo "📄 To view logs:    journalctl -u bme280-sensor.service -f"

