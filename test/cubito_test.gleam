import cubito
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn cubito_init_test() {
  let assert Ok(db) = cubito.start([cubito.DataDir("./cubito")])
  cubito.clear(db)
}

pub fn cubito_put_test() {
  let assert Ok(db) = cubito.start([cubito.DataDir("./cubito_2")])
  cubito.put(db, "Key", "Value")
  let get_raw = cubito.get(db, "Key")
  assert get_raw == "Value"
}
