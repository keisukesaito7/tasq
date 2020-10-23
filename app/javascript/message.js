function message () {
  const url = document.getElementById("message-form").getAttribute("action");
  const submit = document.getElementById("message-submit");

  submit.addEventListener("click", (e)=>{
    const formData = new FormData(document.getElementById("message-form"));
    const XHR = new XMLHttpRequest();
    XHR.open("POST", url, true);
    XHR.responseType = "json";
    XHR.send(formData);

    XHR.onload = () => {
      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText} `);
        return null;
      }
      const message = XHR.response.message;
      const list = document.getElementById("message-list");
      const formText = document.getElementById("message_text");
      const HTML = `
        <li class="message-over-flow-wrap">${message.text}</li>
        `;
      list.insertAdjacentHTML("afterbegin", HTML);
      formText.value = "";
    };
    e.preventDefault();
  });
}

window.addEventListener("load", message);