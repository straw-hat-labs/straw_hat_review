workflow "Health Checking" {
  on = "push"
  resolves = [
    "Run Tests",
    "Check Formatting",
    "Check Linter",
    "Report Coverage"
  ]
}

action "Get Deps" {
  uses = "./action-mix/deps.get"
}

action "Run Tests" {
  uses = "./action-mix/postgresql"
  needs = "Get Deps"
  args = "coveralls.json"
  env = {MIX_ENV = "test"}
}

action "Check Formatting" {
  uses = "./action-mix"
  needs = "Get Deps"
  args = "format --check-formatted"
}

action "Check Linter" {
  uses = "./action-mix"
  needs = "Get Deps"
  args = "credo"
}

action "Check TypeSpec" {
  uses = "./action-mix"
  needs = "Get Deps"
  args = "dialyzer --halt-exit-status"
}

action "Report Coverage" {
  uses = "Atrox/codecov-action@v0.1.2"
  needs = "Run Tests"
  secrets = ["CODECOV_TOKEN"]
}
