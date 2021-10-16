gitlab-runner
=========

Provision a Gitlab Runner on Fedora using Podman.

Requirements
------------

See `requirements.txt` and `requirements.yml`.

Role Variables
--------------

- `config_toml`: Optional - the body of the `config.toml` file.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - gitlab_runner:
             config_toml: |
               [[runners]]
                 name = "shell"
                 url = "https://CI/"
                 token = "TOKEN"
                 limit = 2
                 executor = "shell"
                 builds_dir = ""
                 shell = "bash"

License
-------

BSD-3-Clause

Author Information
------------------

See: https://github.com/zedr/ansible-podman-gitlab-runner
