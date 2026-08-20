# Cubito 🧊

`cubito` provides native, strongly-typed **CubDB** bindings for **Gleam**.

[CubDB](https://github.com/lucaong/cubdb) is a pure Elixir/Erlang embedded key-value database that is atomic, transactional, and durable (ACID). With `cubito`, you can use it seamlessly in your Gleam projects while maintaining strict compile-time type safety.

## Features

It allows you to spin up and operate embedded CubDB databases directly inside Gleam applications running on the BEAM. By parameterizing the database type as `CubDB(key_type, value_type)`, the Gleam compiler guarantees that keys and values always match your specifications, eliminating runtime type mismatches.

## How It Works

The library leverages Gleam's external function mechanism (`@external`) to map operations directly onto the compiled `Elixir.CubDB` bytecode. 

When you pass native Gleam data types (such as tuples, records, strings, or integers), they are efficiently routed through the Erlang Virtual Machine without performance penalties, translating implicitly into native Erlang/Elixir terms.

## Current Support

Currently, `cubito` supports the essential lifecycle and synchronous CRUD operations of the database:

* **`start`**: Initializes the database process pointing to a specific data directory.
* **`put`**: Atomically inserts or updates a key-value pair.
* **`get`**: Retrieves the value associated with a given key.
* **`delete`**: Removes a key and its corresponding value from storage.
* **`clear`**: Empties the entire database.

---

## Code Examples

### Example 1: Simple Keys (String -> String)
Ideal for global application configurations or straightforward string storage.

```gleam
import cubito
import gleam/io

pub fn main() {
  // 1. Start the database in a dedicated directory
  let assert Ok(db) = cubito.start([cubito.DataDir("./data/config")])

  // 2. Persist data
  cubito.put(db, "site_name", "My Gleam App")
  cubito.put(db, "version", "1.0.0")

  // 3. Retrieve data directly (type is inferred automatically)
  let name = cubito.get(db, "site_name")
  io.println("Connected to: " <> name)
}
```

### Example 2: Composite Keys Using Tuples
Thanks to generic typing, you can use complex tuples as keys (or values). This is extremely useful for time-series data, events, or compound indexes (e.g., `#(SensorID, Timestamp)`).

```gleam
import cubito
import gleam/io

pub fn main() {
  
  let assert Ok(db) = cubito.start([cubito.DataDir("./data/telemetry")])

  // Gleam automatically infers this DB as CubDB(#(String, Int), String)
  // Write data using a tuple as a composite key: #(SensorID, Timestamp)
  cubito.put(db, #("temp_sensor_01", 171800200), "36.5°C")
  cubito.put(db, #("temp_sensor_01", 171800300), "38.2°C")

  // Retrieve the exact value using the same tuple structure
  let reading = cubito.get(db, #("temp_sensor_01", 171800300))
  
  io.println("The sensor reading was: " <> reading) // Prints: 38.2°C
}
```

---

## Requirements & Installation

Since this library targets the Erlang runtime (BEAM), your project must configure the Erlang target in your `gleam.toml`. You must also ensure the underlying `cubdb` Hex package is listed as a dependency in your build environment configuration, and also you will need `iex` and `elixir` installed on your system to compile `cubdb`


```
⚠️Disclaimer:
This README has been written partially with AI, but the code inside this repository isn't.
```