FROM ubuntu:20.04

# Install bash (already included in Ubuntu, but ensuring it's available)
RUN apt-get update && apt-get install -y bash && rm -rf /var/lib/apt/lists/*

# Create the custom script that the action will execute
# This simulates the custom binary mentioned in the requirements
RUN mkdir -p /usr/local/bin
COPY script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]