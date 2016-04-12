ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Fluffy.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Fluffy.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Fluffy.Repo)

