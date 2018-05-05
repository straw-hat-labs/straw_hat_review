# StrawHat.Review

[![Build Status](https://travis-ci.org/straw-hat-team/straw_hat_review.svg?branch=master)](https://travis-ci.org/straw-hat-team/straw_hat_review)
[![codecov](https://codecov.io/gh/straw-hat-team/straw_hat_review/branch/master/graph/badge.svg)](https://codecov.io/gh/straw-hat-team/straw_hat_review)
[![Inline docs](http://inch-ci.org/github/straw-hat-team/straw_hat_review.svg)](http://inch-ci.org/github/straw-hat-team/straw_hat_review)

`StrawHat.Review` will help you to add reviews to your systems. We took
inspiration from Amazon, Lyf, Google, Uber and Fiverr review systems. 

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `straw_hat_review` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:straw_hat_review, "~> 0.1"}
  ]
end
```

## Usage

We will cover the basic interactions of the systems but please check out
each Interactor module which are the ones that expose the API that developers
should be using.

### Aspects

Let's create some aspects based on Fiverr Reviews.

```elixir
  # id: 1  
  StrawHat.Review.Aspects.create_review(%{
    name: "seller_communication"
  })  
  
  # id: 2  
  StrawHat.Review.Aspects.create_review(%{
    name: "service_as_described"
  })
  
  # id: 3
  StrawHat.Review.Aspects.create_review(%{
    name: "would_recommend"
  })
```

### Reviews

Now let's give some review to a user.

Normally the reviewee and reviewer are just an string that your systems will 
know how to do the aggregation with that data. For example, your system that
uses `StrawHat.Review` knows that `"user:" <> user_id` is the way to read back
the user id of the reviewee and reviewer.

```elixir
  # id: 1
  StrawHat.Review.Review.create_review(%{
    reviewee_id: "user:1",
    reviewer_id: "user:2",
    comment: "Amazing experience, I really recommended it",
    aspects: [
      %{
        aspect_id: 1, # seller_communication
        score: 5
      }, 
      %{
        aspect_id: 2, # service_as_described
        score: 5
      },
      %{
        aspect_id: 3, # would_recommend
        score: 5
      }
    ]
    medias: [
      %Plug.Upload{
        content_type: "image/png",
        filename: "some_random_file_name.png",
        path: "~tmp/some_random_name.png"
      }
    ]
  })
```

### Comments

Now we could add some comments to the review.

```elixir
  # id: 1
  StrawHat.Review.Comments.create_comment(%{
    comment: "Really helpful review, thank you very much",
    owner_id: "user:3",
    review_id: 1
  })
```

### Reactions

We could create some reactions for the systems so it could be use later
on reviews and comments.

```elixir
  # id: 1
  StrawHat.Review.Reactions.create_reaction(%{
    name: "like"
  })
  
  # id: 2
  StrawHat.Review.Reactions.create_reaction(%{
    name: "dislike"
  })
```

Now we could react to the reviews and comments

```elixir
  StrawHat.Review.ReviewReactions.create_review_reaction(%{
    review_id: 1,
    reaction_id: 1,
    user_id: "user:1"
  })
  
  StrawHat.Review.CommentReactions.create_comment_reaction(%{
    review_id: 1,
    reaction_id: 1,
    user_id: "user:1"
  })
```
