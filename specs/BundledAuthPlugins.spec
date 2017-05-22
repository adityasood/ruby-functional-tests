BundledAuthPlugins
=========

BundledAuthPlugins
-------------------
tags: bundled-auth-plugins

Setup of contexts
* AuthPluginsConfiguration - setup
* Using pipeline "basic-pipeline" - setup
* With "1" live agents - setup
* Capture go state "BundledAuthPlugins" - setup

* Start to add a new authorization config with id as "pwd_file" for plugin "Password File Authentication Plugin for GoCD"
* Set password file path as "password_plugin.properties"
* Save authorization config

* Login as "admin"

* Start to add a new authorization config with id as "ldap_auth" for plugin "LDAP Authentication Plugin for GoCD"
* Set LDAP Url
 Set Manager DN as "uid=admin,ou=system"
 Set Password as "secret"
* Set Search Bases as "ou=People,dc=tests,dc=com"
* Set User Login Filter as "(uid={0})"
 Set Display Name Attribute as "uid"
* Save authorization config

* Login as "pass_user1"

* Start to add a GoCD config role "guest"
* Add user "view_user" to the role
* Save role config

* Edit pipeline group "basic"
* Add role "guest" as view user
* Add user "john" as admin user
* Save pipeline group permissions

* Login as "view_user"

* Verify pipeline "basic-pipeline" is not editable

* Login as "pass_user1"
* Verify pipeline "basic-pipeline" is editable


teardown
_______________
* Capture go state "BundledAuthPlugins" - teardown
* With "1" live agents - teardown
