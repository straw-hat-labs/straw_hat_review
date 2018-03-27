defmodule StrawHat.Review.Feedbacks do
  @moduledoc """
  Interactor module that defines all the functionality for Feedbacks management.
  """

  use StrawHat.Review.Interactor

  alias StrawHat.Review.Feedback

  @doc """
  Get the list of feedbacks.
  """
  @since "1.0.0"
  @spec get_feedbacks(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_feedbacks(pagination \\ []), do: Repo.paginate(Feedback, pagination)

  @doc """
  Create a feedback.
  """
  @since "1.0.0"
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
  @since "1.0.0"
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
  @since "1.0.0"
  @spec destroy_feedback(Feedback.t()) :: {:ok, Feedback.t()} | {:error, Ecto.Changeset.t()}
  def destroy_feedback(%Feedback{} = feedback), do: Repo.delete(feedback)

  @doc """
  Find a feedback by `id`.
  """
  @since "1.0.0"
  @spec find_feedback(Integer.t()) :: {:ok, Feedback.t()} | {:error, Error.t()}
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
  @since "1.0.0"
  @spec get_feedback(Integer.t()) :: Feedback.t() | nil | no_return
  def get_feedback(feedback_id), do: Repo.get(Feedback, feedback_id)
end
