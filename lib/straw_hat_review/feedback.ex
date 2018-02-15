defmodule StrawHat.Review.Feedback do
  @moduledoc """
  Interactor module that defines all the functionality for Feedback management.
  """

  use StrawHat.Review.Interactor

  alias StrawHat.Review.Schema.Feedback

  @doc """
  Get the list of feedbacks.
  """
  @spec get_feedbacks(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_feedbacks(pagination \\ []), do: Repo.paginate(Feedback, pagination)

  @doc """
  Create a feedback.
  """
  @spec create_feedback(Feedback.feedback_attrs()) ::
          {:ok, Feedback.t()} | {:error, Ecto.Changeset.t()}
  def create_feedback(feedback_attrs) do
    %Feedback{}
    |> Feedback.changeset(feedback_attrs)
    |> Repo.insert()
  end

  @doc """
  Update a feedback.
  """
  @spec update_feedback(Feedback.t(), Feedback.feedback_attrs()) ::
          {:ok, Feedback.t()} | {:error, Ecto.Changeset.t()}
  def update_feedback(%Feedback{} = feedback, feedback_attrs) do
    feedback
    |> Feedback.changeset(feedback_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy a feedback.
  """
  @spec destroy_feedback(Feedback.t()) :: {:ok, Feedback.t()} | {:error, Ecto.Changeset.t()}
  def destroy_feedback(%Feedback{} = feedback), do: Repo.delete(feedback)

  @doc """
  Find a feedback by `id`.
  """
  @spec find_feedback(String.t()) :: {:ok, Feedback.t()} | {:error, Error.t()}
  def find_feedback(feedback_id) do
    case get_feedback(feedback_id) do
      nil ->
        error =
          Error.new("straw_hat_review.feedback.not_found", metadata: [feedback_id: feedback_id])

        {:error, error}

      feedback ->
        {:ok, feedback}
    end
  end

  @doc """
  Get a feedback by `id`.
  """
  @spec get_feedback(String.t()) :: Feedback.t() | nil | no_return
  def get_feedback(feedback_id), do: Repo.get(Feedback, feedback_id)
end
