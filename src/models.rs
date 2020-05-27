#![allow(non_camel_case_types)]
use crate::bigdecimal::BigDecimal;
use crate::diesel::Queryable;
use crate::serde::{Serialize,Deserialize};
use std::ops::Bound;

#[derive(Queryable, Serialize, Deserialize)]
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

#[derive(Queryable, Serialize, Deserialize)]
pub struct beamsplittertype {
    name: String,
}

#[derive(Queryable, Serialize, Deserialize)]
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

#[derive(Queryable, Serialize, Deserialize)]
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

#[derive(Queryable, Serialize, Deserialize)]
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

#[derive(Queryable, Serialize, Deserialize)]
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

#[derive(Queryable, Serialize, Deserialize)]
pub struct lensMount {
    name: String,
}

#[derive(Queryable, Serialize, Deserialize)]
pub struct lenstype {
    name: String,
}

#[derive(Queryable, Serialize, Deserialize)]
pub struct localisations {
    name: String,
}

#[derive(Queryable, Serialize, Deserialize)]
pub struct manufacturers {
    name: String,
}

#[derive(Queryable, Serialize, Deserialize)]
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

#[derive(Queryable, Serialize, Deserialize)]
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

#[derive(Queryable, Serialize, Deserialize)]
pub struct polarizertype {
    name: String,
}

#[derive(Queryable, Serialize, Deserialize)]
pub struct shapes {
    name: String,
}

#[derive(Queryable, Serialize, Deserialize)]
pub struct waveplates {
    manufacturer: Option<String>,
    model: Option<String>,
    diameter: Option<f32>,
    quantity: Option<i32>,
    shape: Option<String>,
    mounted: Option<bool>,
    localisation: i32,
    operatingwavelengthrange:
        Option<(Bound<bigdecimal::BigDecimal>, Bound<bigdecimal::BigDecimal>)>,
    model_type: Option<String>,
    arrange: Option<(Bound<bigdecimal::BigDecimal>, Bound<bigdecimal::BigDecimal>)>,
    id: i32,
}

#[derive(Queryable, Serialize, Deserialize)]
pub struct waveplatetype {
    name: String,
}
