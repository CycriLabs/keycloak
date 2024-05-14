ARG KEYCLOAK_VERSION=24.0.4
FROM quay.io/keycloak/keycloak:$KEYCLOAK_VERSION AS builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure fixed database vendor
ENV KC_DB=postgres

WORKDIR /opt/keycloak

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:$KEYCLOAK_VERSION
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENV KC_DB=postgres

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
