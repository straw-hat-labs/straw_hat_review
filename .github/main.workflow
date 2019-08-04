workflow "Health Checking" {
  on = "push"
  resolves = [
    "Run Tests",
    "Check Formatting",
    "Check Linter"
  ]
}

action "Get Deps" {
  uses = "yordis/action-mix/deps.get@withpostgres"
}

action "Run Tests" {
  uses = "yordis/action-mix@withpostgres"
  needs = "Get Deps"
  args = "coveralls.json"
  env = {MIX_ENV = "test"}
}

action "Check Formatting" {
  uses = "yordis/action-mix@withpostgres"
  needs = "Get Deps"
  args = "format --check-formatted"
}

action "Check Linter" {
  uses = "yordis/action-mix@withpostgres"
  needs = "Get Deps"
  args = "credo"
}
