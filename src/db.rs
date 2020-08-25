use crate::paste;
use crate::diesel::PgConnection;
use crate::diesel::RunQueryDsl;
use crate::diesel::QueryDsl;
use crate::diesel::Queryable;
use crate::serde::Serialize;
use crate::schema;
use crate::models::localisations;

#[database("stock_db")]
pub struct MyPgDatabase(PgConnection);

macro_rules! get_equipment {
    ($($equipment:ident),+) => {
        paste::item! {
        $(
            #[derive(Serialize, Queryable)]
            pub struct [<$equipment _location>] {
                equipment: $equipment,
                location: localisations
            }
            use crate::models::$equipment;
            pub fn [<get_ $equipment>](db_connection: &PgConnection) -> Vec<[<$equipment _location>]> {
                schema::$equipment::table.inner_join(
                    schema::localisations::table
                )
                    .load(db_connection)
                    .expect("The call to the database for the equipment table did not go well")
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
