# GitHub Action for Mix with PostgreSQL available

This Action for [Mix](https://hexdocs.pm/mix/Mix.html) enables arbitrary actions with this `mix` command-line client.

The default `MIX_ENV` is `"dev"`, so override it as needed.

## Usage

```hcl
workflow "My Workflow" {
    on = "push"
    resolves = ["Run Tests"]
}

action "Get Deps" {
    uses = "jclem/action-mix/deps.get@v1.3.3"
}

action "Run Tests" {
    uses = "yordis/action-mix/postgresql@master"
    needs = "Get Deps"
    args = "coveralls.json"
    env = {MIX_ENV = "test"}
}
```
