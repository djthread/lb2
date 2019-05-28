defmodule LucidboardWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use LucidboardWeb, :controller
      use LucidboardWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: LucidboardWeb
      import Plug.Conn
      import LucidboardWeb.Gettext
      import unquote(__MODULE__), only: [signed_in?: 1]
      alias LucidboardWeb.Router.Helpers, as: Routes

      action_fallback(LucidboardWeb.FallbackController)
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/lucidboard_web/templates",
        pattern: "**/*",
        namespace: LucidboardWeb

      import unquote(__MODULE__), only: [signed_in?: 1]

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import LucidboardWeb.ErrorHelpers
      import LucidboardWeb.Gettext
      import LucidboardWeb.ViewHelper
      import Phoenix.LiveView, only: [live_render: 2, live_render: 3]
      alias LucidboardWeb.BoardLive
      alias LucidboardWeb.Router.Helpers, as: Routes
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import LucidboardWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  @doc "Returns true if user is signed in"
  def signed_in?(conn) do
    not is_nil(Map.get(conn.assigns, :user))
  end
end
