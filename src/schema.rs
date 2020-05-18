table! {
    use crate::Positive_float_range;
    use diesel::sql_types::*;
    beamsplitters (id) {
        manufacturer -> Nullable<Text>,
        model -> Nullable<Text>,
        diameter -> Nullable<Float>,
        quantity -> Nullable<Int4>,
        shape -> Nullable<Text>,
        mounted -> Nullable<Bool>,
        polarising -> Nullable<Bool>,
        localisation -> Int4,
        operatingwavelengthrange -> Nullable<Positive_float_range>,
        model_type -> Nullable<Text>,
        arrange -> Nullable<Positive_float_range>,
        reflectance -> Nullable<Int4>,
        transmittance -> Nullable<Int4>,
        thickness -> Nullable<Float>,
        id -> Int4,
    }
}

table! {
    beamsplittertype (name) {
        name -> Text,
    }
}

table! {
    use crate::Positive_float_range;
    use diesel::sql_types::*;
    filters (id) {
        manufacturer -> Nullable<Text>,
        model -> Nullable<Text>,
        diameter -> Nullable<Float>,
        quantity -> Int4,
        shape -> Nullable<Text>,
        mounted -> Nullable<Bool>,
        localisation -> Int4,
        operatingwavelengthrange -> Nullable<Positive_float_range>,
        adjustable -> Nullable<Bool>,
        id -> Int4,
    }
}

table! {
    lasers (id) {
        manufacturer -> Nullable<Text>,
        model -> Nullable<Text>,
        quantity -> Nullable<Int4>,
        shape -> Nullable<Text>,
        mounted -> Nullable<Bool>,
        localisation -> Int4,
        maxpower -> Nullable<Float>,
        voltage -> Nullable<Float>,
        wavelength -> Nullable<Float>,
        id -> Int4,
    }
}

table! {
use crate::Positive_float_range;
    use diesel::sql_types::*;
    leds (id) {
        manufacturer -> Nullable<Text>,
        model -> Nullable<Text>,
        diameter -> Nullable<Float>,
        quantity -> Nullable<Int4>,
        shape -> Nullable<Text>,
        mounted -> Nullable<Bool>,
        localisation -> Int4,
        operatingwavelengthrange -> Nullable<Positive_float_range>,
        color -> Nullable<Text>,
        operatingvoltage -> Nullable<Float>,
        operatingcurrent -> Nullable<Float>,
        maxpower -> Nullable<Float>,
        id -> Int4,
    }
}

table! {
    use diesel::sql_types::*;
    use crate::Positive_float_range;
    lenses (id) {
        manufacturer -> Nullable<Text>,
        model -> Nullable<Text>,
        diameter -> Nullable<Float>,
        quantity -> Nullable<Int4>,
        shape -> Nullable<Text>,
        mounted -> Nullable<Bool>,
        mount_type -> Nullable<Text>,
        localisation -> Int4,
        operatingwavelengthrange -> Nullable<Positive_float_range>,
        model_type -> Nullable<Text>,
        arrange -> Nullable<Positive_float_range>,
        focal_length -> Nullable<Float>,
        id -> Int4,
    }
}

table! {
    lensmount (name) {
        name -> Text,
    }
}

table! {
    lenstype (name) {
        name -> Text,
    }
}

table! {
    localisations (id) {
        id -> Int4,
        localisation -> Nullable<Text>,
        experimenter -> Nullable<Text>,
    }
}

table! {
    manufacturers (name) {
        name -> Text,
    }
}

table! {
    use crate::Positive_float_range;
    use diesel::sql_types::*;
    mirrors (id) {
        manufacturer -> Nullable<Text>,
        model -> Nullable<Text>,
        diameter -> Nullable<Float>,
        quantity -> Nullable<Int4>,
        shape -> Nullable<Text>,
        mounted -> Nullable<Bool>,
        localisation -> Int4,
        operatingwavelengthrange -> Nullable<Positive_float_range>,
        id -> Int4,
    }
}

table! {
use crate::Positive_float_range;
    use diesel::sql_types::*;
    polarizers (id) {
        manufacturer -> Nullable<Text>,
        model -> Nullable<Text>,
        diameter -> Nullable<Float>,
        quantity -> Nullable<Int4>,
        shape -> Nullable<Text>,
        mounted -> Nullable<Bool>,
        localisation -> Nullable<Int4>,
        operatingwavelengthrange -> Nullable<Positive_float_range>,
        model_type -> Nullable<Text>,
        id -> Int4,
    }
}

table! {
    polarizertype (name) {
        name -> Text,
    }
}

table! {
    shapes (name) {
        name -> Text,
    }
}

table! {
    use crate::Positive_float_range;
    use diesel::sql_types::*;
    waveplates (id) {
        manufacturer -> Nullable<Text>,
        model -> Nullable<Text>,
        diameter -> Nullable<Float>,
        quantity -> Nullable<Int4>,
        shape -> Nullable<Text>,
        mounted -> Nullable<Bool>,
        localisation -> Int4,
        operatingwavelengthrange -> Nullable<Positive_float_range>,
        model_type -> Nullable<Text>,
        arrange -> Nullable<Positive_float_range>,
        id -> Int4,
    }
}

table! {
    waveplatetype (name) {
        name -> Text,
    }
}

joinable!(beamsplitters -> beamsplittertype (model_type));
joinable!(beamsplitters -> localisations (localisation));
joinable!(beamsplitters -> manufacturers (manufacturer));
joinable!(beamsplitters -> shapes (shape));
joinable!(filters -> localisations (localisation));
joinable!(filters -> manufacturers (manufacturer));
joinable!(filters -> shapes (shape));
joinable!(lasers -> localisations (localisation));
joinable!(lasers -> manufacturers (manufacturer));
joinable!(lasers -> shapes (shape));
joinable!(leds -> localisations (localisation));
joinable!(leds -> manufacturers (manufacturer));
joinable!(leds -> shapes (shape));
joinable!(lenses -> lensmount (mount_type));
joinable!(lenses -> lenstype (model_type));
joinable!(lenses -> localisations (localisation));
joinable!(lenses -> manufacturers (manufacturer));
joinable!(lenses -> shapes (shape));
joinable!(mirrors -> localisations (localisation));
joinable!(mirrors -> manufacturers (manufacturer));
joinable!(mirrors -> shapes (shape));
joinable!(polarizers -> localisations (localisation));
joinable!(polarizers -> manufacturers (manufacturer));
joinable!(polarizers -> polarizertype (model_type));
joinable!(polarizers -> shapes (shape));
joinable!(waveplates -> localisations (localisation));
joinable!(waveplates -> manufacturers (manufacturer));
joinable!(waveplates -> shapes (shape));
joinable!(waveplates -> waveplatetype (model_type));

allow_tables_to_appear_in_same_query!(
    beamsplitters,
    beamsplittertype,
    filters,
    lasers,
    leds,
    lenses,
    lensmount,
    lenstype,
    localisations,
    manufacturers,
    mirrors,
    polarizers,
    polarizertype,
    shapes,
    waveplates,
    waveplatetype,
);
