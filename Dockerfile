# -----------------------------------------------------
# Stage 1 - Build
# -----------------------------------------------------
FROM alpine:3.22 AS builder

WORKDIR /app

COPY index.html elements.html generic.html landing.html LICENSE.txt README.txt ./
COPY assets ./assets
COPY images ./images

# -----------------------------------------------------
# Stage 2 - Runtime
# -----------------------------------------------------
FROM docker pull registry.redhat.io/rhel9/nginx-126:9.8-1782911077

USER root

# Remove the default application
RUN rm -rf /opt/app-root/src/*

# Copy the static website
COPY --from=builder /app/ /opt/app-root/src/

# Ensure the OpenShift random UID can read the files
RUN chgrp -R 0 /opt/app-root/src \
    && chmod -R g=u /opt/app-root/src

USER 1001

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]