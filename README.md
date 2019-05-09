Client Certificate Authentication Demo
========

This project shows how to configure Apache HTTP Server (httpd) to enable client certificate authentication.

To run the demo :

    skaffold run --tail

Check [this](https://skaffold.dev/docs/getting-started/) for more explanation on Skaffold.

Features
--------

- Public location accessible at /public with instructions to download and install the client certificate
- Private location accessible at /private to test the client certificate
- Index page shows all mod_ssl environment variables and their value
- A HTTP Header is set (or unset) with the current user CN if authenticated correctly (Authenticated-User-Name)
- Certificates are auto-generated at docker build phase (they will change each time the application is built)

Without skaffold
----------------

Build and run the demo :

    docker build -t client-certificate-authentication-demo .
    docker run -p 443:443 client-certificate-authentication-demo

Then test it with your favorite browser : https://localhost

Contribute
----------

- Issue Tracker: github.com/adrienaury/client-certificate-example/issues
- Source Code: github.com/adrienaury/client-certificate-example/

Support
-------

If you are having issues, please let me know.
You can contact me: adrienaury@gmail.com

License
-------

The project is licensed under the MIT license.