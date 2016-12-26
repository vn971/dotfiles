About
==

This repo is a collection of Vasya Novikov's helper utils, configs and other stuff used daily.

Feel free to question / comment / discuss any files. Parts marked with "vn971" are specific to me, like the "colemak" keyboard layout I use, but 95% of the stuff is general-purpose.


Overview - X11 isolation
==
The goal is to work with X11-isolated apps. See scripts `xepsource.sh`, `xepin` and `in_xephyr.sh` to see how it can be done using Xephyr. See usage example `ff-profile.sh` (launches X11-isolated firefox). Underlying it's just Xephyr, but Xephyr itself may be too verbose to work with directly.


Overview - firejail
==
Firejail is a process isolation tool. Most of the scripts in the repo make use of it where appropriate. See also the config dir with some of the profiles.

Other configs
==
TODO


License
==

Licensed under either of

 * Apache License, Version 2.0, https://www.apache.org/licenses/LICENSE-2.0
 * MIT license https://opensource.org/licenses/MIT

at your option.

### Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall be dual licensed as above, without any
additional terms or conditions.
