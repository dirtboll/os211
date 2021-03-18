var mode = getCookie("mode")
document.getElementById("chk").checked = !(mode == "white")
document.getElementsByTagName("body")[0].className = mode == "white" ? "white" : "dark"
function flip() {
  let mode = getCookie("mode") == "white" ? "dark" : "white";
  document.getElementsByTagName("body")[0].className = mode;
  document.cookie = "mode="+mode;
}
function getCookie(coo) {
  let re = null
  document.cookie.split(";").forEach(el => {
    let c = el.split("=")
    if (c[0] == coo) {
      re = c[1]
      return
    }
  })
  return re
}