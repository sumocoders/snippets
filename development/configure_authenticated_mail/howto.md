# Configure authenticated mail

If your provider blocks port 25 you won't be able to send mails through `mail()`.

## Mac OSX

### Configure postfix to use an external mail-server

* `mate /etc/postfix/main.cf`
* add the code below

	relayhost = mail.crsolutions.be:2525
	smtp_sasl_auth_enable = yes
	smtp_use_tls = yes
	smtp_enforce_tls = yes
	smtp_sasl_security_options =
	smtp_sasl_tls_security_options =
	smtp_sasl_tls_verified_security_options =
	smtp_sasl_password_maps = hash:/etc/postfix/smtp_sasl_passwords
	smtp_tls_per_site = hash:/etc/postfix/smtp_tls_sites
	tls_random_source = dev:/dev/urandom

* `mate /etc/postfix/smtp_sasl_passwords`
* add the content below

	mail.crsolutions.be email@ddress:password
	
* `mate /etc/postfix/smtp_tls_sites`
* add the content below

	mail.crsolutions.be MUST_NOPEERMATCH`
	
* `cd /etc/postfix`
* `chmod go-rx smtp_sasl_passwords`
* `postmap smtp_sasl_passwords`
* `postmap smtp_tls_sites`