#![allow(non_camel_case_types)]
#![feature(proc_macro_hygiene, decl_macro)]
#[macro_use] extern crate rocket;
#[macro_use] extern crate rocket_contrib;
#[macro_use] extern crate diesel;

use rocket_contrib::{ serve::StaticFiles, templates::Template};

pub mod routes;
pub mod db;
pub mod models;
pub mod schema;

use routes::*;

fn main() {
    rocket::ignite()
        .mount("/", StaticFiles::from("static"))
        .mount("/stock", routes![beamsplitters,leds,lasers,lenses,mirrors,polarizers,waveplates])
        .attach(Template::fairing())
        .attach(db::MyPgDatabase::fairing())
        .launch();
}
