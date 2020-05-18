#![allow(non_camel_case_types)]
use rocket_contrib::databases::diesel::{ Queryable, sql_types::*};

#[derive(Queryable)]
pub struct manufacturers {
    name: String
}

#[derive(Queryable)]
pub struct lensMount {
    name: String
}

#[derive(Queryable)]
pub struct shapes {
    name: String
}

#[derive(Queryable)]
pub struct filtertype {
    name: String
}

#[derive(Queryable)]
pub struct polarizertype {
    name: String
}

#[derive(Queryable)]
pub struct lenstype {
    name: String
}

#[derive(Queryable)]
pub struct waveplatetype {
    name: String
}

#[derive(Queryable)]
pub struct beamsplittertype {
    name: String
}

#[derive(Queryable)]
pub struct localisations {
    name: String
}

#[derive(Queryable)]
pub struct leds {
        manufacturer: Option<String>,
        model: Option<String>,
        diameter: Option<f64>,
        quantity: Option<i32>,
        shape: Option<String>,
        mounted: Option<bool>,
        localisation: i32,
        operatingwavelengthrange: Option<Range<Float8>>,
        color: Option<String>,
        operatingvoltage: Option<f64>,
        operatingcurrent: Option<f64>,
        maxpower: Option<f32>,
        id: i32,
}

#[derive(Queryable)]
pub struct lasers {
        manufacturer: Option<String>,
        model: Option<String>,
        quantity: Option<i32>,
        shape: Option<String>,
        mounted: Option<bool>,
        localisation: i32,
        maxpower: Option<f64>,
        voltage: Option<f64>,
        wavelength: Option<f64>,
        id: i32,
}

#[derive(Queryable)]
pub struct filters {
        manufacturer: Option<String>,
        model: Option<String>,
        diameter: Option<f64>,
        quantity: i32,
        shape: Option<String>,
        mounted: Option<bool>,
        localisation: i32,
        operatingwavelengthrange: Option<Range<Float8>>,
        adjustable: Option<bool>,
        id: i32,
}

#[derive(Queryable)]
pub struct lenses {
        manufacturer: Option<String>,
        model: Option<String>,
        diameter: Option<f64>,
        quantity: Option<i32>,
        shape: Option<String>,
        mounted: Option<bool>,
        mount_type: Option<String>,
        localisation: i32,
        operatingwavelengthrange: Option<Range<Float8>>,
        model_type: Option<String>,
        arrange: Option<Range<Float8>>,
        focal_length: Option<f32>,
        id: i32,
}

#[derive(Queryable)]
pub struct mirrors {
        manufacturer: Option<String>,
        model: Option<String>,
        diameter: Option<f64>,
        quantity: Option<i32>,
        shape: Option<String>,
        mounted: Option<bool>,
        localisation: i32,
        operatingwavelengthrange: Option<Range<Float8>>,
        id: i32,
}

#[derive(Queryable)]
pub struct polarizers {
        manufacturer: Option<String>,
        model: Option<String>,
        diameter: Option<f64>,
        quantity: Option<i32>,
        shape: Option<String>,
        mounted: Option<bool>,
        localisation: Option<i32>,
        operatingwavelengthrange: Option<Range<Float8>>,
        model_type: Option<String>,
        id: i32,
}

#[derive(Queryable)]
pub struct waveplates {
        name: String,
}

#[derive(Queryable)]
pub struct beamsplitters {
        manufacturer: Option<String>,
        model: Option<String>,
        diameter: Option<f64>,
        quantity: Option<i32>,
        shape: Option<String>,
        mounted: Option<bool>,
        polarising: Option<bool>,
        localisation: i32,
        operatingwavelengthrange: Option<Range<Float8>>,
        model_type: Option<String>,
        arrange: Option<Range<Float8>>,
        reflectance: Option<i32>,
        transmittance: Option<i32>,
        thickness: Option<f64>,
        id: i32,
}
