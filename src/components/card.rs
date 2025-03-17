use yew::{function_component, html, use_state, Callback, Html};

#[function_component]
pub fn Card() -> Html {
    let is_done = use_state(|| false);
    let onclick = {
        let prev = *is_done;
        let is_done = is_done.clone();
        Callback::from(move |_| is_done.set(!prev))
    };
    let lorem = "Veritatis totam provident at commodi minima. Quis voluptate odit dolores blanditiis. Sit velit modi fuga beatae tempora quo voluptas necessitatibus. Odit nesciunt modi laborum modi voluptas. Nesciunt omnis exercitationem ut officiis cum.";
    html! {
        <div class="card">
            <p class="red">{"Title "}</p>
            <p>{if *is_done { "done" } else { lorem } }</p>
            <button {onclick}>{"click me baby"}</button>
        </div>
    }
}
