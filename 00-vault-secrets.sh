(2026-04-19  0:16:54): [be[ipa.calix.local]] [sbus_issue_request_done] (0x0040): sssd.dataprovider.getAccountInfo: Error [1432158212]: SSSD is offline
(2026-04-19  0:16:54): [be[ipa.calix.local]] [sbus_issue_request_done] (0x0040): sssd.dataprovider.getAccountInfo: Error [1432158212]: SSSD is offline
(2026-04-19  0:16:54): [be[ipa.calix.local]] [sbus_issue_request_done] (0x0040): sssd.dataprovider.getAccountInfo: Error [1432158212]: SSSD is offline
(2026-04-19  0:16:54): [be[ipa.calix.local]] [sbus_issue_request_done] (0x0040): sssd.dataprovider.getAccountInfo: Error [1432158212]: SSSD is offline
(2026-04-19  0:17:25): [be[ipa.calix.local]] [sbus_issue_request_done] (0x0040): sssd.dataprovider.getAccountInfo: Error [1432158212]: SSSD is offline
(2026-04-19  0:17:25): [be[ipa.calix.local]] [sbus_issue_request_done] (0x0040): sssd.dataprovider.getAccountInfo: Error [1432158212]: SSSD is offline
(2026-04-19  0:17:25): [be[ipa.calix.local]] [sbus_issue_request_done] (0x0040): sssd.dataprovider.getAccountInfo: Error [1432158212]: SSSD is offline
(2026-04-19  0:17:25): [be[ipa.calix.local]] [sbus_issue_request_done] (0x0040): sssd.dataprovider.getAccountInfo: Error [1432158212]: SSSD is offline
(2026-04-19  0:17:25): [be[ipa.calix.local]] [sbus_issue_request_done] (0x0040): sssd.dataprovider.getAccountInfo: Error [1432158212]: SSSD is offline
(2026-04-19  0:17:56): [be[ipa.calix.local]] [sbus_issue_request_done] (0x0040): sssd.dataprovider.getAccountInfo: Error [1432158212]: SSSD is offline
(2026-04-19  0:17:56): [be[ipa.calix.local]] [sbus_issue_request_done] (0x0040): sssd.dataprovider.getAccountInfo: Error [1432158212]: SSSD is offline
(2026-04-19  0:17:56): [be[ipa.calix.local]] [sbus_issue_request_done] (0x0040): sssd.dataprovider.getAccountInfo: Error [1432158212]: SSSD is offline
(2026-04-19  0:17:56): [be[ipa.calix.local]] [sbus_issue_request_done] (0x0040): sssd.dataprovider.getAccountInfo: Error [1432158212]: SSSD is offline
(2026-04-19  0:17:57): [be[ipa.calix.local]] [sbus_issue_request_done] (0x0040): sssd.dataprovider.getAccountInfo: Error [1432158212]: SSSD is offline
(2026-04-19  1:01:43): [be[ipa.calix.local]] [generic_ext_search_handler] (0x0020): [RID#12288] sdap_get_generic_ext_recv failed: [110]: Connection timed out [ldap_search_timeout]
********************** PREVIOUS MESSAGE WAS TRIGGERED BY THE FOLLOWING BACKTRACE:
   *  (2026-04-19  0:56:25): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#12277] Requesting attrs: [entryUSN]
   *  (2026-04-19  0:56:25): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#12277] Requesting attrs: [shadowLastChange]
   *  (2026-04-19  0:56:25): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#12277] Requesting attrs: [shadowMin]
   *  (2026-04-19  0:56:25): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#12277] Requesting attrs: [shadowMax]
   *  (2026-04-19  0:56:25): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#12277] Requesting attrs: [shadowWarning]
   *  (2026-04-19  0:56:25): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#12277] Requesting attrs: [shadowInactive]
   *  (2026-04-19  0:56:25): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#12277] Requesting attrs: [shadowExpire]
   *  (2026-04-19  0:56:25): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#12277] Requesting attrs: [shadowFlag]
   *  (2026-04-19  0:56:25): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#12277] Requesting attrs: [krbLastPwdChange]
   *  (2026-04-19  0:56:25): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#12277] Requesting attrs: [krbPasswordExpiration]
   *  (2026-04-19  0:56:25): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#12277] Requesting attrs: [pwdAttribute]
   *  (2026-04-19  0:56:25): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#12277] Requesting attrs: [authorizedService]
   *  (2026-04-19  0:56:25): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#12277] Requesting attrs: [accountExpires]
   *  (2026-04-19  0:56:25): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#12277] Requesting attrs: [userAccountControl]
   *  (2026-04-19  0:56:25): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#12277] Requesting attrs: [nsAccountLock]
   *  (2026-04-19  0:56:25): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#12277] Requesting attrs: [host]
...skipping...
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_parse_range] (0x2000): [RID#297] No sub-attributes for [ipaMigrationEnabled]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_parse_range] (0x2000): [RID#297] No sub-attributes for [ipaSELinuxUserMapDefault]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_parse_range] (0x2000): [RID#297] No sub-attributes for [ipaSELinuxUserMapOrder]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_process_result] (0x2000): Trace: sh[0x555c15fbe060], connected[1], ops[0x555c15fdbeb0], ldap[0x555c15f8bbf0]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_process_message] (0x4000): [RID#297] Message type: [LDAP_RES_SEARCH_RESULT]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_get_generic_op_finished] (0x0400): [RID#297] Search result: Success(0), no errmsg set
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_op_destructor] (0x2000): [RID#297] Operation 163 finished
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [ipa_selinux_get_maps_next] (0x0400): [RID#297] Trying to fetch SELinux maps with following parameters: [2][(&(objectclass=ipaselinuxusermap)(ipaEnabledFlag=TRUE))][cn=selinux,dc=ipa,dc=calix,dc=local]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_print_server] (0x2000): [RID#297] Searching 172.23.49.10:389
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x0400): [RID#297] calling ldap_search_ext with [(&(objectclass=ipaselinuxusermap)(ipaEnabledFlag=TRUE))][cn=selinux,dc=ipa,dc=calix,dc=local].
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#297] Requesting attrs: [objectClass]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#297] Requesting attrs: [cn]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#297] Requesting attrs: [memberUser]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#297] Requesting attrs: [memberHost]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#297] Requesting attrs: [seeAlso]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#297] Requesting attrs: [ipaSELinuxUser]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#297] Requesting attrs: [ipaEnabledFlag]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#297] Requesting attrs: [userCategory]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#297] Requesting attrs: [hostCategory]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x1000): [RID#297] Requesting attrs: [ipaUniqueID]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_get_generic_ext_step] (0x2000): [RID#297] ldap_search_ext called, msgid = 165
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_op_add] (0x2000): [RID#297] New operation 165 timeout 60
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_process_result] (0x2000): Trace: sh[0x555c15fbe060], connected[1], ops[0x555c1600d430], ldap[0x555c15f8bbf0]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_process_result] (0x2000): Trace: end of ldap_result list
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_process_result] (0x2000): Trace: sh[0x555c15fbe060], connected[1], ops[0x555c1600d430], ldap[0x555c15f8bbf0]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_process_message] (0x4000): [RID#295] Message type: [LDAP_RES_SEARCH_RESULT]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_get_generic_op_finished] (0x0400): [RID#295] Search result: Success(0), no errmsg set
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_get_generic_op_finished] (0x2000): [RID#295] Total count [0]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_op_destructor] (0x2000): [RID#295] Operation 164 finished
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [ipa_selinux_get_maps_done] (0x0400): [RID#295] No SELinux user maps found!
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_id_op_destroy] (0x4000): [RID#295] releasing operation connection
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sysdb_merge_res_ts_attrs] (0x2000): [RID#295] TS cache doesn't handle this DN type, skipping
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sysdb_delete_recursive_with_filter] (0x4000): [RID#295] Found [1] items to delete.
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sysdb_delete_recursive_with_filter] (0x4000): [RID#295] Trying to delete [cn=selinux,cn=ipa.calix.local,cn=sysdb].
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sysdb_entry_attrs_diff] (0x0400): [RID#295] Entry [cn=selinux,cn=ipa.calix.local,cn=sysdb] differs, reason: ts_cache doesn't trace this type of entry.
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sysdb_set_entry_attr] (0x0200): [RID#295] Entry [cn=selinux,cn=ipa.calix.local,cn=sysdb] has set [cache] attrs.
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [selinux_child_create_buffer] (0x4000): [RID#295] buffer size: 43
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [child_handler_setup] (0x2000): [RID#295] Setting up signal handler up for pid [3501250]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [child_handler_setup] (0x2000): [RID#295] Signal handler set up for pid [3501250]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_process_result] (0x2000): Trace: sh[0x555c15fbe060], connected[1], ops[0x555c1600d430], ldap[0x555c15f8bbf0]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_process_result] (0x2000): Trace: end of ldap_result list
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [write_pipe_handler] (0x0400): [RID#295] All data has been sent!
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_process_result] (0x2000): Trace: sh[0x555c15fbe060], connected[1], ops[0x555c1600d430], ldap[0x555c15f8bbf0]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_process_message] (0x4000): [RID#297] Message type: [LDAP_RES_SEARCH_RESULT]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_get_generic_op_finished] (0x0400): [RID#297] Search result: Success(0), no errmsg set
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_get_generic_op_finished] (0x2000): [RID#297] Total count [0]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_op_destructor] (0x2000): [RID#297] Operation 165 finished
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [ipa_selinux_get_maps_done] (0x0400): [RID#297] No SELinux user maps found!
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sdap_id_op_destroy] (0x4000): [RID#297] releasing operation connection
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sysdb_merge_res_ts_attrs] (0x2000): [RID#297] TS cache doesn't handle this DN type, skipping
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sysdb_delete_recursive_with_filter] (0x4000): [RID#297] Found [1] items to delete.
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sysdb_delete_recursive_with_filter] (0x4000): [RID#297] Trying to delete [cn=selinux,cn=ipa.calix.local,cn=sysdb].
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sysdb_entry_attrs_diff] (0x0400): [RID#297] Entry [cn=selinux,cn=ipa.calix.local,cn=sysdb] differs, reason: ts_cache doesn't trace this type of entry.
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [sysdb_set_entry_attr] (0x0200): [RID#297] Entry [cn=selinux,cn=ipa.calix.local,cn=sysdb] has set [cache] attrs.
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [selinux_child_create_buffer] (0x4000): [RID#297] buffer size: 43
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [child_handler_setup] (0x2000): [RID#297] Setting up signal handler up for pid [3501251]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [child_handler_setup] (0x2000): [RID#297] Signal handler set up for pid [3501251]
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [child_sig_handler] (0x1000): [RID#297] Waiting for child [3501251].
   *  (2026-04-23 12:15:09): [be[ipa.calix.local]] [child_sig_handler] (0x0020): [RID#297] waitpid did not found a child with changed status.
********************** BACKTRACE DUMP ENDS HERE *********************************

(END)Apr 23 17:12:44 pln-petipareplica.ipa.calix.local krb5kdc[197245](info): closing down fd 4
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
