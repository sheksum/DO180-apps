---
# cleanup-80proxy.yml
- hosts: all
  remote_user: deploy
  become: yes
  gather_facts: no

  tasks:
    - name: Remove 80Proxy file if it exists
      file:
        path: /etc/apt/apt.conf.d/80Proxy
        state: absent

    - name: Restart landscape-client service
      service:
        name: landscape-client
        state: restarted