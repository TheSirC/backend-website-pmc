use rocket_contrib::templates::Template;
use crate::db::*;
use crate::db::get_leds;
use crate::db::get_lasers;
use crate::db::get_filters;
use crate::db::get_lenses;
use crate::db::get_mirrors;
use crate::db::get_polarizers;
use crate::db::get_waveplates;
use crate::db::get_beamsplitters;

#[get("/leds")]
pub fn leds(db_connection: MyPgDatabase) -> Template {
    let query = get_leds(&db_connection.0);
    Template::render( leds, query )
}

#[get("/lasers")]
pub fn lasers(db_connection: MyPgDatabase) -> Template {
    let query = get_lasers(&db_connection.0);
    Template::render( lasers, query )
}

#[get("/filters")]
pub fn filters(db_connection: MyPgDatabase) -> Template {
    let query = get_filters(&db_connection.0);
    Template::render( filters, query )
}

#[get("/lenses")]
pub fn lenses(db_connection: MyPgDatabase) -> Template {
    let query = get_lenses(&db_connection.0);
    Template::render( lenses, query )
}

#[get("/mirrors")]
pub fn mirrors(db_connection: MyPgDatabase) -> Template {
    let query = get_mirrors(&db_connection.0);
    Template::render( mirrors, query )
}

#[get("/polarizers")]
pub fn polarizers(db_connection: MyPgDatabase) -> Template {
    let query = get_polarizers(&db_connection.0);
    Template::render( polarizers, query )
}

#[get("/waveplates")]
pub fn waveplates(db_connection: MyPgDatabase) -> Template {
    let query = get_waveplates(&db_connection.0);
    Template::render( waveplates, query )
}

#[get("/beamsplitters")]
pub fn beamsplitters(db_connection: MyPgDatabase) -> Template {
    let query = get_beamsplitters(&db_connection.0);
    Template::render( beamsplitters, query )
}
