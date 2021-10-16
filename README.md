# Gitlab Runner Playbook
A playbook for installing and running a Gitlab Runner instance using Podman
without root privileges.

Supports Fedora 33.

## Molecule test dependencies
OS:
 - libvirt-devel

## Test with Quay.io and local image

Use:
```bash
$ FEDORA_IMAGE_URL=file:///home/myuser/Fedora-Cloud-Base-33-1.2.x86_64.qcow2 \
    molecule converge \
      -s registry_auth \
      -- \
      --extra-vars="custom_runner_image=quay.io/myrepo/gitlab-runner:latest \
                    custom_registry_host=quay.io \
                    custom_registry_username=my_quay_user \
                    custom_registry_password=my_quay_pass"
```
