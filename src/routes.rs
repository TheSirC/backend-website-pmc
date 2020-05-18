use crate::db::{
    get_beamsplitters, get_filters, get_lasers, get_leds, get_lenses, get_mirrors, get_polarizers,
    get_waveplates, MyPgDatabase,
};
use rocket_contrib::templates::{tera::Context, Template};

#[get("/leds")]
pub fn leds(db_connection: MyPgDatabase) -> Template {
    let query = get_leds(*db_connection.0);
    Template::render("leds", Context::new())
}

#[get("/lasers")]
pub fn lasers(db_connection: MyPgDatabase) -> Template {
    let query = get_lasers(*db_connection.0);
    Template::render("lasers", Context::new())
}

#[get("/filters")]
pub fn filters(db_connection: MyPgDatabase) -> Template {
    let query = get_filters(*db_connection.0);
    Template::render("filters", Context::new())
}

#[get("/lenses")]
pub fn lenses(db_connection: MyPgDatabase) -> Template {
    let query = get_lenses(*db_connection.0);
    Template::render("lenses", Context::new())
}

#[get("/mirrors")]
pub fn mirrors(db_connection: MyPgDatabase) -> Template {
    let query = get_mirrors(*db_connection.0);
    Template::render("mirrors", Context::new())
}

#[get("/polarizers")]
pub fn polarizers(db_connection: MyPgDatabase) -> Template {
    let query = get_polarizers(*db_connection.0);
    Template::render("polarizers", Context::new())
}

#[get("/waveplates")]
pub fn waveplates(db_connection: MyPgDatabase) -> Template {
    let query = get_waveplates(*db_connection.0);
    Template::render("waveplates", Context::new())
}

#[get("/beamsplitters")]
pub fn beamsplitters(db_connection: MyPgDatabase) -> Template {
    let query = get_beamsplitters(*db_connection.0);
    Template::render("beamsplitters", Context::new())
}
