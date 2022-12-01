choco install tailscale -y
tailscale up --authkey tskey-auth-kmYWEs4CNTRL-E58dqRPnpjitN4wH1JYshiDnogxNZCqR --unattended
tailscale up --advertise-routes=192.168.3.0/24
