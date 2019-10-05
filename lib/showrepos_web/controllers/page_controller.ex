defmodule ShowreposWeb.PageController do
  use ShowreposWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def getRepos(conn, %{"username" => username}) do
    body = Jason.encode!(%{
      "query": "query($login: String!) {
        user(login: $login) {
          watching(first: 100) {
            edges {
              node {
                name
                url
              }
            }
          } 
          repositories(first: 100){
            edges {
              node {
                name
                url
              }
            }
          }
        }
      }",
      "variables": "{
        \"login\": \"#{username}\"
      }"
    })
    headers = %{"Authorization": "Bearer #{System.get_env("GITHUB_ACCESS_TOKEN")}"}

    response = HTTPoison.post!("https://api.github.com/graphql", body, headers)
    responseMap = Jason.decode!(response.body)

    IO.inspect response.body
    
    text conn, "#{username}"
  end
end
