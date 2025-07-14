
Summary of Storage Remediation on pln-aidev01.caal.dev
	•	Identified /var/lib/docker as the main contributor to root filesystem usage (~138 GB).
	•	Provisioned a new 2TB logical volume dockerlv from volume group datavg.
	•	Formatted and mounted dockerlv at /var/lib/docker to offload Docker data from the root filesystem.
	•	Stopped docker and docker.socket services for safe data migration.
	•	Backed up original Docker data to /datamount/docker.bak for rollback, if needed.
	•	Restarted Docker successfully. Containers are now running (adminer, postgres), and system functionality is restored.
	•	Verified /var/lib/docker is now mounted on the new LVM volume with only 8% used.
	•	System disk pressure has been relieved, and no user-facing impact occurred.



# DO180-apps
DO180 Repository for Sample Applications
