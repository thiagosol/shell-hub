FROM shellhubio/server:latest

ARG SHELLHUB_MONGO_URI
ARG ADMIN_USER
ARG ADMIN_EMAIL
ARG ADMIN_PASS

ENV SHELLHUB_MONGO_URI=${SHELLHUB_MONGO_URI}
ENV ADMIN_USER=${ADMIN_USER}
ENV ADMIN_EMAIL=${ADMIN_EMAIL}
ENV ADMIN_PASS=${ADMIN_PASS}

COPY init_admin.sh /init_admin.sh
RUN chmod +x /init_admin.sh

ENTRYPOINT ["/bin/sh", "-c", "/init_admin.sh && /usr/bin/server"]
