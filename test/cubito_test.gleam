import cubito
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn hello_world_test() {
  let assert Ok(db) = cubito.start([cubito.DataDir("./cubito")])
  echo db
  let put_result = cubito.put(db, "e", "a")
  echo put_result
  let get_result = cubito.get(db, "e")
  echo get_result
  cubito.delete(db, "e")
  let get_result = cubito.get(db, "e")
  echo get_result
}
