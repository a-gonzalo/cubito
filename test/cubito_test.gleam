import cubito
import gleam/dict
import gleam/result
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn cubito_init_test() {
  let assert Ok(db) = cubito.start([cubito.DataDir("./cubito/test_1")])
  cubito.clear(db)
}

pub fn cubito_put_test() {
  let assert Ok(db) = cubito.start([cubito.DataDir("./cubito/test_2")])
  cubito.put(db, "Key", "Value")
  let get_raw = cubito.get(db, "Key")
  assert get_raw == "Value"
}

pub fn cubito_tuple_test() {
  let assert Ok(db) = cubito.start([cubito.DataDir("./cubito/test_3")])

  cubito.put(db, #("temp_sensor_01", 171_800_200), "36.5°C")
  cubito.put(db, #("temp_sensor_01", 171_800_300), "38.2°C")

  let reading = cubito.get(db, #("temp_sensor_01", 171_800_300))
  assert reading == "38.2°C"
}

pub fn cubito_dict_test() {
  let assert Ok(db) = cubito.start([cubito.DataDir("./cubito/test_4")])

  cubito.put(
    db,
    #("temp_sensor_01", 171_800_200),
    dict.new() |> dict.insert("Key", "Value"),
  )
  cubito.put(
    db,
    #("temp_sensor_01", 171_800_300),
    dict.new() |> dict.insert("Key2", "Value2"),
  )

  let reading =
    cubito.get(db, #("temp_sensor_01", 171_800_300))
    |> dict.get("Key2")
    |> result.unwrap("FAIL")
  assert reading == "Value2"
}
