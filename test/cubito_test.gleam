import cubito
import gleam/dynamic
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn hello_world_test() {
  let db = cubito.start_link("./cubito")
  echo db
  let res = cubito.put(db, "Esta", "Aqui")
  echo res
}
