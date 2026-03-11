# Load Balancer

This directory contains scripts and configurations for setting up a load balancer.

## Scripts

### 0. Double the number of webservers
`0-custom_http_response_header`
Configure Nginx on the web servers so that its HTTP response contains a custom header:
- The name of the custom HTTP header is `X-Served-By`
- The value of the custom HTTP header is the hostname of the server Nginx is running on

### 1. Install your load balancer
`1-install_load_balancer`
Install and configure HAProxy on lb-01 server:
- Distributes traffic to `web-01` and `web-02`
- Distributes requests using a roundrobin algorithm
- HAProxy can be managed via an init script
