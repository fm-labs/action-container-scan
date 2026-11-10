FROM alpine:3.24

# Install necessary packages
RUN apk add --no-cache \
    bash \
    curl \
    && rm -rf /var/cache/apk/*

# Install trivy
RUN curl -sSfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /opt/trivy -d v0.76.2
RUN ln -s /opt/trivy/trivy /usr/local/bin/trivy

ENV TRIVY_CACHE_DIR=/opt/trivy-cache
RUN trivy image --download-db-only \
 && trivy image --download-java-db-only

ENV TRIVY_SKIP_DB_UPDATE=true
ENV TRIVY_SKIP_JAVA_DB_UPDATE=true

RUN mkdir -p /usr/local/bin
COPY script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

ENTRYPOINT ["/usr/local/bin/script.sh"]
