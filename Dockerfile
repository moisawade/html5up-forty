# Use official Nginx image as base (for serving static content)
FROM nginx:alpine

# Copy our app files into the default Nginx document root (/usr/share/nginx/html)
COPY index.html /usr/share/nginx/html/
COPY elements.html /usr/share/nginx/html/
COPY generic.html /usr/share/nginx/html/
COPY landing.html /usr/share/nginx/html/
COPY assets /usr/share/nginx/html/assets
COPY images /usr/share/nginx/html/images
COPY LICENSE.txt /usr/share/nginx/html/
COPY README.txt /usr/share/nginx/html/

# Expose port 80 for HTTP access (Nginx listens on port 80 by default)
EXPOSE 80

# Run command when container starts up
CMD ["nginx", "-g", "daemon off;"]