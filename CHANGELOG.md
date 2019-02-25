# Changelog

## 2.0.0

We remove the repository module from the project, and this opens the API to be
more flexible and also transfers some responsibilities out of the package that
we do not want to handle for you because it depends on each business and
infrastructure.

### 💥 Breaking Change

All business use cases takes an Ecto repository as first parameter.

1. You will need to create a repository on your project.
2. Change all the API calls to pass the repo as first parameter.
3. Run migrations from your project.

Besides this, all the API stay the same, no changes.

`StrawHat.Mailer.Emails.with_template` requires to pass `data` and `data` most
be string key based. We could have some potential memory leak because of atoms.

#### Committers

- Yordis Prieto ([yordis](https://github.com/yordis))
