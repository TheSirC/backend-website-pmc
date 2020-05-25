extern crate proc_macro;

use proc_macro::TokenStream;
use quote::{ quote, format_ident };

#[proc_macro]
pub fn stock_route(input: proc_macro::TokenStream) -> TokenStream {
    let equipment_and_routes: Vec<_> = proc_macro2::TokenStream::from(input).into_iter().filter_map(|variant| match variant {
        proc_macro2::TokenTree::Ident(i) => Some((i.clone(), format!("/{}",i), i.to_string(), format_ident!("get_{}",i))),
        _ => None
    }).collect();
    let iterator = equipment_and_routes.into_iter();
    let equipment = iterator.clone().map(|(ident,_,_,_)| ident).collect::<Vec<_>>();
    let route = iterator.clone().map(|(_,route,_,_)| route).collect::<Vec<_>>();
    let get_name = iterator.clone().map(|(_,_,_,get_method)| get_method).collect::<Vec<_>>();
    let template_name = iterator.map(|(_,_,template,_)| template).collect::<Vec<_>>();
    let generated_code = quote! {
            #(
                use crate::models::#equipment;
                #[get(#route)]
                pub fn #equipment(db_connection: MyPgDatabase) -> Template {
                    Template::render(#template_name,Json(models::#get_name))
                }
            )*
    };
    generated_code.into()
}
