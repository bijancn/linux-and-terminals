Linux and Terminals
========================================================================
Bijan Chokoufe Nejad <!-- .element: class="fragment" -->
From Zero to Hero <!-- .element: class="fragment" -->
-----

<img src="images/noob.jpg" width="200"> <!-- .element: class="fragment" -->
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<img src="images/code-ninja.jpg" width="200"> <!-- .element: class="fragment" -->

June 13, 2017

---
Session overview
------------------------------------------------------------------------
1. Intro, Linux basics and file management
2. More commands and piping
3. <mark>Bash scripting</mark>
4. Regular Expressions
5. Makefiles
6. Git
8. DESY IT (Sven Sternberger)


---
Before we start
------------------------------------------------------------------------
Some words of <mark>warning</mark>:
- Most bash scripting starts by putting together <br>
  <mark>commonly repeated commands</mark>
- It can quickly become a <mark>pain</mark> to <br>
  maintain more complex bash scripts
- Almost everything is a <mark>string</mark>. <br>
  There are especially <mark>no booleans</mark>/logicals
- We will use more than `POSIX`, so some stuff will <br>
  only work in bash or closely related shells


---
A trivial real-life example
------------------------------------------------------------------------
- My collaborator would provide data as `.txt` files from Mathematica in
  an svn repository
- I have to go to the repo, update it, navigate to the data subdir and
  copy the new results to my analysis folder <br><br>

<div>
  ```bash
  function update-from-Max () {
    cd ~/threshold
    svn up
    cd Data/ValidationForPaper
    cp MpoleFixed/* ~/run-scripts/threshold_validation/scan-results/
  }
  ```
</div><!-- .element: class="fragment" -->

===
A trivial real-life example
------------------------------------------------------------------------
- I also had to convert the `.txt` files (with lists of numbers) to
  `.dat` files (with lines of numbers)<br><br>

```bash
  function update-from-Max () {
    cd ~/threshold
    svn up
    cd Data/ValidationForPaper
    cp MpoleFixed/* ~/run-scripts/threshold_validation/scan-results/
    cd ~/run-scripts/threshold_validation/scan-results/
    rm Max*.dat
    python ~/run-scripts/Mathematica-importer.py
    rm Max*.txt
    cd ~/threshold/Data/ValidationForPaper
    cp MpoleFromM1S/* ~/run-scripts/threshold_validation_mpoleUnfixed/scan-results/
    cd ~/run-scripts/threshold_validation_mpoleUnfixed/scan-results/
    rm Max*.dat
    python ~/run-scripts/Mathematica-importer.py
    rm Max*.txt
  }
```
Note:
- Ugly code
- Should be cleaned up but did the job and was written in under 5
  minutes

---
Where to put our shell scripts?
------------------------------------------------------------------------
In the above example, we just used a function, which was sourced with
the `.bashrc` and thus available to the shell

For more complex cases, it is better to put it in a <mark>separate
file</mark> that gets executed

Create a `hello.sh` in a folder in your `PATH` with `echo 'hello'` and
make it executable


===
Shebang
------------------------------------------------------------------------
The first line of a script should contain the <mark>shebang</mark>
(`#!`)

It allows to specify the interpreter that should <br>
execute the rest of the script

Script will then work no matter what shell the user is using

<div>
Some typical examples
  ```bash
  #!/bin/bash
  #!/bin/sh
  #!/usr/bin/env python
  ```
Can be literally anything that interprets lines of code
</div><!-- .element: class="fragment" -->

Note:
- Setup your shebang correctly and incorrectly (e.g. /bin/ls).
- Note what happens

===
Comments and Strings
------------------------------------------------------------------------
Comments can be added by prepending hashes `#`. Everything after a hash
is ignored (if it is not in a string)

