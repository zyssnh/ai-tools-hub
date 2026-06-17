FROM nginx:alpine

# Nginx sub_filter module is included in alpine image by default
# No extra packages needed

COPY nginx.conf /etc/nginx/nginx.conf
COPY landing.html /usr/share/nginx/html/index.html
COPY conf.d/ /etc/nginx/conf.d/

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD nginx -t || exit 1
