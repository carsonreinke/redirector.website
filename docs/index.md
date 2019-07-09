# Free HTTP/HTTPS Redirection Service

A free redirection/forwarding of one domain to another over both HTTP and HTTPS.

## How Do I Use It?

If your domain is `example.com` and you want it to redirect to `example.org`, simply add the following two DNS records:

```
example.com A 45.55.123.140
_redirect.example.com TXT "uri=http://example.org"
```

## Is HTTPS Supported?

Yes, it is, thanks to Let's Encrypt!

It may take hours or days.  If it does not work yet, make sure to request it over HTTP first.

## Will It Go To Any Page?

Yes, `/path` will redirect `/path` and `/?utm_source=news4&utm_medium=email&utm_campaign=spring-summer` will redirect to `/?utm_source=news4&utm_medium=email&utm_campaign=spring-summer`.

It will not redirect HTTP to HTTP and HTTPS to HTTPS, only what is configured in the DNS record will be used.

## Similar

* [CloudFlare](https://support.cloudflare.com/hc/en-us/articles/200172286-Configuring-URL-forwarding-or-redirects-with-Cloudflare-Page-Rules)
* [GoDaddy](https://www.godaddy.com/help/forward-my-domain-12123)
* http://redirect.center/ 
* http://redirect.name/

## Additional Information

This project was created to gain some insight into using Ansible, GitHub pages, custom Nginx modules, C unit testing, DNS mocking, and other various tooling.  A Nginx module [redirector](https://github.com/carsonreinke/redirector) has been created to enable this project. 