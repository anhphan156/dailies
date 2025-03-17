use yew::{function_component, html, use_state, Callback, Html};

#[function_component]
pub fn Card() -> Html {
    let is_done = use_state(|| false);
    let onclick = {
        let prev = *is_done;
        let is_done = is_done.clone();
        Callback::from(move |_| is_done.set(!prev))
    };
    html! {
        <div>
            <p class="red">{"Title "}</p>
            <p>{if *is_done { "done" } else { "not done" } }</p>
            <button {onclick}>{"click me baby"}</button>
        </div>
    }
}
