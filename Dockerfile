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
#FROM registry.redhat.io/rhel9/nginx-126:9.8-1782911077
FROM nginxinc/nginx-unprivileged:stable

# Copy the static website
COPY --from=builder /app/ /usr/share/nginx/html/

EXPOSE 8080

#CMD ["nginx", "-g", "daemon off;"]