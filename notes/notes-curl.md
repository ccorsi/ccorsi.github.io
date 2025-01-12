---
title: Curl
author: Claudio Corsi
tags: [ curl ]
permalink: /notes/curl/
debug: true
sidebar: notes-curl
---

This page contains notes pertaining to the curl command that come up once in a while when using this command.


**How do I get around the CRYPT_E_NO_REVOCATION_CHECK error when using curl with https?**

There are times when you are using the following curl command using https.

```sh
$ curl -L https://wwww.google.com -o response

curl: (35) schannel: next InitializeSecurityContext failed: CRYPT_E_NO_REVOCATION_CHECK (0x80092012) - The revocation function was
 unable to check revocation for the certificate.
```

The above issue is concerned with not having a proper certificate and the way to get around this issue is by
including the *--ssl-no-revoke* option to curl.  Thus, the updated command will look like the following.

```sh
$ curl --ssl-no-revoke -L https://wwww.google.com -o response
```

The above command will not generate the certificate revoke error that was seen in the first command example.


