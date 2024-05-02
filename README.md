# chatbot_backend

Behold My Awesome Project!

[![Built with Cookiecutter Django](https://img.shields.io/badge/built%20with-Cookiecutter%20Django-ff69b4.svg?logo=cookiecutter)](https://github.com/cookiecutter/cookiecutter-django/)
[![Black code style](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/ambv/black)



## Settings

Moved to [settings](http://cookiecutter-django.readthedocs.io/en/latest/settings.html).

## Basic Commands

### Setting Up Your Users

- To create a **normal user account**, just go to Sign Up and fill out the form. Once you submit it, you'll see a "Verify Your E-mail Address" page. Go to your console to see a simulated email verification message. Copy the link into your browser. Now the user's email should be verified and ready to go.

- To create a **superuser account**, use this command:

      $ python manage.py createsuperuser

For convenience, you can keep your normal user logged in on Chrome and your superuser logged in on Firefox (or similar), so that you can see how the site behaves for both kinds of users.

### Type checks

Running type checks with mypy:

    $ mypy chatbot_backend

### Test coverage

To run the tests, check your test coverage, and generate an HTML coverage report:

    $ coverage run -m pytest
    $ coverage html
    $ open htmlcov/index.html

#### Running tests with pytest

    $ pytest

### Live reloading and Sass CSS compilation

Moved to [Live reloading and SASS compilation](https://cookiecutter-django.readthedocs.io/en/latest/developing-locally.html#sass-compilation-live-reloading).

## Deployment

The following details how to deploy this application.

### Docker

See detailed [cookiecutter-django Docker documentation](http://cookiecutter-django.readthedocs.io/en/latest/deployment-with-docker.html).


## Shortcuts 🔑

This project includes several shortcuts to streamline the development process:

- **Create migrations:**
    ```bash
    make make-migrations
    ```

- **Run migrations:**
    ```bash
    make migrate
    ```

- **Run the linter:**
    ```bash
    make lint
    ```

- **Run the formatter:**
    ```bash
    make format
    ```

- **Run the tests:**
    ```bash
    make test
    ```

- **Create a super user:**
    ```bash
    make super-user
    ```

- **Build and run dev environment:**
    ```bash
    make build-dev
    ```

- **Build and run prod environment:**
    ```bash
    make build-prod
    ```

- **Run dev environment:**
    ```bash
    make run-dev
    ```

- **Stop dev environment:**
    ```bash
    make stop-dev
    ```

---
