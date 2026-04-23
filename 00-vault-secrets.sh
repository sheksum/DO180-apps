[root@pln-petipareplica ~]#
[root@pln-petipareplica ~]#
[root@pln-petipareplica ~]# sudo systemctl is-active dirsrv@IPA-CALIX-LOCAL krb5kdc kadmin httpd pki-tomcatd ipa
active
active
active
active
inactive
inactive
[root@pln-petipareplica ~]#
[root@pln-petipareplica ~]#
[root@pln-petipareplica ~]# ipa server-find pln-petipareplica.ipa.calix.local 2>&1
ipa: ERROR: Major (851968): Unspecified GSS failure.  Minor code may provide more information, Minor (2529638926): KDC has no support for encryption type
[root@pln-petipareplica ~]# kinit hsuma
Password for hsuma@IPA.CALIX.LOCAL:
[root@pln-petipareplica ~]#
[root@pln-petipareplica ~]#
[root@pln-petipareplica ~]# ipa server-find pln-petipareplica.ipa.calix.local 2>&1
ipa: ERROR: Major (851968): Unspecified GSS failure.  Minor code may provide more information, Minor (2529638926): KDC has no support for encryption type
[root@pln-petipareplica ~]# sudo tail -30 /var/log/httpd/error_log
[Thu Apr 23 16:48:47.680851 2026] [lbmethod_heartbeat:notice] [pid 194652:tid 140263167752512] AH02282: No slotmem from mod_heartmonitor
[Thu Apr 23 16:48:47.685745 2026] [mpm_event:notice] [pid 194652:tid 140263167752512] AH00489: Apache/2.4.37 (Red Hat Enterprise Linux) OpenSSL/1.1.1k mod_auth_gssapi/1.6.1 mod_wsgi/4.6.4 Python/3.6 configured -- resuming normal operations
[Thu Apr 23 16:48:47.685779 2026] [core:notice] [pid 194652:tid 140263167752512] AH00094: Command line: '/usr/sbin/httpd -D FOREGROUND'
[Thu Apr 23 16:59:09.174855 2026] [mpm_event:notice] [pid 194652:tid 140263167752512] AH00492: caught SIGWINCH, shutting down gracefully
[Thu Apr 23 16:59:16.298325 2026] [core:notice] [pid 197724:tid 140125633620288] SELinux policy enabled; httpd running as context system_u:system_r:httpd_t:s0
[Thu Apr 23 16:59:16.299204 2026] [suexec:notice] [pid 197724:tid 140125633620288] AH01232: suEXEC mechanism enabled (wrapper: /usr/sbin/suexec)
[Thu Apr 23 16:59:16.372634 2026] [lbmethod_heartbeat:notice] [pid 197724:tid 140125633620288] AH02282: No slotmem from mod_heartmonitor
[Thu Apr 23 16:59:16.384628 2026] [mpm_event:notice] [pid 197724:tid 140125633620288] AH00489: Apache/2.4.37 (Red Hat Enterprise Linux) OpenSSL/1.1.1k mod_auth_gssapi/1.6.1 mod_wsgi/4.6.4 Python/3.6 configured -- resuming normal operations
[Thu Apr 23 16:59:16.384675 2026] [core:notice] [pid 197724:tid 140125633620288] AH00094: Command line: '/usr/sbin/httpd -D FOREGROUND'
[Thu Apr 23 17:10:41.166109 2026] [wsgi:error] [pid 197732:tid 140124784682752] [remote 10.172.248.51:36832] ipa: INFO: [jsonserver_i18n_messages] UNKNOWN: i18n_messages(version='2.251'): SUCCESS
[Thu Apr 23 17:10:44.841485 2026] [wsgi:error] [pid 197731:tid 140124784682752] [remote 10.172.248.51:36822] mod_wsgi (pid=197731): Exception occurred processing WSGI script '/usr/share/ipa/wsgi.py'.
[Thu Apr 23 17:10:44.842737 2026] [wsgi:error] [pid 197731:tid 140124784682752] [remote 10.172.248.51:36822] Traceback (most recent call last):
[Thu Apr 23 17:10:44.842794 2026] [wsgi:error] [pid 197731:tid 140124784682752] [remote 10.172.248.51:36822]   File "/usr/lib/python3.6/site-packages/ipaserver/wsgi.py", line 71, in application
[Thu Apr 23 17:10:44.842801 2026] [wsgi:error] [pid 197731:tid 140124784682752] [remote 10.172.248.51:36822]     return api.Backend.wsgi_dispatch(environ, start_response)
[Thu Apr 23 17:10:44.842806 2026] [wsgi:error] [pid 197731:tid 140124784682752] [remote 10.172.248.51:36822]   File "/usr/lib/python3.6/site-packages/ipaserver/rpcserver.py", line 314, in __call__
[Thu Apr 23 17:10:44.842808 2026] [wsgi:error] [pid 197731:tid 140124784682752] [remote 10.172.248.51:36822]     return self.route(environ, start_response)
[Thu Apr 23 17:10:44.842811 2026] [wsgi:error] [pid 197731:tid 140124784682752] [remote 10.172.248.51:36822]   File "/usr/lib/python3.6/site-packages/ipaserver/rpcserver.py", line 326, in route
[Thu Apr 23 17:10:44.842813 2026] [wsgi:error] [pid 197731:tid 140124784682752] [remote 10.172.248.51:36822]     return app(environ, start_response)
[Thu Apr 23 17:10:44.842816 2026] [wsgi:error] [pid 197731:tid 140124784682752] [remote 10.172.248.51:36822]   File "/usr/lib/python3.6/site-packages/ipaserver/rpcserver.py", line 1089, in __call__
[Thu Apr 23 17:10:44.842833 2026] [wsgi:error] [pid 197731:tid 140124784682752] [remote 10.172.248.51:36822]     ipa_ccache_name, use_armor=True)
[Thu Apr 23 17:10:44.842839 2026] [wsgi:error] [pid 197731:tid 140124784682752] [remote 10.172.248.51:36822]   File "/usr/lib/python3.6/site-packages/ipaserver/rpcserver.py", line 1016, in attempt_kinit
[Thu Apr 23 17:10:44.842841 2026] [wsgi:error] [pid 197731:tid 140124784682752] [remote 10.172.248.51:36822]     ipa_ccache_name, use_armor=use_armor)
[Thu Apr 23 17:10:44.842844 2026] [wsgi:error] [pid 197731:tid 140124784682752] [remote 10.172.248.51:36822]   File "/usr/lib/python3.6/site-packages/ipaserver/rpcserver.py", line 1118, in kinit
[Thu Apr 23 17:10:44.842846 2026] [wsgi:error] [pid 197731:tid 140124784682752] [remote 10.172.248.51:36822]     pkinit_anchors=[paths.KDC_CERT, paths.KDC_CA_BUNDLE_PEM],
[Thu Apr 23 17:10:44.842850 2026] [wsgi:error] [pid 197731:tid 140124784682752] [remote 10.172.248.51:36822]   File "/usr/lib/python3.6/site-packages/ipalib/install/kinit.py", line 167, in kinit_armor
[Thu Apr 23 17:10:44.842852 2026] [wsgi:error] [pid 197731:tid 140124784682752] [remote 10.172.248.51:36822]     run(args, env=env, raiseonerr=True, capture_error=True)
[Thu Apr 23 17:10:44.842855 2026] [wsgi:error] [pid 197731:tid 140124784682752] [remote 10.172.248.51:36822]   File "/usr/lib/python3.6/site-packages/ipapython/ipautil.py", line 600, in run
[Thu Apr 23 17:10:44.842857 2026] [wsgi:error] [pid 197731:tid 140124784682752] [remote 10.172.248.51:36822]     p.returncode, arg_string, output_log, error_log
[Thu Apr 23 17:10:44.842879 2026] [wsgi:error] [pid 197731:tid 140124784682752] [remote 10.172.248.51:36822] ipapython.ipautil.CalledProcessError: CalledProcessError(Command ['/usr/bin/kinit', '-n', '-c', '/run/ipa/ccaches/armor_197731', '-X', 'X509_anchors=FILE:/var/kerberos/krb5kdc/kdc.crt', '-X', 'X509_anchors=FILE:/var/lib/ipa-client/pki/kdc-ca-bundle.pem'] returned non-zero exit status 1: "kinit: Pre-authentication failed: Cannot open file '/var/kerberos/krb5kdc/kdc.crt': No such file or directory while getting initial credentials\\n")
[Thu Apr 23 17:12:18.935060 2026] [auth_gssapi:error] [pid 199024:tid 140124752824064] [client 10.172.248.57:44082] Failed to unseal session data!, referer: https://pln-petipareplica.ipa.calix.local/ipa/xml
[root@pln-petipareplica ~]# sudo tail -30 /var/log/krb5kdc.log
Apr 23 17:12:43 pln-petipareplica.ipa.calix.local krb5kdc[197244](info): TGS_REQ (4 etypes {aes256-cts-hmac-sha384-192(20), aes128-cts-hmac-sha256-128(19), aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17)}) 10.174.24.132: ISSUE: authtime 1776964363, etypes {rep=aes256-cts-hmac-sha1-96(18), tkt=aes256-cts-hmac-sha1-96(18), ses=aes256-cts-hmac-sha1-96(18)}, host/sdsmx-rh9-vinv.calix.local@IPA.CALIX.LOCAL for ldap/pln-petipareplica.ipa.calix.local@IPA.CALIX.LOCAL
Apr 23 17:12:43 pln-petipareplica.ipa.calix.local krb5kdc[197244](info): closing down fd 4
Apr 23 17:12:43 pln-petipareplica.ipa.calix.local krb5kdc[197246](info): AS_REQ (6 etypes {aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17), UNSUPPORTED:des3-hmac-sha1(16), DEPRECATED:arcfour-hmac(23), camellia128-cts-cmac(25), camellia256-cts-cmac(26)}) 10.174.8.196: CLIENT_NOT_FOUND: host/sdaxos-smoen02.calix.local@IPA.CALIX.LOCAL for krbtgt/IPA.CALIX.LOCAL@IPA.CALIX.LOCAL, Client not found in Kerberos database
Apr 23 17:12:43 pln-petipareplica.ipa.calix.local krb5kdc[197246](info): closing down fd 4
Apr 23 17:12:44 pln-petipareplica.ipa.calix.local krb5kdc[197244](info): AS_REQ (8 etypes {aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17), aes256-cts-hmac-sha384-192(20), aes128-cts-hmac-sha256-128(19), UNSUPPORTED:des3-hmac-sha1(16), DEPRECATED:arcfour-hmac(23), camellia128-cts-cmac(25), camellia256-cts-cmac(26)}) 10.168.10.145: NEEDED_PREAUTH: host/plnx-gcp-ft248.calix.local@IPA.CALIX.LOCAL for krbtgt/IPA.CALIX.LOCAL@IPA.CALIX.LOCAL, Additional pre-authentication required
Apr 23 17:12:44 pln-petipareplica.ipa.calix.local krb5kdc[197244](info): closing down fd 4
Apr 23 17:12:44 pln-petipareplica.ipa.calix.local krb5kdc[197244](info): AS_REQ (8 etypes {aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17), aes256-cts-hmac-sha384-192(20), aes128-cts-hmac-sha256-128(19), UNSUPPORTED:des3-hmac-sha1(16), DEPRECATED:arcfour-hmac(23), camellia128-cts-cmac(25), camellia256-cts-cmac(26)}) 10.168.10.145: ISSUE: authtime 1776964364, etypes {rep=aes256-cts-hmac-sha1-96(18), tkt=aes256-cts-hmac-sha1-96(18), ses=aes256-cts-hmac-sha1-96(18)}, host/plnx-gcp-ft248.calix.local@IPA.CALIX.LOCAL for krbtgt/IPA.CALIX.LOCAL@IPA.CALIX.LOCAL
Apr 23 17:12:44 pln-petipareplica.ipa.calix.local krb5kdc[197244](info): closing down fd 4
Apr 23 17:12:44 pln-petipareplica.ipa.calix.local krb5kdc[197246](info): TGS_REQ (8 etypes {aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17), aes256-cts-hmac-sha384-192(20), aes128-cts-hmac-sha256-128(19), UNSUPPORTED:des3-hmac-sha1(16), DEPRECATED:arcfour-hmac(23), camellia128-cts-cmac(25), camellia256-cts-cmac(26)}) 10.168.10.145: ISSUE: authtime 1776964364, etypes {rep=aes256-cts-hmac-sha1-96(18), tkt=aes256-cts-hmac-sha1-96(18), ses=aes256-cts-hmac-sha1-96(18)}, host/plnx-gcp-ft248.calix.local@IPA.CALIX.LOCAL for ldap/pln-petipareplica.ipa.calix.local@IPA.CALIX.LOCAL
Apr 23 17:12:44 pln-petipareplica.ipa.calix.local krb5kdc[197246](info): closing down fd 4
Apr 23 17:12:44 pln-petipareplica.ipa.calix.local krb5kdc[197245](info): AS_REQ (6 etypes {aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17), UNSUPPORTED:des3-hmac-sha1(16), DEPRECATED:arcfour-hmac(23), camellia128-cts-cmac(25), camellia256-cts-cmac(26)}) 10.174.8.76: CLIENT_NOT_FOUND: host/sdaxos-bmuthiah.calix.local@IPA.CALIX.LOCAL for krbtgt/IPA.CALIX.LOCAL@IPA.CALIX.LOCAL, Client not found in Kerberos database
Apr 23 17:12:44 pln-petipareplica.ipa.calix.local krb5kdc[197245](info): closing down fd 4
Apr 23 17:12:44 pln-petipareplica.ipa.calix.local krb5kdc[197246](info): AS_REQ (6 etypes {aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17), UNSUPPORTED:des3-hmac-sha1(16), DEPRECATED:arcfour-hmac(23), camellia128-cts-cmac(25), camellia256-cts-cmac(26)}) 10.174.8.76: CLIENT_NOT_FOUND: host/sdaxos-bmuthiah.calix.local@IPA.CALIX.LOCAL for krbtgt/IPA.CALIX.LOCAL@IPA.CALIX.LOCAL, Client not found in Kerberos database
Apr 23 17:12:44 pln-petipareplica.ipa.calix.local krb5kdc[197246](info): closing down fd 4
Apr 23 17:12:45 pln-petipareplica.ipa.calix.local krb5kdc[197245](info): AS_REQ (8 etypes {aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17), aes256-cts-hmac-sha384-192(20), aes128-cts-hmac-sha256-128(19), UNSUPPORTED:des3-hmac-sha1(16), DEPRECATED:arcfour-hmac(23), camellia128-cts-cmac(25), camellia256-cts-cmac(26)}) 10.174.8.84: CLIENT_NOT_FOUND: host/sdaxos-automated.calix.local@IPA.CALIX.LOCAL for krbtgt/IPA.CALIX.LOCAL@IPA.CALIX.LOCAL, Client not found in Kerberos database
Apr 23 17:12:45 pln-petipareplica.ipa.calix.local krb5kdc[197245](info): closing down fd 4
Apr 23 17:12:45 pln-petipareplica.ipa.calix.local krb5kdc[197245](info): AS_REQ (6 etypes {aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17), UNSUPPORTED:des3-hmac-sha1(16), DEPRECATED:arcfour-hmac(23), camellia128-cts-cmac(25), camellia256-cts-cmac(26)}) 10.174.8.94: CLIENT_NOT_FOUND: host/sdaxos-mgao.calix.local@IPA.CALIX.LOCAL for krbtgt/IPA.CALIX.LOCAL@IPA.CALIX.LOCAL, Client not found in Kerberos database
Apr 23 17:12:45 pln-petipareplica.ipa.calix.local krb5kdc[197245](info): closing down fd 4
Apr 23 17:12:45 pln-petipareplica.ipa.calix.local krb5kdc[197246](info): AS_REQ (6 etypes {aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17), UNSUPPORTED:des3-hmac-sha1(16), DEPRECATED:arcfour-hmac(23), camellia128-cts-cmac(25), camellia256-cts-cmac(26)}) 10.174.8.94: CLIENT_NOT_FOUND: host/sdaxos-mgao.calix.local@IPA.CALIX.LOCAL for krbtgt/IPA.CALIX.LOCAL@IPA.CALIX.LOCAL, Client not found in Kerberos database
Apr 23 17:12:45 pln-petipareplica.ipa.calix.local krb5kdc[197246](info): closing down fd 4
Apr 23 17:12:45 pln-petipareplica.ipa.calix.local krb5kdc[197246](info): AS_REQ (6 etypes {aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17), UNSUPPORTED:des3-hmac-sha1(16), DEPRECATED:arcfour-hmac(23), camellia128-cts-cmac(25), camellia256-cts-cmac(26)}) 192.168.97.85: NEEDED_PREAUTH: host/sjc-sonarscan01.calix.local@IPA.CALIX.LOCAL for krbtgt/IPA.CALIX.LOCAL@IPA.CALIX.LOCAL, Additional pre-authentication required
Apr 23 17:12:45 pln-petipareplica.ipa.calix.local krb5kdc[197246](info): closing down fd 4
Apr 23 17:12:45 pln-petipareplica.ipa.calix.local krb5kdc[197245](info): preauth (encrypted_timestamp) verify failure: Preauthentication failed
Apr 23 17:12:45 pln-petipareplica.ipa.calix.local krb5kdc[197245](info): AS_REQ (6 etypes {aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17), UNSUPPORTED:des3-hmac-sha1(16), DEPRECATED:arcfour-hmac(23), camellia128-cts-cmac(25), camellia256-cts-cmac(26)}) 192.168.97.85: PREAUTH_FAILED: host/sjc-sonarscan01.calix.local@IPA.CALIX.LOCAL for krbtgt/IPA.CALIX.LOCAL@IPA.CALIX.LOCAL, Preauthentication failed
Apr 23 17:12:45 pln-petipareplica.ipa.calix.local krb5kdc[197245](info): closing down fd 4
Apr 23 17:12:46 pln-petipareplica.ipa.calix.local krb5kdc[197246](info): AS_REQ (6 etypes {aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17), UNSUPPORTED:des3-hmac-sha1(16), DEPRECATED:arcfour-hmac(23), camellia128-cts-cmac(25), camellia256-cts-cmac(26)}) 192.168.97.85: NEEDED_PREAUTH: host/sjc-sonarscan01.calix.local@IPA.CALIX.LOCAL for krbtgt/IPA.CALIX.LOCAL@IPA.CALIX.LOCAL, Additional pre-authentication required
Apr 23 17:12:46 pln-petipareplica.ipa.calix.local krb5kdc[197246](info): closing down fd 4
Apr 23 17:12:46 pln-petipareplica.ipa.calix.local krb5kdc[197246](info): preauth (encrypted_timestamp) verify failure: Preauthentication failed
Apr 23 17:12:46 pln-petipareplica.ipa.calix.local krb5kdc[197246](info): AS_REQ (6 etypes {aes256-cts-hmac-sha1-96(18), aes128-cts-hmac-sha1-96(17), UNSUPPORTED:des3-hmac-sha1(16), DEPRECATED:arcfour-hmac(23), camellia128-cts-cmac(25), camellia256-cts-cmac(26)}) 192.168.97.85: PREAUTH_FAILED: host/sjc-sonarscan01.calix.local@IPA.CALIX.LOCAL for krbtgt/IPA.CALIX.LOCAL@IPA.CALIX.LOCAL, Preauthentication failed
Apr 23 17:12:46 pln-petipareplica.ipa.calix.local krb5kdc[197246](info): closing down fd 4
[root@pln-petipareplica ~]#
