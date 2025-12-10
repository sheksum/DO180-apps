“Quick update on the orchestration evaluation effort — I’ve completed the first part, which was understanding what we need for both RHEL and Oracle Linux. I’ve mapped out our requirements around patching, baseline configuration, RBAC, GitLab integration, network access, and credential handling.

I’ve also confirmed that all of these needs can be supported by an Ansible-based controller, and that AWX is a strong candidate since it handles both RHEL and Oracle Linux cleanly with the right execution environments.

Next step is to look at AWX alongside a couple of open-source alternatives like Semaphore and Rundeck, compare them feature-by-feature, and then recommend the best fit. Once that’s done, I’ll put together a high-level architecture draft for the selected tool.”