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

### Further links
- The [lecture slides](./lectures)
- The [lecture slides from the course on
    2017-06-13](./lectures_2017-06-13)
