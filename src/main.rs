use yew::prelude::*;
use dailies::components::card_container::CardContainer;

#[function_component]
fn App() -> Html {
    html! {
        <div id="main">
            <CardContainer/>
        </div>
    }
}

fn main() {
    yew::Renderer::<App>::new().render();
}
