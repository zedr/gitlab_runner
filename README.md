# Gitlab Runner Playbook
A playbook for installing and running a Gitlab Runner instance using Podman
without root privileges.

Supports Fedora 33.

## Installation

### Ansible Galaxy

`$ ansible-galaxy collection install zedr.gitlab_runner`

### Local
`$ ansible-galaxy collection install `

## Molecule test dependencies
OS:
 - libvirt-devel

## Running the Molecule tests

Start the test suite by creating the VM and converging using the role:
```
$ make converge
```

Verify that the test suite passes:
```
$ make verify
```

Destroy the VM:
```
$ make destroy
```


## Test with a local image to speed up things
```
$ FEDORA_IMAGE_URL=file:///home/zedr/Archive/Fedora-Cloud-Base-33-1.2.x86_64.qcow2 \
make converge
```

## Test by signing into and using a custom registry
```
$ EXTRA_VARS="custom_runner_image=quay.io/myrepo/gitlab-runner:latest \
              custom_registry_host=quay.io \
              custom_registry_username=my_quay_user \
              custom_registry_password=my_quay_pass" \
MOLECULE_SCENARIO="registry_auth" \
make converge
```

## Vagrant test VM

Use with:
```sh
$ vagrant up
```

## Issues

### "UNREACHABLE (...) Failed to connect to the host via ssh"

Destroy the VM with `make destroy` and retry.

### "Failed to download metadata" when creating the VM
A sporadic issue causing the error message `Failed to download metadata for repo 'fedora-modular': Cannot prepare internal mirrorlist: Status code: 503` seems to be unrelated to the role and its tests. Try launching the tests again.
