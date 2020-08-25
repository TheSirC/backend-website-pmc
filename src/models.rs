#![allow(non_camel_case_types)]
use crate::diesel::Queryable;
use crate::serde::{Serialize,Deserialize};

#[derive(Queryable, Serialize, Deserialize)]
pub struct beamsplitters {
    manufacturer: Option<String>,
    model: Option<String>,
    diameter: Option<f64>,
    quantity: Option<i32>,
    shape: Option<String>,
    mounted: Option<bool>,
    polarising: Option<bool>,
    localisation: i32,
    lower_operatingwavelengthrange_bound: Option<f32>,
    upper_operatingwavelengthrange_bound: Option<f32>,
    model_type: Option<String>,
    lower_arrange_bound: Option<f32>,
    upper_arrange_bound: Option<f32>,
    reflectance: Option<i32>,
    transmittance: Option<i32>,
    thickness: Option<f64>,
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
    diameter: Option<f64>,
    quantity: i32,
    shape: Option<String>,
    mounted: Option<bool>,
    localisation: i32,
    lower_operatingwavelengthrange_bound: Option<f32>,
    upper_operatingwavelengthrange_bound: Option<f32>,
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
    maxpower: Option<f64>,
    voltage: Option<f64>,
    wavelength: Option<f64>,
    id: i32,
}

#[derive(Queryable, Serialize, Deserialize)]
pub struct leds {
    manufacturer: Option<String>,
    model: Option<String>,
    diameter: Option<f64>,
    quantity: Option<i32>,
    shape: Option<String>,
    mounted: Option<bool>,
    localisation: i32,
    lower_operatingwavelengthrange_bound: Option<f32>,
    upper_operatingwavelengthrange_bound: Option<f32>,
    color: Option<String>,
    operatingvoltage: Option<f64>,
    operatingcurrent: Option<f64>,
    maxpower: Option<f32>,
    id: i32,
}

#[derive(Queryable, Serialize, Deserialize)]
pub struct lenses {
    manufacturer: Option<String>,
    model: Option<String>,
    diameter: Option<f64>,
    quantity: Option<i32>,
    shape: Option<String>,
    mounted: Option<bool>,
    mount_type: Option<String>,
    localisation: i32,
    lower_operatingwavelengthrange_bound: Option<f32>,
    upper_operatingwavelengthrange_bound: Option<f32>,
    model_type: Option<String>,
    lower_arrange_bound: Option<f32>,
    upper_arrange_bound: Option<f32>,
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
    id: i32,
    localisation: Option<String>,
    experimenter: Option<String>,
}

#[derive(Queryable, Serialize, Deserialize)]
pub struct manufacturers {
    name: String,
}

#[derive(Queryable, Serialize, Deserialize)]
pub struct mirrors {
    manufacturer: Option<String>,
    model: Option<String>,
    diameter: Option<f64>,
    quantity: Option<i32>,
    shape: Option<String>,
    mounted: Option<bool>,
    localisation: i32,
    lower_operatingwavelengthrange_bound: Option<f32>,
    upper_operatingwavelengthrange_bound: Option<f32>,
    id: i32,
}

#[derive(Queryable, Serialize, Deserialize)]
pub struct polarizers {
    manufacturer: Option<String>,
    model: Option<String>,
    diameter: Option<f64>,
    quantity: Option<i32>,
    shape: Option<String>,
    mounted: Option<bool>,
    localisation: Option<i32>,
    lower_operatingwavelengthrange_bound: Option<f32>,
    upper_operatingwavelengthrange_bound: Option<f32>,
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
    diameter: Option<f64>,
    quantity: Option<i32>,
    shape: Option<String>,
    mounted: Option<bool>,
    localisation: i32,
    lower_operatingwavelengthrange_bound: Option<f32>,
    upper_operatingwavelengthrange_bound: Option<f32>,
    model_type: Option<String>,
    lower_arrange_bound: Option<f32>,
    upper_arrange_bound: Option<f32>,
    id: i32,
}

#[derive(Queryable, Serialize, Deserialize)]
pub struct waveplatetype {
    name: String,
}
