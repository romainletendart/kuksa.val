# Example Certificates for KUKSA.val

This directory contains example keys and certificates that can be used for testing clients and servers in this repository.
Many of the clients and servers in this repository use keys and certificates from this repository by default.

The certificates are valid for 365 days since the day of generation. If they have expiered new certificates must be generated as described below.

## Generating Keys and Certificates for KUKSA.val

Execute the script
```
> ./genCerts.sh
```

This creates CA.pem, Client.pem, Server.pem valid for 365 days since the day of generation.
If you want to also generate new keys, then delete the keys you want to regenerate before running the script.
This will trigger the script to generate new keys before generating the corresponding certificate.

