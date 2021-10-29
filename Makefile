.PHONY: default _update_pip clean lint tests

ENV=.env
_PYTHON=python3
PYTHON_VERSION=$(shell ${_PYTHON} -V | cut -d " " -f 2 | cut -c1-3)
SITE_PACKAGES=${ENV}/lib/python${PYTHON_VERSION}/site-packages
PYTHON=${ENV}/bin/python3
ANSIBLE=${ENV}/bin/ansible
ANSIBLE_GALAXY=${ENV}/bin/ansible-galaxy
MOLECULE=${ENV}/bin/molecule
IN_ENV=source ${ENV}/bin/activate;

default: ${MOLECULE}

${PYTHON}:
	@echo "Creating Python ${PYTHON_VERSION} environment..." >&2
	@${_PYTHON} -m venv ${ENV}

_update_pip: ${PYTHON}
	@echo "Checking for updates to pip..." >&2
	@${PYTHON} -m pip install -U pip

${MOLECULE}: _update_pip ${PYTHON}
	@echo "Installing Ansible @ ${ANSIBLE} and dependencies..." >&2
	@${PYTHON} -m pip install -r requirements.txt
	@${ANSIBLE_GALAXY} collection install -r requirements.yml

test: ${MOLECULE}
	@echo "Running Molecule test suite using libvirt..." >&2
	@${IN_ENV} cd roles/gitlab_runner/ ; molecule test

converge: ${MOLECULE}
	@echo "Running Molecule converge using libvirt..." >&2
	@${IN_ENV} cd roles/gitlab_runner/ ; molecule converge

verify: ${MOLECULE}
	@echo "Running Molecule converge using libvirt..." >&2
	@${IN_ENV} cd roles/gitlab_runner/ ; molecule verify

clean:
	@rm -rf .env
