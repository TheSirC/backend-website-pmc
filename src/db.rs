use rocket_contrib::databases::diesel::PgConnection;
use crate::models::{leds,lasers,filters,lenses,mirrors,polarizers,waveplates,beamsplitters};
use crate::diesel::prelude::*;
use crate::diesel::RunQueryDsl;

#[database("stock_db")]
pub struct MyPgDatabase(PgConnection);

pub fn get_leds(db_connection: PgConnection) -> Vec<leds> {
    leds::table.load::<leds>(&db_connection).expect("The call to the database did not go well")
}

pub fn get_lasers(db_connection: PgConnection) -> Vec<lasers> {
    lasers::table.load::<lasers>(&db_connection).expect("The call to the database did not go well")
}
pub fn get_filters(db_connection: PgConnection) -> Vec<filters> {
    filters::table.load::<filters>(&db_connection).expect("The call to the database did not go well")
}
pub fn get_lenses(db_connection: PgConnection) -> Vec<lenses> {
    lenses::table.load::<lenses>(&db_connection).expect("The call to the database did not go well")
}
pub fn get_mirrors(db_connection: PgConnection) -> Vec<mirrors> {
    mirrors::table.load::<mirrors>(&db_connection).expect("The call to the database did not go well")
}
pub fn get_polarizers(db_connection: PgConnection) -> Vec<polarizers> {
    polarizers::table.load::<polarizers>(&db_connection).expect("The call to the database did not go well")
}
pub fn get_waveplates(db_connection: PgConnection) -> Vec<waveplates> {
    waveplates::table.load::<waveplates>(&db_connection).expect("The call to the database did not go well")
}
pub fn get_beamsplitters(db_connection: PgConnection) -> Vec<beamsplitters> {
    beamsplitters::table.load::<beamsplitters>(&db_connection).expect("The call to the database did not go well")
}
