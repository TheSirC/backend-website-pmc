use crate::db_macro::stock_route;
use crate::db::{MyPgDatabase};
use serde::{ Serialize, Deserialize };
use rocket_contrib::{json::Json, templates::Template };


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
