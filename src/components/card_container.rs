use yew::{function_component, html, use_node_ref, Callback, Html};
use web_sys::{WheelEvent, HtmlElement, ScrollToOptions, ScrollBehavior};
use super::card::Card;

#[function_component]
pub fn CardContainer() -> Html {
    let container = use_node_ref();

    let onwheel = {
        let container = container.clone();
        Callback::from(move |e: WheelEvent| {
            e.prevent_default();

            if let Some(container) = container.cast::<HtmlElement>() {
                let scroll_amount = e.delta_y() * 2.0;

                let scroll_options = ScrollToOptions::new();
                scroll_options.set_left(scroll_amount);
                scroll_options.set_behavior(ScrollBehavior::Smooth);

                container.scroll_by_with_scroll_to_options(&scroll_options);
            }
        })
    };

    html! {
        <div class="card-container" ref={container} onwheel={onwheel}>
        {for (0..9).map(|_| html! {
            <Card/>
        })}
        </div>
    }
}
