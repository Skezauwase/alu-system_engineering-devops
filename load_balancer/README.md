# Load Balancer

This directory contains scripts and configurations for setting up a load balancer.

## Scripts

### 0. Double the number of webservers
`0-custom_http_response_header`
Configure Nginx on the web servers so that its HTTP response contains a custom header:
- The name of the custom HTTP header is `X-Served-By`
- The value of the custom HTTP header is the hostname of the server Nginx is running on
