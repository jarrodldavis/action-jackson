#!/usr/bin/env sh

wp core install \
    --url="localhost:8000" --title="Another WordPress Site" \
    --admin_user=admin --admin_password=password \
    --admin_email=admin@example.com --skip-email