<div>
  Two kinds of quoting strings:
  - Single quotes (`'`) enclose a **literal** string where nothing is
    expanded (cannot print `'` within `' '`)
  - Doubles quotes (`"`) enclose an **interpolating** string where `$`,
    \` and `\ ` are expanded
</div><!-- .element: class="fragment" -->

<div>
  ```bash
  echo 'hello $USER'
  echo "hello $USER"
  echo "hello $USER"'! We missed you!'\ So\ much!
  ```
</div><!-- .element: class="fragment" -->


===
Functions
------------------------------------------------------------------------
You can (and should) use functions to structure your script.<br>
Arguments are accessible via `$1`, `$2`, ... <br>
The `function` keyword is optional but <br>
avoids collisions with aliases
<div>
  ```bash
  download () {
    url=$1
    name=`basename $1`
    test -r $name || wget $url  # if file is not readable try to wget it
    test -r $name || curl $url -o $name  # maybe we need curl
    test -r $name || exit 2
  }
  ```
</div><!-- .element: class="fragment" -->
<div>
  ```bash
  function download() {
    ...
  }
  ```
</div><!-- .element: class="fragment" -->

Note:
- Write a script to download a tarball like gcc
- No braces in function call

===
Local variables
------------------------------------------------------------------------
You can have local variables in functions, when you ask for it with
`local VARIABLE=VALUE`

Per default everything is global
<div>
  ```bash
  hello() {
    user=$USER
    echo 'hello $user'
  }
  echo $user
  hello
  echo $user
  ```
</div><!-- .element: class="fragment" -->
Note:
- Adapt the example to use local


===
Integer arithmetics
------------------------------------------------------------------------
Can be invoked with the `expr` command
<div>
  ```bash
  expr 1 + 1
  # 2
  ```
</div><!-- .element: class="fragment" -->
<div>
or with double parentheses
  ```bash
  echo $((7 * 3))
  ```
</div><!-- .element: class="fragment" -->
<div>
or with the `let` keyword
  ```bash
  i=0
  let i=i+1 && echo $i
  ```
</div><!-- .element: class="fragment" -->

---
Brace expansion
------------------------------------------------------------------------
Very useful to build up combinations
<div>
  ```bash
  echo a{b,c}d{e,f}
  # abde abdf acde acdf
  ```
  </div><!-- .element: class="fragment" -->
<div>
  Can be coupled with <mark>wildcards</mark> and nested
</div><!-- .element: class="fragment" -->
<div>
  ```bash
  ls *.{jp{e,}g,png}
  ```
</div><!-- .element: class="fragment" -->
<div>
  Can also be used for ranges with the double dot (`..`)
  <div>
  ```bash
  echo {1..10} {1..10..2}
  touch foo{0..10}
  rm foo{0..10}
  ```
  </div><!-- .element: class="fragment" -->
</div><!-- .element: class="fragment" -->

===
More braces
------------------------------------------------------------------------
You can also range over letters
<div>
  ```bash
  echo {a..z}
  echo {a..z..7}
  ```
</div><!-- .element: class="fragment" -->
<div>
  When used with variables, you have to use the `eval`
</div><!-- .element: class="fragment" -->
<div>
  ```bash
  start=1; end=10
  echo {$start..$end}
  # {1..10}
  eval echo {$start..$end}
  # 1 2 3 4 5 6 7 8 9 10
  ```
</div><!-- .element: class="fragment" -->


===
Parameter substitution
------------------------------------------------------------------------
Sometimes you have to set braces just to avoid confusion
```bash
  greeting='Hello '
  echo ${greeting}World
```

<div>
  You can also remove a `PATTERN` from the <mark>end</mark> of a variable
```bash
  echo ${greeting%llo }World
