use crate::paste;
use crate::diesel::PgConnection;
use crate::diesel::RunQueryDsl;
use crate::models::{
    beamsplitters, filters, lasers, leds, lenses, mirrors, polarizers, waveplates,
};
use crate::schema;

#[database("stock_db")]
pub struct MyPgDatabase(PgConnection);

macro_rules! get_equipment {
    ($($equipment:ident),+) => {
        paste::item! {
        $(
            pub fn [<get_ $equipment>](db_connection: &PgConnection) -> Vec<$equipment> {
                schema::$equipment::table
                    .load::<$equipment>(db_connection)
                    .expect("The call to the database did not go well")
            }
        )+
        }
    };
}

get_equipment![
    leds,
    lasers,
    lenses,
    filters,
    mirrors,
    polarizers,
    waveplates,
    beamsplitters
];
