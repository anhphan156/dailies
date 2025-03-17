use yew::prelude::*;

use dailies::components::card::Card;

#[function_component]
fn App() -> Html {
    html! {<Card/>}
}

fn main() {
    yew::Renderer::<App>::new().render();
}
