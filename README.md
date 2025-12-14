- job_name: "AXOS Build Systems"
  static_configs:
    - targets:
        - 'sdx-axostest01:9100'
        - 'sdx-ciaxos01:9100'
        - 'sdx-ciaxos02:9100'
        - 'sdx-ciaxos08:9100'
        - 'sdx-ciaxos09:9100'
        - 'sdx-ciaxos10:9100'
        - 'sdx-ciaxos11:9100'
        - 'sdx-ciaxos12:9100'
        - 'sdx-ciaxos14:9100'
        - 'sdx-ciaxos15:9100'
        - 'sdx-ciaxos20:9100'
        - 'sdx-ciaxos22:9100'
        - 'sdx-cidailyaxos01:9100'
        - 'sdx-cidailyaxos04:9100'
        - 'sdx-cidailyaxos05:9100'
      labels:
        exporter: node
        role: axos