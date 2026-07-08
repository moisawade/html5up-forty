# --------------------------------------------------------------------
# Stage 1 - Build
# --------------------------------------------------------------------
FROM alpine:latest AS builder

WORKDIR /app

COPY index.html elements.html generic.html landing.html LICENSE.txt README.txt ./
COPY assets/ ./assets/
COPY images/ ./images/

# --------------------------------------------------------------------
# Stage 2 - Runtime
# --------------------------------------------------------------------
FROM nginxinc/nginx-unprivileged:stable

# Copy application
COPY --from=builder /app /usr/share/nginx/html


# Create writable directories for OpenShift
RUN mkdir -p \
        /tmp/nginx/client_temp \
        /tmp/nginx/proxy_temp \
        /tmp/nginx/fastcgi_temp \
        /tmp/nginx/uwsgi_temp \
        /tmp/nginx/scgi_temp \
    && chmod -R g=u /tmp \
    && chmod -R g=u /usr/share/nginx/html

# OpenShift injects a random UID belonging to group 0
#USER 101

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]