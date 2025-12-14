- name: Install Prometheus node_exporter
  hosts: node_exporter_targets
  become: yes

  tasks:
    - name: Create node_exporter user
      user:
        name: node_exporter
        shell: /usr/sbin/nologin
        create_home: no

    - name: Create install directory
      file:
        path: /opt/node_exporter
        state: directory
        owner: node_exporter
        group: node_exporter
        mode: '0755'

    - name: Copy node_exporter binary
      copy:
        src: files/node_exporter
        dest: /opt/node_exporter/node_exporter
        owner: node_exporter
        group: node_exporter
        mode: '0755'

    - name: Install systemd unit
      copy:
        src: files/node_exporter.service
        dest: /etc/systemd/system/node_exporter.service
        mode: '0644'

    - name: Reload systemd
      command: systemctl daemon-reexec

    - name: Enable and start node_exporter
      systemd:
        name: node_exporter
        enabled: yes
        state: started

    - name: Validate metrics endpoint
      uri:
        url: http://localhost:9100/metrics
        status_code: 200