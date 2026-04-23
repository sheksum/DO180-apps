 landscape-api.service - LSB: Enable Landscape API
     Loaded: loaded (/etc/init.d/landscape-api; generated)
     Active: active (running) since Mon 2026-04-13 05:24:24 UTC; 1 week 3 days ago
       Docs: man:systemd-sysv-generator(8)
      Tasks: 24 (limit: 86745)
     Memory: 522.6M (peak: 623.7M)
        CPU: 2min 45.186s
     CGroup: /system.slice/landscape-api.service
             ├─   3022 python3 /opt/canonical/landscape/api --rundir=/opt/canonical/landscape --pidfile=/var/run/landscape/landscape-api-1.pid
             ├─1618032 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             ├─1618054 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             ├─1618082 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             ├─1618105 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             ├─1619316 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             ├─1619426 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             ├─1619666 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             ├─1620051 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             ├─1620073 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             ├─1620198 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             ├─1620220 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             ├─1620846 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             └─1620868 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon

Apr 23 21:51:27 pln-landscape01.caal.dev api-1[3022]:   File \"/usr/lib/python3/dist-packages/storm/database.py\", line 542, in _check_disconnect
Apr 23 21:51:27 pln-landscape01.caal.dev api-1[3022]:     raise DisconnectionError(str(exc))
Apr 23 21:51:27 pln-landscape01.caal.dev api-1[3022]: storm.exceptions.DisconnectionError: SSL connection has been closed unexpectedly
Apr 23 21:51:27 pln-landscape01.caal.dev api-1[3022]:
Apr 23 21:51:27 pln-landscape01.caal.dev api-1[3022]: \"127.0.0.1\" - - [23/Apr/2026:21:51:26 +0000] \"GET /api/v2/activities?action=MissingAction&access_key_id=Unknown HTTP/1.1\" >
Apr 23 21:51:29 pln-landscape01.caal.dev api-1[3022]: Unhandled Error\nTraceback (most recent call last):\n  File \"/usr/lib/python3/dist-packages/twisted/application/app.py\", lin>
Apr 23 21:51:46 pln-landscape01.caal.dev api-1[3022]: \"127.0.0.1\" - - [23/Apr/2026:21:51:45 +0000] \"GET /api/v2/activities?action=MissingAction&access_key_id=Unknown HTTP/1.1\" >
Apr 23 21:51:49 pln-landscape01.caal.dev api-1[3022]: \"127.0.0.1\" - - [23/Apr/2026:21:51:48 +0000] \"GET /api/v2/activities?action=MissingAction&access_key_id=Unknown HTTP/1.1\" >
Apr 23 21:51:50 pln-landscape01.caal.dev api-1[3022]: \"127.0.0.1\" - - [23/Apr/2026:21:51:50 +0000] \"GET /api/v2/activities/78807?action=MissingAction&access_key_id=Unknown HTTP/>
Apr 23 21:54:34 pln-landscape01.caal.dev api-1[3022]: \"127.0.0.1\" - - [23/Apr/2026:21:54:33 +0000] \"GET /api/v2/activities?action=MissingAction&access_key_id=Unknown HTTP/1.1\" >
== landscape-package-upload ==
● landscape-package-upload.service - LSB: Enable Landscape Package Upload service
     Loaded: loaded (/etc/init.d/landscape-package-upload; generated)
     Active: active (running) since Mon 2026-04-13 05:24:15 UTC; 1 week 3 days ago
       Docs: man:systemd-sysv-generator(8)
      Tasks: 2 (limit: 86745)
     Memory: 115.4M (peak: 120.3M)
        CPU: 1min 51.676s
     CGroup: /system.slice/landscape-package-upload.service
             └─2762 python3 /opt/canonical/landscape/package-upload --rundir=/opt/canonical/landscape --pidfile=/var/run/landscape/landscape-package-upload-1.pid

