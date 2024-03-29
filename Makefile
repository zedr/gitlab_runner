.PHONY: default clean lint test converge verify destroy

ENV=.env
_PYTHON=python3
PYTHON_VERSION=$(shell ${_PYTHON} -V | cut -d " " -f 2 | cut -d "." -f1-2)
SITE_PACKAGES=${ENV}/lib/python${PYTHON_VERSION}/site-packages
PYTHON=${ENV}/bin/python3
ANSIBLE=${ENV}/bin/ansible
ANSIBLE_GALAXY=${ENV}/bin/ansible-galaxy
MOLECULE=${ENV}/bin/molecule
IN_ENV=source ${ENV}/bin/activate ;
MOLECULE_SCENARIO := $(or $(MOLECULE_SCENARIO),"default")
MOLECULE_ARGS=-s ${MOLECULE_SCENARIO} -- --extra-vars='${EXTRA_VARS}'

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

lint: ${MOLECULE}
	@echo "Linting roles..."
	@yamllint roles/gitlab_runner/
	@ansible-lint roles/gitlab_runner/

test: ${MOLECULE}
	@echo "Running Molecule test suite using libvirt..." >&2
	@${IN_ENV} cd roles/gitlab_runner/ ; molecule test ${MOLECULE_ARGS}

converge: ${MOLECULE}
	@echo "Running Molecule converge using libvirt..." >&2
	@echo "Using scenario '${MOLECULE_SCENARIO}'"
	@${IN_ENV} cd roles/gitlab_runner/ ; molecule converge ${MOLECULE_ARGS}

verify: ${MOLECULE}
	@echo "Running Molecule converge using libvirt..." >&2
	@echo "Using scenario '${MOLECULE_SCENARIO}'"
	@${IN_ENV} cd roles/gitlab_runner/ ; molecule verify -s ${MOLECULE_SCENARIO}

destroy: ${MOLECULE}
	@echo "Running Molecule converge using libvirt..." >&2
	@echo "Using scenario '${MOLECULE_SCENARIO}'"
	@${IN_ENV} cd roles/gitlab_runner/ ; molecule destroy -s ${MOLECULE_SCENARIO}

clean:
	@rm -rf .env ./build
