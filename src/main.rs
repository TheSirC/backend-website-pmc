#![allow(non_camel_case_types)]
#![feature(proc_macro_hygiene, decl_macro)]
#[macro_use]
extern crate rocket;
#[macro_use]
extern crate rocket_contrib;
#[macro_use]
extern crate diesel;
#[macro_use] extern crate db_macro;
extern crate serde;
extern crate paste;
use rocket_contrib::{serve::StaticFiles, templates::Template};
use std::env;

pub mod db;
pub mod models;
pub mod routes;
pub mod schema;

use routes::*;

fn main() {
let index_path = env::args().nth(1).unwrap_or("/home/carvd/stock-website/result/static".to_string());
    rocket::ignite()
        .mount("/", StaticFiles::from(index_path))
        .mount(
            "/stock",
            routes![
                beamsplitters,
                filters,
                leds,
                lasers,
                lenses,
                mirrors,
                polarizers,
                waveplates
            ],
        )
        .attach(Template::fairing())
        .attach(db::MyPgDatabase::fairing())
        .launch();
}
