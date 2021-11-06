gitlab-runner
=========

Provision a Gitlab Runner on Fedora using Podman.

[![Ansible Galaxy](https://img.shields.io/badge/ansible--galaxy-gitlab--runner-blue.svg)](https://galaxy.ansible.com/zedr/gitlab_runner)

Requirements
------------

 - Fedora (tested with 33)

Role Variables
--------------

| Variable                | Required | Default | Choices                   | Comments                                 |
|-------------------------|----------|---------|---------------------------|------------------------------------------|
| custom_registry_host | no | "docker.io" | | The FQDN host of a custom container registry, e.g. quay.io . |
| custom_runner_image  | no | "docker.io/gitlab/gitlab-runner:latest" | | The name of a custom container image, e.g. quay.io/myrepo/gitlab-runner:latest . |
| custom_registry_password | no | | | The password used to sign in to the registry. |
| custom_registry_username | no | | | The username used to sign in to the registry. |
| config_toml | no | | | The content of the `config.toml` file to use for the Runner. |

Dependencies
------------

 - containers.podman

Example Playbook
----------------

An example with a custom image, registry, credentials, and Gitlab Runner TOML
configuration file:

    ---
    - name: "Deploy the Gitlab Runner using Podman"
      hosts: gitlab-runner-host
      roles:
        - role: gitlab_runner
      vars:
        runner_image: "quay.io/rdiscala/gitlab-runner:latest"
        registry_host: "quay.io"
        registry_username: "MY_USERNAME"
        registry_password: "MY_PASSWORD"
        config_toml: |
          concurrent = 1
          check_interval = 0

          [session_server]
          session_timeout = 1800

          [[runners]]
          name = "gitlan-runnner-podman"
          url = "https://some.gitlab.example.com/"
          token = "dr00ls"
          executor = "docker"
          [runners.custom_build_dir]
          [runners.cache]
          [runners.cache.s3]
          [runners.cache.gcs]
          [runners.cache.azure]
          [runners.docker]
          tls_verify = false
          image = "quay.io/redhat-cop/ubi8-git:v1.0"
          privileged = false
          disable_entrypoint_overwrite = false
          oom_kill_disable = false
          disable_cache = false
          volumes = ["/cache"]
          shm_size = 0
          extra_hosts=["some.ldap:127.0.0.1"]

To-do
-----

* Support authfiles.

License
-------

BSD-3-Clause

Author Information
------------------

Rigel Di Scala <zedr@zedr.com>

https://github.com/zedr/ansible-podman-gitlab-runner
