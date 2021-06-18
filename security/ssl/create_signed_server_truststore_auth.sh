cp server_truststore.p12 server_truststoreAuth.p12

# Import the client certificate into the server truststore if client authentication is required
keytool -importcert -alias client1 -keystore server_truststoreAuth.p12 -file client1.cer -storepass ServerTrustsecret -noprompt
keytool -importcert -alias client2 -keystore server_truststoreAuth.p12 -file client2.cer -storepass ServerTrustsecret -noprompt
