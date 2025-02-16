FROM nginx:latest

RUN apt-get update && apt-get install -y apache2-utils && rm -rf /var/lib/apt/lists/*

ARG SHELL_ADMIN_USER
ARG SHELL_ADMIN_PASS

RUN echo "${SHELL_ADMIN_USER}:$(htpasswd -nbB ${SHELL_ADMIN_USER} ${SHELL_ADMIN_PASS} | cut -d ":" -f2)" > /etc/nginx/.htpasswd

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
