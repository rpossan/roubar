require IEx
defmodule RoubarWeb.DiscordController do
  use RoubarWeb, :controller

  def rollbar(conn, _params) do
    url = System.get_env("DISCORD_API_URL")
    body = Jason.encode!(build_body(_params))
    headers = [{"Content-type", "application/json"}]
    HTTPoison.post(url, body, headers, [])
    json(conn, %{result: body})
  end

  def content(msg) do
    %{ content: msg, mention_everyone: true }
  end

  def build_body(p) do
    icon = "information_source"
    icon = if (p["event_name"] == "resolved_item"), do: "white_check_mark", else: icon
    icon = if (p["event_name"] == "reactivated_item"), do: "repeat", else: icon
    icon = if (p["event_name"] == "new_item" || p["event_name"] == "occurrence"), do: "warning", else: icon;
    content(":#{icon}: [**#{p["event_name"]}**]\n`#{p["data"]["item"]["title"]}`\nLink: #{p["data"]["url"]}")
  end
end
