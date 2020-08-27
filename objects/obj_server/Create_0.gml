/// @description Insert description here

//debug("created", instance_number(obj_server));

txt  = ""

if (global.action == "playw"){
	socket = network_create_server(network_socket_tcp, global.port, 1);
	if (socket<0) txt = "server creation failed";
	else txt = "Server created"
} else {
	socket = network_create_socket(network_socket_tcp);
	serverurl = get_string_async("Server URL:", "127.0.0.1");
}

osocket = -1;
oip = -1;

premsg = "";
alpha = 1;
count = 0;
steps = 8;
alpha_delta = 0.08
y_delta = 1;
y_delta_delta = 0.01;