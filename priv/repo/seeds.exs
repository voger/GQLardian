# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     GQLardian.Repo.insert!(%GQLardian.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias GQLardian.Repo
require Logger

Logger.info("Populate post_statuses table")

post_status_entries =
  [
    "draft",
    "unpublished",
    "published"
  ]
  |> Enum.map(&[status: &1])
Repo.insert_all("post_statuses", post_status_entries)
