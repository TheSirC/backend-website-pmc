table! {
    beamsplitters (id) {
        manufacturer -> Nullable<Text>,
        model -> Nullable<Text>,
        diameter -> Nullable<Float8>,
        quantity -> Nullable<Int4>,
        shape -> Nullable<Text>,
        mounted -> Nullable<Bool>,
        polarising -> Nullable<Bool>,
        localisation -> Int4,
        operatingwavelengthrange -> Nullable<Range<Float8>>,
        model_type -> Nullable<Text>,
        arrange -> Nullable<Range<Float8>>,
        reflectance -> Nullable<Int4>,
        transmittance -> Nullable<Int4>,
        thickness -> Nullable<Float8>,
        id -> Int4,
    }
}

table! {
    beamsplittertype (name) {
        name -> Text,
    }
}

table! {
    filters (id) {
        manufacturer -> Nullable<Text>,
        model -> Nullable<Text>,
        diameter -> Nullable<Float8>,
        quantity -> Int4,
        shape -> Nullable<Text>,
        mounted -> Nullable<Bool>,
        localisation -> Int4,
        operatingwavelengthrange -> Nullable<Range<Float8>>,
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
        maxpower -> Nullable<Float8>,
        voltage -> Nullable<Float8>,
        wavelength -> Nullable<Float8>,
        id -> Int4,
    }
}

table! {
    leds (id) {
        manufacturer -> Nullable<Text>,
        model -> Nullable<Text>,
        diameter -> Nullable<Float8>,
        quantity -> Nullable<Int4>,
        shape -> Nullable<Text>,
        mounted -> Nullable<Bool>,
        localisation -> Int4,
        operatingwavelengthrange -> Nullable<Range<Float8>>,
        color -> Nullable<Text>,
        operatingvoltage -> Nullable<Float8>,
        operatingcurrent -> Nullable<Float8>,
        maxpower -> Nullable<Float4>,
        id -> Int4,
    }
}

table! {
    lenses (id) {
        manufacturer -> Nullable<Text>,
        model -> Nullable<Text>,
        diameter -> Nullable<Float8>,
        quantity -> Nullable<Int4>,
        shape -> Nullable<Text>,
        mounted -> Nullable<Bool>,
        mount_type -> Nullable<Text>,
        localisation -> Int4,
        operatingwavelengthrange -> Nullable<Range<Float8>>,
        model_type -> Nullable<Text>,
        arrange -> Nullable<Range<Float8>>,
        focal_length -> Nullable<Float4>,
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
    mirrors (id) {
        manufacturer -> Nullable<Text>,
        model -> Nullable<Text>,
        diameter -> Nullable<Float8>,
        quantity -> Nullable<Int4>,
        shape -> Nullable<Text>,
        mounted -> Nullable<Bool>,
        localisation -> Int4,
        operatingwavelengthrange -> Nullable<Range<Float8>>,
        id -> Int4,
    }
}

table! {
    polarizers (id) {
        manufacturer -> Nullable<Text>,
        model -> Nullable<Text>,
        diameter -> Nullable<Float8>,
        quantity -> Nullable<Int4>,
        shape -> Nullable<Text>,
        mounted -> Nullable<Bool>,
        localisation -> Nullable<Int4>,
        operatingwavelengthrange -> Nullable<Range<Float8>>,
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
    waveplates (id) {
        manufacturer -> Nullable<Text>,
        model -> Nullable<Text>,
        diameter -> Nullable<Float8>,
        quantity -> Nullable<Int4>,
        shape -> Nullable<Text>,
        mounted -> Nullable<Bool>,
        localisation -> Int4,
        operatingwavelengthrange -> Nullable<Range<Float8>>,
        model_type -> Nullable<Text>,
        arrange -> Nullable<Range<Float8>>,
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
