defmodule ShowreposWeb.PageController do
  use ShowreposWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def get_repos(conn, %{"username" => username}) do
    body = Jason.encode!(%{
      query: "query($login: String!) {
        user(login: $login) {
          url
          watching(first: 100) {
            edges {
              node {
                name
                url
              }
            }
          }
        }
      }",
      variables: "{
        \"login\": \"#{username}\"
      }"
    })
    headers = %{"Authorization": "Bearer #{System.get_env("GITHUB_ACCESS_TOKEN")}"}

    response = HTTPoison.post!("https://api.github.com/graphql", body, headers)
    responseMap = Jason.decode!(response.body)

    userURL = responseMap["data"]["user"]["url"]
    userWatching = responseMap["data"]["user"]["watching"]["edges"]
    
    IO.inspect userWatching

    render(conn, "index.html", user_url: userURL, user_watching: userWatching)
  end
end
