Linux and Terminals
========================================================================
Bijan Chokoufe Nejad <!-- .element: class="fragment" -->
From Zero to Hero <!-- .element: class="fragment" -->
-----

<img src="images/noob.jpg" width="200"> <!-- .element: class="fragment" -->
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<img src="images/code-ninja.jpg" width="200"> <!-- .element: class="fragment" -->

June 13, 2017

Note:
- Welcome everyone
- Say who you are (PhD Student, over 3 years @DESY, worked over 4 years
  exclusively on Linux only)

---
Session overview
------------------------------------------------------------------------
1. <mark>Intro, Linux basics</mark>
2. File management in the terminal
3. Combine simple commands
4. One liners (going beyond pipes)
5. Regular Expressions
6. Bash scripting
7. Makefiles
8. Git
9. DESY IT (Sven Sternberger)
10. Bonus: Tips and Tricks for Customization
Note:
- Say that I will talk a bit and then we dive into excercises
- Everyone noted at least basic programming skills

---
Linux history
------------------------------------------------------------------------
<div id="left-big">
<mark>Linux</mark> (a.k.a. <mark>GNU/Linux</mark>) was first released by
<mark>Linus Torvalds</mark> in <mark>September 17, 1991</mark>.
</div>

<div id="right-small">
<img src="images/Linux_boot.jpg" width="70%">
</div>

