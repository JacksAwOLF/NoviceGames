/// @description Insert description here



osocket = -1;
oip = -1;

// variables for the message popup
txt = "";
premsg = "";
alpha = 1;
count = 0;
steps = 5;
alpha_delta = 0.08
y_delta = 1;
y_delta_delta = 0.01;
die = false;

port = -1;
serverurl = -1;


if (global.action == "server") port = get_string_async("Which port to host on?", "33669");
else serverurl = get_string_async("Server IP address and port?", "73.70.188.126:33669");