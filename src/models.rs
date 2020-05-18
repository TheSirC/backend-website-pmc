#![allow(non_camel_case_types)]
use crate::bigdecimal::BigDecimal;
use crate::diesel::Queryable;
use std::ops::Bound;

#[derive(Queryable)]
pub struct manufacturers {
    name: String,
}

#[derive(Queryable)]
pub struct lensMount {
    name: String,
}

#[derive(Queryable)]
pub struct shapes {
    name: String,
}

#[derive(Queryable)]
pub struct filtertype {
    name: String,
}

#[derive(Queryable)]
pub struct polarizertype {
    name: String,
}

#[derive(Queryable)]
pub struct lenstype {
    name: String,
}

#[derive(Queryable)]
pub struct waveplatetype {
    name: String,
}

#[derive(Queryable)]
pub struct beamsplittertype {
    name: String,
}

#[derive(Queryable)]
pub struct localisations {
    name: String,
}

#[derive(Queryable)]
pub struct leds {
    manufacturer: Option<String>,
    model: Option<String>,
    diameter: Option<f32>,
    quantity: Option<i32>,
    shape: Option<String>,
    mounted: Option<bool>,
    localisation: i32,
    operatingwavelengthrange:
        Option<(Bound<bigdecimal::BigDecimal>, Bound<bigdecimal::BigDecimal>)>,
    color: Option<String>,
    operatingvoltage: Option<f32>,
    operatingcurrent: Option<f32>,
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
    maxpower: Option<f32>,
    voltage: Option<f32>,
    wavelength: Option<f32>,
    id: i32,
}

#[derive(Queryable)]
pub struct filters {
    manufacturer: Option<String>,
    model: Option<String>,
    diameter: Option<f32>,
    quantity: i32,
    shape: Option<String>,
    mounted: Option<bool>,
    localisation: i32,
    operatingwavelengthrange:
        Option<(Bound<bigdecimal::BigDecimal>, Bound<bigdecimal::BigDecimal>)>,
    adjustable: Option<bool>,
    id: i32,
}

#[derive(Queryable)]
pub struct lenses {
    manufacturer: Option<String>,
    model: Option<String>,
    diameter: Option<f32>,
    quantity: Option<i32>,
    shape: Option<String>,
    mounted: Option<bool>,
    mount_type: Option<String>,
    localisation: i32,
    operatingwavelengthrange:
        Option<(Bound<bigdecimal::BigDecimal>, Bound<bigdecimal::BigDecimal>)>,
    model_type: Option<String>,
    arrange: Option<(Bound<bigdecimal::BigDecimal>, Bound<bigdecimal::BigDecimal>)>,
    focal_length: Option<f32>,
    id: i32,
}

#[derive(Queryable)]
pub struct mirrors {
    manufacturer: Option<String>,
    model: Option<String>,
    diameter: Option<f32>,
    quantity: Option<i32>,
    shape: Option<String>,
    mounted: Option<bool>,
    localisation: i32,
    operatingwavelengthrange:
        Option<(Bound<bigdecimal::BigDecimal>, Bound<bigdecimal::BigDecimal>)>,
    id: i32,
}

#[derive(Queryable)]
pub struct polarizers {
    manufacturer: Option<String>,
    model: Option<String>,
    diameter: Option<f32>,
    quantity: Option<i32>,
    shape: Option<String>,
    mounted: Option<bool>,
    localisation: Option<i32>,
    operatingwavelengthrange:
        Option<(Bound<bigdecimal::BigDecimal>, Bound<bigdecimal::BigDecimal>)>,
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
    diameter: Option<f32>,
    quantity: Option<i32>,
    shape: Option<String>,
    mounted: Option<bool>,
    polarising: Option<bool>,
    localisation: i32,
    operatingwavelengthrange:
        Option<(Bound<bigdecimal::BigDecimal>, Bound<bigdecimal::BigDecimal>)>,
    model_type: Option<String>,
    arrange: Option<(Bound<bigdecimal::BigDecimal>, Bound<bigdecimal::BigDecimal>)>,
    reflectance: Option<i32>,
    transmittance: Option<i32>,
    thickness: Option<f32>,
    id: i32,
}
