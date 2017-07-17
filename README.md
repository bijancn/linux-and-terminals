# Linux and terminals
## From Zero to Hero - Lectures and Exercises
### Startup instructions

To setup the environment, please login with xterm (or in a terminal in
one of the graphic interfaces) and enter these commands
```
  wget https://bijancn.github.io/linux-and-terminals/setup-environment.sh
  chmod +x setup-environment.sh
  ./setup-environment.sh
  # Execute the command that the script tells you
```

To edit and run scripts side by side (after setting up the environment),
start
```
  tmux
```
and use the following controls:
- `CTRL-A C` (dont hold `CTRL` for the `C`) create a new tab
- `CTRL-A X` close window (you have to confirm with `y`, check the
    statusline)
- `CTRL-A n` go to the window number `n` (they range from 0-9 and are
    shown in the statusline)
- `CTRL-A |` split the window vertically
- `CTRL-A -` split the window horizontically
- `ALT-UpArrow` Go to upper split
- `ALT-DownArrow` Go to lower split
- `ALT-LeftArrow` Go to next left split
- `ALT-RightArrow` Go to next right split
- `CTRL-A CTRL-A` (this time, you want `CTRL` also for the second `A`)
  switch to last opened window (doesn't switch between splits)

### Editors
You can use `emacs` or `vim` *if you are familiar with them already*.
They a bit harder to learn and I don't have the time to explain them.
(It is highly recommended, though, that you learn one of them after the
course)

There are also easier editors installed: `nano` and `mcedit`. I
recommend `nano`. Just write as in a notepad and save with `CTRL-O` (its
also shown in the bottom of the window), then type in the filename and
confirm with `ENTER`. You can exit with `CTRL-X` (will also ask to save
changes). You open an existing (or new) file with `nano myfile`.

When you use a graphical interface, you can also use `gedit` or another
editor you are familiar with.

### Further links
- The [lecture slides](./lectures)
- Our [chat room](https://public.etherpad-mozilla.org/p/Linux-and-Terminals-DESY-2017-07) where you can share infos
- The [lecture slides from the course on
    2017-06-13](./lectures_2017-06-13)
