var buttons = document.getElementsByClassName("preset-button");

window.onload = function() {
  for (i = 0; i < buttons.length; i++) {
    button = buttons[i];
    element = button.id;
    input = document.getElementById(element + "-input");
    volume = document.getElementById(element + "-volume");
    audio = document.getElementById(element + "-audio");
    icon = document.getElementById(element + "-icon");

    audio.volume = Number((input.value / 100).toFixed(1));
    volume.innerHTML = input.value;
    icon.classList.remove("inactive-sound");

    if (input.value == 0 || input.value == "") {
      volume.innerHTML = "";
      icon.classList.add("inactive-sound");
    }
  }
}

toggle = document.getElementById("toggle-play");
var togglePlay = function() {
  for (i = 0; i < buttons.length; i++) {
    button = buttons[i];
    audio = document.getElementById(button.id + "-audio");
    icon = document.getElementById("toggle-play-icon");

    if (audio.muted) {
      audio.muted = false;
      icon.classList.add("fa-pause");
      icon.classList.remove("fa-play");
    } else {
      audio.muted = true;
      icon.classList.add("fa-play");
      icon.classList.remove("fa-pause");
    }
  }
}
toggle.addEventListener("click", togglePlay);

reset = document.getElementById("reset-all");
var resetAll = function() {
  for (i = 0; i < buttons.length; i++) {
    button = buttons[i];
    audio = document.getElementById(button.id + "-audio");
    audio.pause();
    audio.volume = 0;
    document.getElementById(button.id + "-input").value = 0;
    document.getElementById(button.id + "-volume").innerHTML = "";
    document.getElementById(button.id + "-icon").classList.add("inactive-sound");
  }
}
reset.addEventListener("click", resetAll);

var volumeUp = function() {
  element = this.id;
  input = document.getElementById(element + "-input");
  volume = document.getElementById(element + "-volume");
  audio = document.getElementById(element + "-audio");
  icon = document.getElementById(element + "-icon");

  audio.play();
  input.value = Number(input.value) + 10;
  volume.innerHTML = input.value;
  icon.classList.remove("inactive-sound");

  if (input.value > 100 || input.value < 0) {
    audio.pause();
    input.value = 0;
    volume.innerHTML = "";
    icon.classList.add("inactive-sound");
  }

  audio.volume = Number((input.value / 100).toFixed(1));
}

var volumeDown = function() {
  element = this.id;
  input = document.getElementById(element + "-input");
  volume = document.getElementById(element + "-volume");
  audio = document.getElementById(element + "-audio");
  icon = document.getElementById(element + "-icon");

  audio.play();
  input.value = Number(input.value) - 10;
  volume.innerHTML = input.value;
  icon.classList.remove("inactive-sound");

  if (input.value == 0) {
    audio.pause();
    input.value = 0;
    volume.innerHTML = "";
    icon.classList.add("inactive-sound");
  } else if (input.value < 0) {
    audio.play();
    input.value = 100;
    volume.innerHTML = input.value;
    icon.classList.remove("inactive-sound");
  }

  audio.volume = Number((input.value / 100).toFixed(1));
}

for (i = 0; i < buttons.length; i++) {
  button = buttons[i];
  button.addEventListener("click", volumeUp);
  button.addEventListener("contextmenu", volumeDown);
  button.oncontextmenu = function() {
    return false;
  }
}
