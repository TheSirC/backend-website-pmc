use crate::diesel::PgConnection;
use crate::diesel::RunQueryDsl;
use crate::models::{
    beamsplitters, filters, lasers, leds, lenses, mirrors, polarizers, waveplates,
};
use crate::schema;

#[database("stock_db")]
pub struct MyPgDatabase(PgConnection);

pub fn get_leds(db_connection: PgConnection) -> Vec<leds> {
    schema::leds::table
        .load::<leds>(&db_connection)
        .expect("The call to the database did not go well")
}
pub fn get_lasers(db_connection: PgConnection) -> Vec<lasers> {
    schema::lasers::table
        .load::<lasers>(&db_connection)
        .expect("The call to the database did not go well")
}
pub fn get_filters(db_connection: PgConnection) -> Vec<filters> {
    schema::filters::table
        .load::<filters>(&db_connection)
        .expect("The call to the database did not go well")
}
pub fn get_lenses(db_connection: PgConnection) -> Vec<lenses> {
    schema::lenses::table
        .load::<lenses>(&db_connection)
        .expect("The call to the database did not go well")
}
pub fn get_mirrors(db_connection: PgConnection) -> Vec<mirrors> {
    schema::mirrors::table
        .load::<mirrors>(&db_connection)
        .expect("The call to the database did not go well")
}
pub fn get_polarizers(db_connection: PgConnection) -> Vec<polarizers> {
    schema::polarizers::table
        .load::<polarizers>(&db_connection)
        .expect("The call to the database did not go well")
}
pub fn get_waveplates(db_connection: PgConnection) -> Vec<waveplates> {
    schema::waveplates::table
        .load::<waveplates>(&db_connection)
        .expect("The call to the database did not go well")
}
pub fn get_beamsplitters(db_connection: PgConnection) -> Vec<beamsplitters> {
    schema::beamsplitters::table
        .load::<beamsplitters>(&db_connection)
        .expect("The call to the database did not go well")
}
