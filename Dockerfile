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
FROM image-registry.openshift-image-registry.svc:5000/openshift/nginx:latest

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