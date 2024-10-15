# Cardano Node Setup

This repository contains the configuration files and instructions for setting up and running a Cardano relay node using Docker.

## Prerequisites

- Docker and Docker Compose installed on your system
- Basic understanding of Docker and Cardano network
- Sufficient disk space (minimum 50GB recommended)
- Stable internet connection

## Files in this Repository

- `config.yaml`: Configuration file for the Cardano node
- `topology.json`: P2P network topology configuration
- `docker-compose.yml`: Docker Compose file for running the Cardano node, Prometheus, and Grafana
- `prometheus.yml`: Configuration file for Prometheus
- `dashboard.json`: Grafana dashboard configuration for monitoring the Cardano node

## Setup Instructions

1. Clone this repository to your local machine.

2. Download the genesis files from [Cardano Documentation](https://book.world.dev.cardano.org/env-mainnet.html) and place them in the same directory as the other configuration files:
   - `byron-genesis.json`
   - `shelley-genesis.json`
   - `alonzo-genesis.json`
   - `conway-genesis.json`

3. Set up environment variables:
   Create a `.env` file in the same directory with the following content:
   ```
   DATA_DIR=/path/to/cardano/data
   IPC_DIR=/path/to/cardano/ipc
   PORT=3001
   GRAFANA_ADMIN_PASSWORD=your_secure_password
   ```
   Replace the paths and password with your desired values.

4. Start the Cardano node and monitoring stack:
   ```
   docker-compose up -d
   ```

5. Monitor the node's logs:
   ```
   docker-compose logs -f cardano-node
   ```

6. Access Grafana at `http://localhost:3000` and log in with:
   - Username: admin
   - Password: [The password you set in the .env file]

7. Import the dashboard in Grafana using the provided `dashboard.json` file.

## Configuration Details

### Cardano Node (`config.yaml`)
- Running in P2P mode with peer sharing enabled
- Prometheus metrics exposed on port 12798
- Logging and tracing configurations set for optimal monitoring

### Network Topology (`topology.json`)
- Configured with bootstrap peers for the Cardano mainnet
- P2P settings for local and public roots

### Docker Compose (`docker-compose.yml`)
- Cardano Node: Running the official Cardano node image
- Prometheus: For collecting and storing metrics
- Grafana: For visualizing node metrics and performance

### Prometheus (`prometheus.yml`)
- Configured to scrape metrics from the Cardano node every 15 seconds

### Grafana Dashboard (`dashboard.json`)
- Pre-configured dashboard for monitoring key Cardano node metrics
- Includes panels for block height, sync progress, transaction processing, and more

## Maintenance and Monitoring

- Regularly check the Grafana dashboard for node performance and health
- Keep an eye on disk usage as the blockchain grows
- Periodically update the Cardano node image and configurations as new versions are released

## Troubleshooting

- If the node fails to start, check the logs using `docker-compose logs cardano-node`
- Ensure all required ports are open and not blocked by firewalls
- Verify that the genesis files are correctly placed and referenced in the configuration

## Security Considerations

- Do not expose the Cardano node ports to the public internet unless necessary
- Regularly update all components (Cardano node, Prometheus, Grafana) to their latest versions
- Use strong passwords for Grafana and restrict access to the monitoring interfaces

## Additional Resources

- [Cardano Documentation](https://docs.cardano.org/)
- [IOHK GitHub Repository](https://github.com/input-output-hk/cardano-node)

For any issues or improvements, please open an issue in this repository.