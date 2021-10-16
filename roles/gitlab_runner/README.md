gitlab-runner
=========

Provision a Gitlab Runner on Fedora using Podman.

Tested againt Fedora 33.

[![Build Status](https://travis-ci.org/travis/ansible-role-template.svg?branch=master)](https://travis-ci.org/CyVerse-Ansible/ansible-role-template)
[![Ansible Galaxy](https://img.shields.io/badge/ansible--galaxy-gitlab--runner-blue.svg)](https://galaxy.ansible.com/CyVerse-Ansible/ansible-role-template/)

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

| Variable                | Required | Default | Choices                   | Comments                                 |
|-------------------------|----------|---------|---------------------------|------------------------------------------|
| foo                     | no       | false   | true, false               | example variable                         |
| bar                     | yes      |         | eggs, spam                | example variable                         |

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    ---
    - name: "Deploy the Gitlab Runner using Podman"
      hosts: gitlab-runner-host
      roles:
        - role: gitlab_runner
      vars:
        runner_image: quay.io/
        registry_host: "{{ custom_registry_host }}"
        registry_username: "{{ custom_registry_username }}"
        registry_password: "{{ custom_registry_password }}"
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

License
-------

BSD-3-Clause

Author Information
------------------

See: https://github.com/zedr/ansible-podman-gitlab-runner
