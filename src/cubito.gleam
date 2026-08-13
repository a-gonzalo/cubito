import gleam/dynamic

pub type CubDB(k, v)

pub type CubDBOption {
  DataDir(String)
}

@external(erlang, "Elixir.CubDB", "start")
pub fn start(options: List(CubDBOption)) -> Result(CubDB(k, v), dynamic.Dynamic)

@external(erlang, "Elixir.CubDB", "put")
pub fn put(db: CubDB(k, v), key: k, value: v) -> Nil

@external(erlang, "Elixir.CubDB", "get")
pub fn get(db: CubDB(k, v), key: k) -> v

@external(erlang, "Elixir.CubDB", "delete")
pub fn delete(db: CubDB(k, v), key: k) -> Nil

@external(erlang, "Elixir.CubDB", "clear")
pub fn clear(db: CubDB(k, v)) -> Nil