> I'm doing a (free) operating system (just a hobby, won't be big and
> professional like gnu) for 386(486) AT clones. [...]
> It is NOT protable (uses 386 task switching etc), and it probably
> never will support anything other than AT-harddisks, as that's all I
> have :-(.

Note:
- So Linux was just hacking an operating system on the only machine he
  had access to
- The idea of a free OS caught on massively and countless people
  contributed

===
Linux history
------------------------------------------------------------------------
<br>
<div id="left-big">
  Many more <mark>anecdotes</mark> on how Linux was created can be found in the
  autobiography of Linus
</div>
<div id="right-small">
    <img src="images/Linus.jpg" width="45%">
    <img src="images/Just_for_Fun_cover.jpg" width="45%">
</div>

Note:
- If you linke anecdotes, I can highly recommend the book
- Some weird view points but very entertaining and informative

===
### Nowadays, Linux runs (almost) everywhere ###
<img src="images/Linux_kernel.svg" width="100%">

===
Unix ancestry
------------------------------------------------------------------------
<div id="left-big">
  <img src="images/Unix_timeline.svg" width="100%">
</div>
<div id="right-small" style="font-size:smaller">
  <p>
  Many similarities, especially through `POSIX`, `SUS`, `LSB`, `ISO` and
  `ANSI` standards
  </p> <!-- .element: class="fragment" -->
  <br>
  <p>
  Thus, at its core, `macOS` and `Linux` are fairly similar.
  </p> <!-- .element: class="fragment" -->
  <br>
  <img src="images/DevilIsInTheDetails.jpg" width="50%"> <!-- .element: class="fragment" -->
</div>

Note:
- Tell story about `sed -i`

---
Linux distributions
------------------------------------------------------------------------
In a distribution, you not only get the <mark>Linux kernel</mark> but
various <mark>software</mark> and usually have a <mark>package
manager</mark> as well as a default <mark>graphical interface</mark>
<br><br>

<p>Well known distributions are `Debian`, `Ubuntu`, `Red Hat`, `Fedora`,
`SUSE`, `Gentoo`, `Arch` and `Scientific Linux`
</p> <!-- .element: class="fragment" -->
<br><br>

<p>At <mark>DESY</mark>, we currently have `Ubuntu 14.04/16.04` (based
on `Debian`) and `Scientific Linux` (based on `Red Hat`)
</p><!-- .element: class="fragment" -->

===
Flavor of the month?
------------------------------------------------------------------------
<img src="images/top-10-linux-distributions-2016.jpg" width="80%">

(according to <mark>distrowatch</mark>, not really representative)

===
Handy guide to decide
------------------------------------------------------------------------
<img src="images/LinuxBeards.jpg" width="70%">

===
So what distro are you currently on?
========================================================================

<br>

```bash
  lsb_release -a
  # No LSB modules are available.
  # Distributor ID: elementary
  # Description:    elementary OS 0.4.1 Loki
  # Release:        0.4.1
  # Codename:       loki
```
<!-- .element: class="fragment" -->

===
Packet Managers
------------------------------------------------------------------------
<p>
  Maybe the most important aspect of a distribution apart from the
  <mark>community</mark> (size, friendlyness, competence)
</p><!-- .element: class="fragment" -->

<p>
  Packet managers are designed to <br>
  make dealing with software <mark>easy</mark>
</p><!-- .element: class="fragment" -->

<p>
  They have means to <mark>install</mark>, <mark>update</mark> and
  <mark>remove</mark>, <br> while respecting <mark>dependencies</mark>.
</p><!-- .element: class="fragment" -->

<p>
  A dependency is not only a certain program or library but also the
  respective <mark>version number</mark> and installations can fail when
  dependencies collide (<mark>dependency hell</mark>)
</p><!-- .element: class="fragment" -->

Note:
- respecting means they automatically install or remove as long as the
    dependency needed

===
Packet Managers
------------------------------------------------------------------------
You might know `apt(-get)` (Ubuntu & Debian) others are `rpm/yum`, `zypper`,
`pacman` or `portage`.

<br>

<div>
Related to the package manager are
- <mark>support cycles</mark> for security fixes (from months to years)
- <mark>stability</mark> (can an update break my system?)
- <mark>up-to-dateness</mark> (how often do I get new major versions?)
</div><!-- .element: class="fragment" -->

---
Interfaces
------------------------------------------------------------------------
<img src="images/Apple_Macintosh_mouse.jpg" width="40%">
<img src="images/graphical.interfaces.jpeg" width="57%">

Ever since the <mark>Macintosh of 1984</mark>, the <mark>mouse</mark>
and <mark>graphical interfaces</mark> are considered the simplest
interface

<p>
  But is it the <mark>most efficient</mark> for <mark>complex tasks</mark>?
</p><!-- .element: class="fragment" -->

Note:
- How do we interact with computers?
- Nowadays we are used to interact with computers via graphical
  interfaces
- Most often with a mouse

===
Enter the Terminal
------------------------------------------------------------------------
<div id="left">
A terminal is a <mark>device</mark> to
<br>
<ul>
<li> <mark>enter data into</mark></li>
<li> <mark>display data from</mark></li>
</ul>
a computer/computing system
<br><br>

<p>
  Nowadays, we usually have multiple <mark>virtual consoles</mark> or
  <mark>terminal emulators</mark>
</p><!-- .element: class="fragment" -->
</div>
<div id="right">
  <img src="images/DEC_VT100_terminal.jpg" width="100%">
</div>

Note:
- Showcase CTRL-ALT-F1 and multiple terminals

===
So what is a shell?
------------------------------------------------------------------------
<p>
  The <mark>shell</mark> is <mark>a layer around</mark> the
  <mark>operating system kernel</mark>
</p><!-- .element: class="fragment" -->
<br>

<p>
  Both command-line interfaces (<mark>CLI</mark>) as well as <br>
  graphical user interfaces (<mark>GUI</mark>) can be shells
</p><!-- .element: class="fragment" -->
<br>

<p>
  Informally, we usually mean CLI shells when we say shell
</p><!-- .element: class="fragment" -->
<br>

<p>
  We will work with the `bash` shell for simplicity <br>
  (but `zsh` is highly recommended later on)
</p><!-- .element: class="fragment" -->

Note:
- Don't worry, almost everything works the same in bash and zsh. zsh
  just has more extra goodies


===
Command prompt
------------------------------------------------------------------------
The first thing you see, is called <mark>prompt</mark> and <br>
often shows something like
  ```bash
  <username>@<machinename>:<present directory>
  ```
<br>
<div>
  You can customize the prompt by modifying <br>
  the <mark>environment variable</mark> `PS1`
  ```bash
  PS1=YOLO
  ```
</div><!-- .element: class="fragment" -->

---
What else can the shell do?
------------------------------------------------------------------------
<p>
  Time to play around!
</p><!-- .element: class="fragment" -->
<br>
<div>
  ```bash
  echo 'Hello World!'
  # Hello World!
  ```
</div><!-- .element: class="fragment" -->
<div>
  ```bash
  me=Bijan
  echo $me
  # Bijan
  ```
</div><!-- .element: class="fragment" -->
<div>
  ```bash
  echo "Hello $me!"
  # Hello Bijan!
  ```
</div><!-- .element: class="fragment" -->

===
Aliases
------------------------------------------------------------------------
Aliases allow a string to be substituted for a word when it is used as
the <mark>first word</mark> of a command

<div>
  ```bash
  alias
  #
  alias x=exit
  alias
  # alias x='exit'
  unalias x
  alias
  ```
</div><!-- .element: class="fragment" -->
<div>
  So aliases can still take arguments
</div><!-- .element: class="fragment" -->
<div>
  ```bash
  alias e=echo
  e hello
  # hello
  ```
</div><!-- .element: class="fragment" -->

Note:
- Everyone still with me? :)