```
</div><!-- .element: class="fragment" -->

<div>
  Or from the <mark>front</mark>
```bash
  echo ${greeting#He}World
```
</div><!-- .element: class="fragment" -->

===
Evaluate inline
------------------------------------------------------------------------
A very useful tool is the backtick (\`)

It allows to evaluate any command
<div>
  ```bash
  prefix=`pwd`    # put result of pwd command in variable
  basename=`basename $prefix`
  ```
</div><!-- .element: class="fragment" -->

<div>
Can also use parenthesis similarly
  ```bash
  basename2=$(basename $prefix)
  ```
</div><!-- .element: class="fragment" -->

<div>
  ```bash
  tarfile=/var/my-backup-$(date +%Y-%m-%d).tgz
  tar -czf $tarfile /home/me/
  ```
</div><!-- .element: class="fragment" -->

---
Conditionals
------------------------------------------------------------------------
In `bash` the condition for an `if` is a command and it is `"true"` when
it returns 0 else it is `"false"`

<div>
  ```bash
  if true ; then
    echo "for real"
  fi
  if false ; then
    echo "but not this"
  else
    echo "it is false"
  fi
  ```
</div><!-- .element: class="fragment" -->

<div>
  To make `if` more useful, it is often combined with <br>
  `test ARGS`, which is equivalent to `[ ARGS ]`
</div><!-- .element: class="fragment" -->

Note:
- So if you thought `if [ ]` is getting an actual conditional, you were
  wrong

===
Test
------------------------------------------------------------------------
`test` takes many flags to perform conditional tests

Some popular ones
- `-e file` is true if given file/directory exists
- `-f file` is true if given file exists
- `-r file` is true if given file/directory is readable
- `-d dirname` is true if given directory exists
- `-z string` is true if given string is empty
- `string1 = string2` if the strings are equal
- `string1 != string2` if the strings are not equal

Note:
- Check if a file is executable with test


===
Test
------------------------------------------------------------------------
It can also compare integers
- `INT1 -eq INT2` (equal)
- `INT1 -ge INT2` (greater equal)
- `INT1 -gt INT2` (greater than)
- `INT1 -le INT2` (less equal)
- `INT1 -lt INT2` (less than)
- `INT1 -ne INT2` (not equal)


===
Testing for arguments
------------------------------------------------------------------------
You can use test to check for <br>
optional arguments to your script
<div>
  ```bash
  if [ "$1" = "-v" ]; then
    echo "switching to verbose output in $0"
    VERBOSE=1
  fi
  ```
</div><!-- .element: class="fragment" -->

<div>
  You can also negate the whole conditional with `!` in front or combine
  two conditional expressions with a logical and (`-a`) or a logical
  or (`-o`)
</div><!-- .element: class="fragment" -->

---
Iteration
------------------------------------------------------------------------
The `while COMMAND; do COMMANDS; done` form executes commands until the
`COMMAND` returns non-zero

<div>
  ```bash
  i="0"
  while [ $i -lt 4 ]; do
    echo "$i is the best number"
    let i=i+1
  done
  ```
</div><!-- .element: class="fragment" -->

<div>
With the ` for VAR in ARRAY; do COMMANDS; done` form, you can iterate
over elements
</div><!-- .element: class="fragment" -->
<div>
  ```bash
  # compile all the c files in a directory into binaries
  for f in *.c; do
    gcc -o ${f%.c} $f
  done
  ```
</div><!-- .element: class="fragment" -->

Note:
- Note the missing $

===
More on arrays
------------------------------------------------------------------------
Note that you can also set arrays with parentheses
<div>
  ```bash
  myarray=(one two three 4)
  for i in ${myarray[*]}; do
    echo $i
  done
  ```
</div><!-- .element: class="fragment" -->

===
Case statements
------------------------------------------------------------------------
`case` statements can be used for treating many possible cases
  ```bash
case EXPRESSION in
  CASE1) COMMAND-LIST;;
  CASE2) COMMAND-LIST;; ...
  CASEN) COMMAND-LIST;;
esac
  ```
Each clause has to be ended with double semicolons (`;;`)

Each case can be separated into multiple ones with `|`

Cases are handled from <mark>top to bottom</mark>

You can add `*)` at bottom to match everything

===
Example
------------------------------------------------------------------------
```bash
function extract() {
  case $1 in
    *.tar.bz2)   tar xvjf $1     ;;
    *.tar.gz)    tar xvzf $1     ;;
    *.bz2)       bunzip2 $1      ;;
    *.rar)       unrar x $1      ;;
    *.gz)        gunzip $1       ;;
    *.tar)       tar xvf $1      ;;
    *.tbz2)      tar xvjf $1     ;;
    *.tgz)       tar xvzf $1     ;;
    *.zip)       unzip $1        ;;
    *.Z)         uncompress $1   ;;
    *.7z)        7z x $1         ;;
    *)           echo "'$1' cannot be extracted via >extract<" ;;
  esac
}
```

---
Let's compute factorials
------------------------------------------------------------------------
<div>
  ```bash
  function fact {
    result=1
    n=$1
    while [ "$n" -ge 1 ]; do
      let result=n*result
      let n=n-1
    done
    echo $result
  }
  for i in {1..10}; do
    echo "$i `fact $i`"
  done
  ```
</div><!-- .element: class="fragment" -->

---
Summary
------------------------------------------------------------------------
- Functions and bash scripts
- More useful bash tricks
- Looping and conditionals
