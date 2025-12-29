.PHONY: venv lint test run docker-up

venv:
	python3 -m venv app/.venv && . app/.venv/bin/activate && pip install -r app/requirements.txt -r app/requirements-dev.txt

lint:
	. app/.venv/bin/activate && flake8 app tests

test:
	. app/.venv/bin/activate && pytest -q

run:
	. app/.venv/bin/activate && python app/run.py

docker-up:
	docker compose up --build
