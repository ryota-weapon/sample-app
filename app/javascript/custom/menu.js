let addToggleListener = (selected_id, menu_id, toggle_class)=>{
  let target = document.querySelector(`#${selected_id}`);
  target.onclick = (e)=>{
    e.preventDefault();
    let menu = document.querySelector(`#${menu_id}`);
    menu.classList.toggle(`${toggle_class}`);
};
};

document.addEventListener("turbo:load", ()=>{ 
  addToggleListener("account", "dropdown-menu" ,"active");
  addToggleListener("hamburger", "navbar-menu" ,"collapse");
});