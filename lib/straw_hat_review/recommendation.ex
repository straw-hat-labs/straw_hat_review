defmodule StrawHat.Review.Recommendation do
  @moduledoc """
  Interactor module that defines all the functionality for Recommendation management.
  """

  use StrawHat.Review.Interactor

  alias StrawHat.Review.Schema.Recommendation

  @doc """
  Get the list of recommendations.
  """
  @spec get_recommendations(Scrivener.Config.t()) :: Scrivener.Page.t()
  def get_recommendations(pagination \\ []), do: Repo.paginate(Recommendation, pagination)

  @doc """
  Create a recommendation.
  """
  @spec create_recommendation(Recommendation.recommendation_attrs()) ::
          {:ok, Recommendation.t()} | {:error, Ecto.Changeset.t()}
  def create_recommendation(recommendation_attrs) do
    %Recommendation{}
    |> Recommendation.changeset(recommendation_attrs)
    |> Repo.insert()
  end

  @doc """
  Update a recommendation.
  """
  @spec update_recommendation(Recommendation.t(), Recommendation.recommendation_attrs()) ::
          {:ok, Recommendation.t()} | {:error, Ecto.Changeset.t()}
  def update_recommendation(%Recommendation{} = recommendation, recommendation_attrs) do
    recommendation
    |> Recommendation.changeset(recommendation_attrs)
    |> Repo.update()
  end

  @doc """
  Destroy a recommendation.
  """
  @spec destroy_recommendation(Recommendation.t()) :: {:ok, Recommendation.t()} | {:error, Ecto.Changeset.t()}
  def destroy_recommendation(%Recommendation{} = recommendation), do: Repo.delete(recommendation)

  @doc """
  Find a recommendation by `id`.
  """
  @spec find_recommendation(String.t()) :: {:ok, Recommendation.t()} | {:error, Error.t()}
  def find_recommendation(recommendation_id) do
    case get_recommendation(recommendation_id) do
      nil ->
        error =
          Error.new("straw_hat_review.recommendation.not_found", metadata: [recommendation_id: recommendation_id])

        {:error, error}

      recommendation ->
        {:ok, recommendation}
    end
  end

  @doc """
  Get a recommendation by `id`.
  """
  @spec get_recommendation(String.t()) :: Recommendation.t() | nil | no_return
  def get_recommendation(recommendation_id), do: Repo.get(Recommendation, recommendation_id)
end
