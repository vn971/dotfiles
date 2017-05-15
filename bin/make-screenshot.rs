#!/usr/bin/env run-cargo-script

use std::io::prelude::*;
use std::process::Command;
use std::process::Stdio;
use std::{thread, time};

// Vasya Novikov's personal script, makes little sense outside of my computer...
//
// Note: this script is written to get some additional familiarity with Rust.
// If you want something practical (time-effective, 1/4 LoC), consider using Bash.
fn main() {
//	thread::sleep(time::Duration::from_millis(200));
	std::env::set_var("DISPLAY", ":0");
	std::env::set_var("DBUS_SESSION_BUS_ADDRESS", "unix:path=/run/user/1000/bus");
	println!("script launched, args: {:?}", std::env::args().skip(1).collect::<String>());

	let idle_time: u64 = {
		let idle_time = Command::new("xprintidle").output().unwrap();
		assert!(idle_time.status.success());
		let idle_time = String::from_utf8(idle_time.stdout).unwrap();
		let idle_time = idle_time.trim();
		println!("xprintidle string: {}", idle_time);
		idle_time.parse::<u64>().unwrap()
	};
	println!("idle_time: {}", idle_time);

	let window_name = {
		let command = Command::new("xdotool").arg("getactivewindow").arg("get_desktop").arg("getwindowname").output().unwrap();
		assert!(command.status.success());
		let s = String::from_utf8(command.stdout).unwrap();
		s
//		let ss = s.trim();
	};
	println!("window_name: {}", window_name);

	println!("idle_time: {}", idle_time);


	//	let command = Command::new("xprintidle").output().unwrap();

//	let window_name = Command::new("xdotool")
//			.arg("getactivewindow").arg("getwindowname")
//			.output().unwrap().stdout;
//	let window_name = String::from_utf8_lossy(&window_name);
//	let window_name = window_name.trim();
//	println!("current window: {}", window_name);

}
