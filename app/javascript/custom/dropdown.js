function toggleDropdown() {
  console.log('toggle');
  document.getElementById('dropdown-button')
}

window.onclick = function(event) {
  if (event.target.matches('.dropbtn'))
    return;

  var dropdownContent = document.getElementsByClassName('dropdown-menu');
  for (var i = 0; i < dropdownContent.length; i++) {
    var openDropdown = dropdownContent[i];
    if (openDropdown.classList.contains('show')) {
      openDropdown.classList.remove('show');
    }
  }
}
