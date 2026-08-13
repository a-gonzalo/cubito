pub type CubDB

@external(erlang, "Elixir.CubDB", "put")
pub fn put(db: CubDB, key: String, value: String) -> Nil

@external(erlang, "Elixir.CubDB", "get")
pub fn get(db: CubDB, key: String) -> String

@external(erlang, "Elixir.CubDB", "delete")
pub fn delete(db: CubDB, key: String) -> String

@external(erlang, "Elixir.CubDB", "start_link")
pub fn start_link(path: String) -> CubDB
