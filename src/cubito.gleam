import gleam/dynamic
import gleam/erlang/process.{type Pid}

pub type CubDB =
  Pid

pub type CubDBOption {
  DataDir(String)
}

@external(erlang, "Elixir.CubDB", "start")
pub fn start(options: List(CubDBOption)) -> Result(CubDB, dynamic.Dynamic)

@external(erlang, "Elixir.CubDB", "put")
pub fn put(db: CubDB, key: String, value: String) -> Nil

@external(erlang, "Elixir.CubDB", "get")
pub fn get(db: CubDB, key: String) -> dynamic.Dynamic

@external(erlang, "Elixir.CubDB", "delete")
pub fn delete(db: CubDB, key: String) -> Nil
