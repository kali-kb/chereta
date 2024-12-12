defmodule CheretaWeb.Router do
  use CheretaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  # pipeline :graphql do
  #   plug :accepts, ["json"]
  #   plug Absinthe.Plug, schema: CheretaWeb.Schema
  # end

  scope "/api", CheretaWeb do
    pipe_through :api
    post "/login", SessionController, :create
    resources "/categories", CategoryController
    get "/items/:item_id", ItemController, :show
    # resources "items/:item_id/bids/:bid_id"
    resources "/users", UserController do
      resources "/items", ItemController do
        resources "/bids", BidController, except: [:new, :edit, :show]
      end
    end
  end

  scope "/api" do
    pipe_through :api
    # pipe_through :graphql

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: CheretaWeb.Schema

    forward "/graphql", Absinthe.Plug,
      schema: CheretaWeb.Schema
  end



  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:chereta, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: CheretaWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
