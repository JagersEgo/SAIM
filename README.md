```                                          
      _/_/_/    _/_/    _/_/_/  _/      _/   
   _/        _/    _/    _/    _/_/  _/_/    
    _/_/    _/_/_/_/    _/    _/  _/  _/     
       _/  _/    _/    _/    _/      _/      
_/_/_/    _/    _/  _/_/_/  _/      _/                                  
```
![Godot Engine](https://img.shields.io/badge/godotengine-%23478CBF.svg?style=for-the-badge&logo=godotengine&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-%23FCC624.svg?style=for-the-badge&logo=linux&logoColor=black)

SAIM (**S**imple **Aim**) is an intentionally minimal aim trainer built around a few of my simple goals:

- All offline
- Portable binary
- Highly customisable
- High performance, low latency (2000fps on an average setup)
- Linux as first-class platform

## Why?

I was never happy with any of the options for aim trainers right now, most are heavy, slow, and move away from the idea of simply training your aim. That's why I wanted to make one that was just simple, clean and fast

I just wanted it to be: `open, pick a scenario, aim`

 ## Preview:
 
![](.github/screenshot_in_game.png)
![](.github/screenshot_menu.png)

 <img width="540" height="304" alt="output" src="https://github.com/user-attachments/assets/2620f10c-bc9d-442d-bafd-f40b330b7735" />

## Quick start guide

Download and run the latest release on the right ->

Go through menus with `WASD` navigation, `space` for select, `tab/esc` for back

Settings are all changed with ordinary text editors of the `.ini` files stored next to the binary (which are included in the releases)

> Sensitivity is 1:1 with Overwatch, I suggest https://www.mouse-sensitivity.com/ if you want it to be the same as another game 

## Features:

### All config through `.ini` files

I always hated running through settings menus, so all config is done in `.ini` files stored next to the binary. I perfer this system for making settings easier to inspect, edit, back up and share

#### Config explained

The main config files are:

`config.ini` - The core game configuration

`hitmarker.ini` - The configuration for the on-hit/kill effects

`crosshair.ini` - For the static crosshair

`scenario_config/` - Where each scenario's config file goes by name. These will hot-reload when exiting and entering a scenario or pressing `r` (some things may not update)

### Plugins system

The core is intentionally minimal, so you can add more onto it. Plugins currently are GDScript files, which are able to add any functionality Godot engine supports. 

### Performant

Startup time, frame timing, and latency, are high priorities for me, so you can run SAIM with other games running and such, so far I measure a 1 second startup time on my (average) system and 2000 fps. 

The goal of this isn't really for 2000 fps standalone, although that is a plus. It's mainly so it can live while another game is hogging CPU and GPU resources

## Plans for the future:

- Being able to support custom scenarios through drag and drop
	+ Through the engine, relatively straightforward, just needs a bit of time
- Fully customisable everything
	+ Working on hit sounds, target/arena rendering etc.
- Better Wayland support on Linux
	+ Seems currently to be an issue with Godot's wayland especially with high polling rate mice
 implementation (?)
 
**Feel free to message me anything on discord! @`.gov.au`**


