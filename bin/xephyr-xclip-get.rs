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
	thread::sleep(time::Duration::from_millis(300));

	let window_name = Command::new("xdotool")
			.arg("getactivewindow").arg("getwindowname")
			.output().unwrap().stdout;
	let window_name = String::from_utf8_lossy(&window_name);
	let window_name = window_name.trim();
	println!("current window: {}", window_name);

	let display_list = std::fs::read_dir("/tmp/.X11-unix").unwrap();
	for display_file in display_list {
		let display_file = display_file.unwrap();
		let display_name: String = display_file.file_name()
				.into_string().unwrap()
				.chars().skip(1).collect();
		// println!("{}", display_name);

		if window_name.contains(&display_name)
				&& display_name.len() > 5
				&& display_name.parse::<u32>().is_ok() {
			display_name.parse::<u32>().unwrap();

			println!("Found appropriate display: {}", display_name);

			let output = Command::new("xclip")
					.arg("-selection").arg("XA_SECONDARY")
					.arg("-o")
					.env("DISPLAY", format!(":{}", display_name))
					.output().unwrap();
			assert!(output.status.success());
			let output = String::from_utf8_lossy(&output.stdout);
			println!("Input: {:?}", output);

			let put_command = Command::new("xclip")
					.arg("-selection").arg("XA_SECONDARY")
					.stdin(Stdio::piped())
					.spawn().unwrap();
			write!(put_command.stdin.unwrap(), "{}", output).unwrap();
		}
	}
}
