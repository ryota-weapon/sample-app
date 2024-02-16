document.addEventListener("turbo:load", ()=>{
  document.onchange = (e)=>{
    let image_upload = document.querySelector("#micropost_image");
    const size_in_megabytes = image_upload.files[0].size/1024/1024;
    if (size_in_megabytes > 5){
      alert("too big");
      image_upload.value = ""
    }
  };
});