Notice: journal has been rotated since unit was started, output may be incomplete.
== landscape-package-search ==
● landscape-package-search.service - Landscape's Package Search daemon
     Loaded: loaded (/usr/lib/systemd/system/landscape-package-search.service; enabled; preset: enabled)
     Active: active (running) since Mon 2026-04-13 05:24:12 UTC; 1 week 3 days ago
   Main PID: 2475 (packagesearch)
      Tasks: 20 (limit: 86745)
     Memory: 2.2G (peak: 3.2G)
        CPU: 23min 19.878s
     CGroup: /system.slice/landscape-package-search.service
             └─2475 /opt/canonical/landscape/go/bin/packagesearch -config /etc/landscape/service.conf

Apr 23 17:52:02 pln-landscape01.caal.dev package-search[2475]: package-search 2026/04/23 17:52:02 [::1]:60960 - /UpdateUsns 200: succeeded (took 676.633µs)
Apr 23 18:12:53 pln-landscape01.caal.dev package-search[2475]: package-search 2026/04/23 18:12:53 [::1]:55564 - /UpdateComputerPackages 200: succeeded (took 88.041µs)
Apr 23 18:14:08 pln-landscape01.caal.dev package-search[2475]: package-search 2026/04/23 18:14:08 [::1]:58052 - /UpdateComputerPackages 200: succeeded (took 945.488µs)
Apr 23 18:47:07 pln-landscape01.caal.dev package-search[2475]: package-search 2026/04/23 18:47:07 [::1]:46800 - /UpdateUsns 200: succeeded (took 639.239µs)
Apr 23 19:42:25 pln-landscape01.caal.dev package-search[2475]: package-search 2026/04/23 19:42:25 [::1]:51568 - /UpdateUsns 200: succeeded (took 1.08052ms)
Apr 23 20:19:34 pln-landscape01.caal.dev package-search[2475]: package-search 2026/04/23 20:19:34 [::1]:36020 - /UpdateComputerPackages 200: succeeded (took 74.971µs)
Apr 23 20:55:46 pln-landscape01.caal.dev package-search[2475]: package-search 2026/04/23 20:55:46 [::1]:46338 - /UpdateUsns 200: succeeded (took 972.127µs)
Apr 23 21:46:11 pln-landscape01.caal.dev package-search[2475]: package-search 2026/04/23 21:46:11 [::1]:40194 - /Search 200: succeeded (took 59.184004ms)
Apr 23 21:46:31 pln-landscape01.caal.dev package-search[2475]: package-search 2026/04/23 21:46:31 [::1]:57380 - /Search 200: succeeded (took 61.424312ms)
Apr 23 21:54:35 pln-landscape01.caal.dev package-search[2475]: package-search 2026/04/23 21:54:35 [::1]:34474 - /UpdateUsns 200: succeeded (took 707.112µs)
== landscape-hostagent-messenger ==
● landscape-hostagent-messenger.service - Landscape's WSL Message Service
     Loaded: loaded (/usr/lib/systemd/system/landscape-hostagent-messenger.service; enabled; preset: enabled)
     Active: active (running) since Mon 2026-04-13 05:24:08 UTC; 1 week 3 days ago
   Main PID: 2156 (python3)
      Tasks: 18 (limit: 86745)
     Memory: 58.7M (peak: 59.0M)
        CPU: 3min 55.533s
     CGroup: /system.slice/landscape-hostagent-messenger.service
             └─2156 python3 /opt/canonical/landscape/landscape-hostagent-messenger

Notice: journal has been rotated since unit was started, output may be incomplete.
== landscape-hostagent-consumer ==
● landscape-hostagent-consumer.service - Landscape's WSL Message Consumer
     Loaded: loaded (/usr/lib/systemd/system/landscape-hostagent-consumer.service; enabled; preset: enabled)
     Active: active (running) since Mon 2026-04-13 05:24:22 UTC; 1 week 3 days ago
   Main PID: 2948 (python3)
      Tasks: 2 (limit: 86745)
     Memory: 112.5M (peak: 113.0M)
        CPU: 15.748s
     CGroup: /system.slice/landscape-hostagent-consumer.service
             └─2948 python3 /opt/canonical/landscape/landscape-hostagent-consumer

