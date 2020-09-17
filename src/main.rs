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
use rocket_contrib::{serve::{StaticFiles,Options}, templates::Template};

pub mod db;
pub mod models;
pub mod routes;
pub mod schema;

use routes::*;

fn main() {
    rocket::ignite()
        .mount("/", StaticFiles::from(env!("STOCK_WEBSITE_STATIC")))
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
