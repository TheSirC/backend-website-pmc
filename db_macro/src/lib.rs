extern crate proc_macro;
use syn::{Ident, Token, punctuated::Punctuated, parse::Parser };
use std::iter::FromIterator;
use proc_macro::TokenStream;
use quote::{ quote, format_ident };

#[proc_macro]
pub fn stock_route(input: TokenStream) -> TokenStream {
    let parser = Punctuated::<Ident, Token![,]>::parse_separated_nonempty;
    let equipments = parser.parse(input).expect( "Something wih the parser failed successfully!" );
    let mut generated_code : Vec<TokenStream> = Vec::new();
    for equipment in equipments.into_iter() {
        let route = format!("/{}",equipment);
        let template_name = equipment.to_string();
        let get_name = format_ident!("get_{}",equipment);
        let code = quote! {
                use crate::models::#equipment;
                use crate::db::#get_name;
                #[get(#route)]
                pub fn #equipment(db_connection: MyPgDatabase) -> Template {
                    Template::render(#template_name,database_response{rows:#get_name(&db_connection)})
                }
    };
    generated_code.push(code.into());
    }
    TokenStream::from_iter(generated_code.into_iter())
}
