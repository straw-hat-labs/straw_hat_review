FROM elixir:1.9

LABEL "repository"="https://github.com/jclem/action-mix"
LABEL "homepage"="https://github.com/jclem/action-mix"
LABEL "maintainer"="Jonathan Clem <jonathan@jclem.net>"

LABEL "com.github.actions.name"="Run Elixir mix commands"
LABEL "com.github.actions.description"="An action for running Elixir mix commands with PostgreSQL available"
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="orange"

ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres

ARG MIX_HOME=/.mix
ENV MIX_HOME=$MIX_HOME
ARG MIX_ENV=dev
ENV MIX_ENV=$MIX_ENV

RUN apt-get update

# Install supervisor
RUN apt-get install -y supervisor
# Install postgresql
RUN apt-get install -y postgresql
RUN apt-get install -y postgresql-client
RUN echo "local all all trust" > /etc/postgresql/9.6/main/pg_hba.conf
RUN echo "host all all localhost trust" >> /etc/postgresql/9.6/main/pg_hba.conf
COPY *.conf /etc/supervisor/conf.d/
COPY entrypoint.sh /entrypoint.sh
USER postgres
RUN /etc/init.d/postgresql start && createuser -s postgres

USER postgres
ENV USER=postgres

RUN mix local.rebar --force
RUN mix local.hex --force

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]


FROM elixir:1.9
