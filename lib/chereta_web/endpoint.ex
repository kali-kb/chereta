defmodule CheretaWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :chereta

  # Dynamic CORS configuration based on environment
  @cors_origins case Mix.env() do
    :prod ->
      base_origins = ["https://chereta-b6kt.onrender.com"]
      # Add Netlify URL from environment variable or use a wildcard pattern
      netlify_url = System.get_env("FRONTEND_URL")
      if netlify_url do
        [netlify_url | base_origins]
      else
        # Allow common Netlify patterns
        base_origins ++ [
          "https://cheretaet.netlify.app",
          # Add pattern matching for branch deploys
          ~r/https:\/\/[a-zA-Z0-9-]+--cheretaet\.netlify\.app$/,
          ~r/https:\/\/.*\.netlify\.app$/
        ]
      end
    _ ->
      ["http://localhost:3000", "http://localhost:4002", "https://chereta-b6kt.onrender.com"]
  end

  plug CORSPlug,
    origin: @cors_origins,
    headers: ["Authorization", "Content-Type", "Accept", "Origin", "User-Agent", "DNT", "Cache-Control", "X-Mx-ReqToken", "Keep-Alive", "X-Requested-With", "If-Modified-Since", "X-CSRF-Token"],
    methods: ["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"]

  socket "/socket", CheretaWeb.UserSocket,
    websocket: true,
    longpoll: false

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_chereta_key",
    signing_salt: "0jG5JvDM",
    same_site: "Lax"
  ]

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :chereta,
    gzip: false,
    only: CheretaWeb.static_paths()

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :chereta
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug CheretaWeb.Router
end
