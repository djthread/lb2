defimpl Inspect, for: Lucidboard.Board do
  import Inspect.Algebra

  def inspect(_dict, _opts) do
    concat(["#Board<>"])
  end
end

defmodule Lucidboard.Board do
  @moduledoc "Schema for a board record"
  use Ecto.Schema
  import Ecto.Changeset
  alias Lucidboard.{BoardRole, BoardSettings, Column, Event, User}

  @derive {Jason.Encoder, only: ~w(id title settings columns)a}

  schema "boards" do
    field(:title, :string)
    embeds_one(:settings, BoardSettings, on_replace: :update)
    has_many(:columns, Column)
    has_many(:events, Event)
    belongs_to(:user, User)
    has_many(:board_roles, BoardRole)

    field(:inserted_at, :utc_datetime)
    field(:updated_at, :utc_datetime)
  end

  @spec new(keyword) :: Board.t()
  def new(fields \\ []) do
    now = DateTime.truncate(DateTime.utc_now(), :second)

    defaults = [
      settings: BoardSettings.new(),
      inserted_at: now,
      updated_at: now
    ]

    struct(__MODULE__, Keyword.merge(defaults, fields))
  end

  @doc false
  def changeset(board, attrs \\ %{}) do
    board
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> cast_assoc(:columns)
    |> put_change(:settings, attrs.settings)
    # |> cast_embed(:settings, attrs.settings)
    |> put_change(:settings, Map.get(attrs, "settings"))
  end
end
