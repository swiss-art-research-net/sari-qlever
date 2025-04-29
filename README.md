# SARI QLever

This repository contains a Docker Compose setup for running the [QLever](https://github.com/ad-freiburg/qlever) backend and its UI. It is designed to automatically index Turtle files.

## Setup

1. Clone the repository:
   ```bash
   git clone git@github.com:swiss-art-research-net/sari-qlever.git
   cd sari-qlever
   ```

2. Copy the example environment file and configure it:
   ```bash
   cp .env.example .env
   ```

3. Update `.env` with your desired configuration

4. Start the services using Docker Compose:
   ```bash
   docker-compose up
   ```

## Usage

- Place your Turtle files in the `data/` directory.
- Start the services using Docker Compose.
- Upon first run, the QLever backend will automatically index the Turtle files in the data folder mount. Inspect the logs to ensure the indexing process completes successfully.
- When the indexing is complete, a status file will be created in the `status/` directory. 
- To trigger a re-indexing, remove the status file and restart the services.


## License

This project is licensed under the MIT License.
