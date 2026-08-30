To export this project there are several steps:

1. Use the Godot exporter excluding:
    - `fake_root/`

2. In the fake root scenarios, manually edit the `.tscn` files as to localise paths, and to remove UIDs for scenario local resources

3. Recombine the folders, so the binary sits in a copy of the fake root
