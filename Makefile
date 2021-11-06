.PHONY: default clean test converge verify destroy

ENV=.env
_PYTHON=python3
PYTHON_VERSION=$(shell ${_PYTHON} -V | cut -d " " -f 2 | cut -c1-3)
SITE_PACKAGES=${ENV}/lib/python${PYTHON_VERSION}/site-packages
PYTHON=${ENV}/bin/python3
ANSIBLE=${ENV}/bin/ansible
ANSIBLE_GALAXY=${ENV}/bin/ansible-galaxy
MOLECULE=${ENV}/bin/molecule
IN_ENV=source ${ENV}/bin/activate ;
SCENARIO=default

default: ${MOLECULE}

${PYTHON}:
	@echo "Creating Python ${PYTHON_VERSION} environment..." >&2
	@${_PYTHON} -m venv ${ENV}

${MOLECULE}: ${PYTHON}
	@echo "Checking for updates to pip..." >&2
	@${PYTHON} -m pip install -U pip
	@echo "Installing Ansible @ ${ANSIBLE} and dependencies..." >&2
	@${PYTHON} -m pip install -r requirements.txt
	@${ANSIBLE_GALAXY} collection install -r requirements.yml
	@${ANSIBLE_GALAXY} collection install -r roles/gitlab_runner/requirements.yml

test: ${MOLECULE}
	@echo "Running Molecule test suite using libvirt..." >&2
	@${IN_ENV} cd roles/gitlab_runner/ ; molecule test -s ${SCENARIO}

converge: ${MOLECULE}
	@echo "Running Molecule converge using libvirt..." >&2
	@${IN_ENV} cd roles/gitlab_runner/ ; molecule converge -s ${SCENARIO}

verify: ${MOLECULE}
	@echo "Running Molecule converge using libvirt..." >&2
	@${IN_ENV} cd roles/gitlab_runner/ ; molecule verify -s ${SCENARIO}

destroy: ${MOLECULE}
	@echo "Running Molecule converge using libvirt..." >&2
	@${IN_ENV} cd roles/gitlab_runner/ ; molecule destroy -s ${SCENARIO}

clean: destroy
	@rm -rf .env
