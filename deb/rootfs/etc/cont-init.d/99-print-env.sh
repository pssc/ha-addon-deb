#!/usr/bin/with-contenv bashio
# Keep environment diagnostics useful while redacting credential values.
env | sed -E '/^[^=]*(TOKEN|PASSWORD|PASS|SECRET|API_KEY|ACCESS_KEY|PRIVATE_KEY|CREDENTIAL|AUTH)[^=]*=/I s/=.*/=[REDACTED]/'
