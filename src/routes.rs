use crate::db_macro::stock_route;
use crate::db::{MyPgDatabase};
use rocket_contrib::templates::Template;
use serde::Serialize;

#[derive(Serialize)]
struct database_response<T: Serialize> {
   rows: T
}

stock_route!(
    leds,
    lasers,
    lenses,
    filters,
    mirrors,
    polarizers,
    waveplates,
    beamsplitters
 );
