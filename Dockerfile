# use python image
FROM python:latest

# update system and install pipx
RUN apt-get update && apt-get install -y pipx
RUN pipx ensurepath
RUN pipx install poetry

# set work index
WORKDIR /app

# file independed by project and install
COPY pyproject.toml ./
RUN pipx run poetry install --no-root

# copy code to the container
COPY todo todo

# run app
CMD ["pipx", "run", "poetry", "run", "flask", "--app", "todo", "run", "--host", "0.0.0.0", "--port", "6400"]