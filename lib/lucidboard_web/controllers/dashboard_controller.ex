defmodule LucidboardWeb.DashboardController do
  use LucidboardWeb, :controller
  alias Lucidboard.Twiddler

  def index(conn, _params) do
    render(conn, "index.html", boards: Twiddler.boards())
  end
end