===
Aliases
------------------------------------------------------------------------
But aliases can not be used as argument
<div>
  ```bash
  alias h=hello
  e h
  # h
  ```
</div><!-- .element: class="fragment" -->
<div>
Aliases are not recursively expanded
</div><!-- .element: class="fragment" -->
<div>
  ```bash
  ls
  # ...
  alias ls='ls --color'
  ls
  # ...
  ```
</div><!-- .element: class="fragment" -->

===
Sourcing
------------------------------------------------------------------------
Read and execute commands from `filename` argument given to `source`
<div>
  ```bash
  source ~/.bashrc
  . ~/.bashrc
  ```
</div><!-- .element: class="fragment" -->
<div>
You can source any file. The Intel compiler can be loaded at DESY e.g. with
  ```bash
  source /opt/intel/bin/compilervars.sh intel64
  ```
</div><!-- .element: class="fragment" -->
<div>
  The `.bashrc` is somewhat special as it is *usually* loaded by default
  (if not -> modify `.bash_profile` or `.profile`)
</div><!-- .element: class="fragment" -->

===
Some basic directory movements
------------------------------------------------------------------------
We can `c`hange `d`irectory with `cd`
<div>
  ```bash
  cd www
  ls
  ```
</div><!-- .element: class="fragment" -->
<div>
We go up the tree with `..`
  ```bash
  cd ..
  ```
</div><!-- .element: class="fragment" -->
<div>
Our `p`resent `w`orking `d`irectory is printed by <br>
`pwd` as <mark>absolute pathname</mark>
  ```bash
  pwd
  ```
</div><!-- .element: class="fragment" -->

---
Linux file system
------------------------------------------------------------------------
<img src="images/directorystructure.png" width="100%">


===
Creating files and directories
------------------------------------------------------------------------
A file is created by `touch`ing it
<div>
  ```bash
  ls myfile
  # ls: cannot access 'myfile': No such file or directory
  touch myfile
  ls myfile
  # myfile
  ```
</div><!-- .element: class="fragment" -->
<div>
A folder is created my `m`a`k`e `dir`
</div><!-- .element: class="fragment" -->
<div>
  ```bash
  ls myfolder
  # ls: cannot access 'myfolder': No such file or directory
  mkdir myfolder
  ls myfolder
  # myfolder
  ```
</div><!-- .element: class="fragment" -->

===
Copy contents
------------------------------------------------------------------------


===
Showing files
------------------------------------------------------------------------
We can `l`i`s`t the directory contents
<div>
  ```bash
  ls
  ls -l
  ls -al
  ls -S
  ls -Sr
  ls -t
  ```
</div><!-- .element: class="fragment" -->
<div>
  Note that `-a` does not ignore entries starting with `.` and that short
  options can be concatenated (`-al` = `-a -l`)
</div><!-- .element: class="fragment" -->
<div>
  Check all options with `man ls` or `ls --help`.
</div><!-- .element: class="fragment" -->

===
Links
------------------------------------------------------------------------
Links are like a pointer from one file to another

===
Folders can be special
------------------------------------------------------------------------
E.g.\ your home folder `~` points at DESY actually to (on SL computers,
on Ubuntu check `~/afs`)?
<div>
  ```bash
  echo ~
  # /afs/desy.de/user/b/bcho
  ```
</div><!-- .element: class="fragment" -->
<div>
The <mark>Andrew File System (AFS)</mark> is a distributed file system
that allows to use the folder on all clients like a physical folder
</div><!-- .element: class="fragment" -->
<div>
Has some issues especially under Ubuntu (`git`, `svn` or `latex` not working
correctly in it). Will eventually be replaced. You can also use
`DESYcloud` to share files. More info in <mark>DESY talk</mark>
</div><!-- .element: class="fragment" -->

===
More special folders
------------------------------------------------------------------------


---
- environment variables https://en.wikipedia.org/wiki/Environment_variable
- `history`
- what is PATH and LD_LIBRARY_PATH
- access rights
  - how to make a script executable
- usage of editor: vim? nano?
- what $SHELL and what $TERM are we in?
- bonus: what is TERM? Set TERM=Dumb
- common shortcuts
  - Alt+.
  - Up Down
  - Tab

---
<img src="images/i-find-your-lack-of-tests-disturbing.jpg" width="50%">
