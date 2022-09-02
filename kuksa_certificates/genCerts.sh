#!/bin/sh


genCAKey() {
    openssl genrsa -out CA.key 2048
}


genCACert() {
    openssl req -key CA.key -new -out CA.csr -subj "/C=CA/ST=Ontario/L=Ottawa/O=Eclipse.org Foundation, Inc./CN=localhost-ca/emailAddress=kuksa-dev@eclipse.org"
    openssl x509 -signkey CA.key -in CA.csr -req -days 365 -out CA.pem
}

genKey() {
    openssl genrsa -out $1.key 2048
}

genCert() {
    openssl req -new -key $1.key -out $1.csr -passin pass:"temp" -subj "/C=CA/ST=Ontario/L=Ottawa/O=Eclipse.org Foundation, Inc./CN=$1/emailAddress=kuksa-dev@eclipse.org"
    openssl x509 -req -in $1.csr -CA CA.pem -CAkey CA.key -CAcreateserial -days 365 -out $1.pem
    openssl verify -CAfile CA.pem $1.pem
}

set -xe
# Check if the CA is available, else make CA certificates
if [ -f "CA.key" ]; then
    echo "Existing CA key will be used"
else
    echo "No CA key found"
    genCAKey
    echo ""
fi

genCACert

for i in Server Client;
do
    if [ -f $i.key ]; then
        echo "Existing $1 key will be used"
    else
        echo "No $i key found"
        genKey $i
    fi
    echo ""
    genCert $i
    echo ""
done