Notice: journal has been rotated since unit was started, output may be incomplete.
== landscape-secrets-service ==
● landscape-secrets-service.service - Landscape's Secrets Management Service
     Loaded: loaded (/usr/lib/systemd/system/landscape-secrets-service.service; enabled; preset: enabled)
     Active: active (running) since Mon 2026-04-13 05:24:06 UTC; 1 week 3 days ago
   Main PID: 1223 (python3)
      Tasks: 1 (limit: 86745)
     Memory: 124.3M (peak: 124.4M)
        CPU: 1min 49.776s
     CGroup: /system.slice/landscape-secrets-service.service
             └─1223 python3 /opt/canonical/landscape/landscape-secrets-service

Notice: journal has been rotated since unit was started, output may be incomplete.
root@pln-landscape01:~# qq
 
 
 
 landscape-job-handler.service - LSB: Enable Landscape job handler
     Loaded: loaded (/etc/init.d/landscape-job-handler; generated)
     Active: active (running) since Mon 2026-04-13 05:24:22 UTC; 1 week 3 days ago
       Docs: man:systemd-sysv-generator(8)
      Tasks: 14 (limit: 86745)
     Memory: 1.1G (peak: 1.1G)
        CPU: 22.951s
     CGroup: /system.slice/landscape-job-handler.service
             ├─   2960 python3 /opt/canonical/landscape/job-handler --rundir=/opt/canonical/landscape --pidfile=/var/run/landscape/landscape-job-handler-1.pid
             ├─ 169528 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             ├─ 169573 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             ├─ 169869 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             ├─ 169908 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             ├─ 169932 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             ├─ 169991 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             ├─ 170036 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             ├─ 170069 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             ├─1619716 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             ├─1620121 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon
             └─1620176 gpg-agent --homedir /var/lib/landscape/landscape-repository/standalone/.gnupg --use-standard-socket --daemon

Apr 23 21:43:00 pln-landscape01.caal.dev job-handler-1[2960]: Ignoring failure while removing /var/lib/landscape/landscape-repository/standalone/.gnupg/.nfs00000000c834630a00000044>
Apr 23 21:43:00 pln-landscape01.caal.dev job-handler-1[2960]: Ignoring failure while removing /var/lib/landscape/landscape-repository/standalone/.gnupg/.nfs00000000c834631a00000045>
Apr 23 21:43:00 pln-landscape01.caal.dev job-handler-1[2960]: Ignoring failure while removing /var/lib/landscape/landscape-repository/standalone/.gnupg/.nfs00000000c834634000000046>
Apr 23 21:43:00 pln-landscape01.caal.dev job-handler-1[2960]: Ignoring failure while removing /var/lib/landscape/landscape-repository/standalone/.gnupg/.nfs00000000c834634c00000047>
Apr 23 21:43:00 pln-landscape01.caal.dev job-handler-1[2960]: Ignoring failure while removing /var/lib/landscape/landscape-repository/standalone/.gnupg/.nfs00000000c834634d00000048>
Apr 23 21:43:01 pln-landscape01.caal.dev job-handler-1[2960]: Finished job None/sync-mirror-pocket/None {'account_id': 1, 'person_id': 2, 'pocket_id': 39, 'activity_id': 78807}
Apr 23 21:51:33 pln-landscape01.caal.dev job-handler-1[2960]: Starting job None/activity-update-parent/landscape.account.1.activity.59400 {'account_id': 1, 'activity_id': 59400}
Apr 23 21:51:33 pln-landscape01.caal.dev job-handler-1[2960]: Finished job None/activity-update-parent/landscape.account.1.activity.59400 {'account_id': 1, 'activity_id': 59400}
Apr 23 21:51:59 pln-landscape01.caal.dev job-handler-1[2960]: Starting job None/activity-update-parent/landscape.account.1.activity.62101 {'account_id': 1, 'activity_id': 62101}
Apr 23 21:51:59 pln-landscape01.caal.dev job-handler-1[2960]: Finished job None/activity-update-parent/landscape.account.1.activity.62101 {'account_id': 1, 'activity_id': 62101}
lines 1-31/31 (END)
