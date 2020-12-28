defmodule Exgit.ClientTest do
  use ExUnit.Case

  import Tesla.Mock

  describe "get_repos_by_username/1" do
    test "when user has available repos, return them" do
      username = "weltonfelix"

      response = [
        %{"id" => 1, "name" => "my repo 1"},
        %{"id" => 1, "name" => "my repo 2"}
      ]

      expected_response = {:ok, response}

      mock(
        fn
          %{
            method: :get,
            url: "https://api.github.com/users/weltonfelix/repos"
          } -> %Tesla.Env{status: 200, body: response}

        end
      )

      assert Exgit.Client.get_repos_by_username(username) == expected_response
    end

    test "when user not found, returns an error" do
      username = "weltonfelix"
4
      expected_response = {:error, "User not found"}

      mock(
        fn
          %{
            method: :get,
            url: "https://api.github.com/users/weltonfelix/repos"
          } -> %Tesla.Env{status: 404, body: ""}

        end
      )

      assert Exgit.Client.get_repos_by_username(username) == expected_response
    end
  end
end
