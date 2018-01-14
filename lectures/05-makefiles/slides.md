Linux and Terminals
========================================================================
Bijan Chokoufe Nejad <!-- .element: class="fragment" -->
From Zero to Hero <!-- .element: class="fragment" -->
-----

<img src="images/noob.jpg" width="200"> <!-- .element: class="fragment" -->
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
<img src="images/code-ninja.jpg" width="200"> <!-- .element: class="fragment" -->

January 15, 2017

---
Session overview
------------------------------------------------------------------------
1. Intro, Linux basics and file management
2. More commands and piping
3. Bash scripting
4. Regular Expressions
5. <mark>Makefiles</mark>
6. Git
7. DESY IT (Sven Sternberger)


---
Building software (and other things)
------------------------------------------------------------------------
There is often the case where we have <mark>one "source" file</mark>
that if processed by a program will produce <mark>one or more output
files</mark>
- `.c` -> `.o`
- `.f90` -> `.o`, `.mod`
- `.tex` -> `.pdf`
- ...

Furthermore, there are usually multiple source files and the results
will <mark>depend</mark> on each other

===
Make
------------------------------------------------------------------------
`make` automatically determines which pieces have to be "recompiled" and
"compiles" them

For this to work, there can be <mark>rules</mark> how objects should be
generated and <mark>extra dependencies</mark> in the `Makefile`

Additionally, there are already builtin rules in `make`

===
Make rule syntax
------------------------------------------------------------------------
```bash
  TARGET: DEPENDENCIES
    RULE
```

`RULE` must be indented by a `<TAB>`

Can contain multiple lines of commands

Comments start with `#`

---
A toy example
------------------------------------------------------------------------
```c
  # hellomake.c
  #include <hellomake.h>
  int main() {
    // call a function in another file
    myPrintHelloMake();
    return(0);
  }
```
<br>
```c
  # hellofunc.c
  #include <stdio.h>
  #include <hellomake.h>
  void myPrintHelloMake(void) {
    printf("Hello makefiles!\n");
    return;
  }
```
<br>
```c
  # hellomake.h
  void myPrintHelloMake(void);
```

===
First toy makefile
------------------------------------------------------------------------
Normally this could be compiled as
  ```bash
  gcc -o hellomake hellomake.c hellofunc.c -I.
  ```

For more files this becomes quickly <mark>unhandy</mark> (typing the
whole command or going back in command history) and
<mark>unefficient</mark> (recompiles everything)

<div>
Simplest `Makefile` to capture this
  ```bash
  hellomake: hellomake.c hellofunc.c
  	gcc -o hellomake hellomake.c hellofunc.c -I.
  ```
</div><!-- .element: class="fragment" -->

Note:
- TAB is important
- still recompiles everything

===
Second toy makefile
------------------------------------------------------------------------
Note that compiling (`.c` -> `.o`) and linking (resulting in the main
program) can be separated in two steps

  ```bash
  CC=gcc
  CFLAGS=-I.
  hellomake: hellomake.o hellofunc.o
  	$(CC) -o hellomake hellomake.o hellofunc.o $(CFLAGS)
  ```

<div>
  This works because `make` already has the inbuilt rule <br>
  to build an `.o` out of an `.c` file
</div><!-- .element: class="fragment" -->

<div>
Dependency on `.h` is still missing. We can set it explicitely
  ```bash
  hellomake.o hellofunc.o: hellomake.h
  ```
</div><!-- .element: class="fragment" -->

===
More toy makefiles
------------------------------------------------------------------------
We can also overwrite the default rule
<div>
  ```bash
  DEPS = hellomake.h

  %.o: %.c $(DEPS)
  	$(CC) -c -o $@ $< $(CFLAGS)
  ```
</div><!-- .element: class="fragment" -->
<div>
  Say hello to `make`s userfriendly name for <br>
  <mark>target</mark> (`$@`) and <mark>first dependency</mark> (`$<`)

  Furthermore, there is the list of all dependencies (`$^`)
</div><!-- .element: class="fragment" -->

===
Almost there
------------------------------------------------------------------------
Cleaning up our final link step, our Makefile looks like this
<div>
  ```bash
  CC=gcc
  CFLAGS=-I.
  DEPS = hellomake.h
  OBJ = hellomake.o hellofunc.o

  %.o: %.c $(DEPS)
  	$(CC) -c -o $@ $< $(CFLAGS)

  hellomake: $(OBJ)
  	$(CC) -o $@ $^ $(CFLAGS)
  ```
</div><!-- .element: class="fragment" -->

===
Last touch
------------------------------------------------------------------------
There should be also a rule to `clean` our build folder up
  ```bash
  .PHONY: clean

  clean:
  	rm -f $(ODIR)/*.o *~ core $(INCDIR)/*~ 
  ```

`clean` is declared as `PHONY` target, ensuring it is performed even if
there is a file called `clean` in the directory

You can specify a target on the cmdline: `make clean`

===
Makefile exercise
------------------------------------------------------------------------
- Write a `Makefile` rule to build a `pdf` out of a `tex` file

---
Some more idiosyncracies
------------------------------------------------------------------------
If you want to access environment variables, you need to escape the `$`
(different set of variables)
<div>
  ```bash
  foo:
    echo $$SHELL
  ```
</div><!-- .element: class="fragment" -->

<div>
  You have to write longer shell statements in one line (can be separated
  with `\ `) as otherwise the context is lost
</div><!-- .element: class="fragment" -->

<div>
  ```bash
foo:
	tmpdir=foo
	echo $$tmpdir
foo:
	tmpdir=foo; echo $$tmpdir
foo:
	tmpdir=foo; \
		echo $$tmpdir
  ```
</div><!-- .element: class="fragment" -->

---
Lets build make
------------------------------------------------------------------------
<div>
  ```bash
  wget http://ftp.gnu.org/gnu/make/make-4.0.tar.gz
  ```
</div><!-- .element: class="fragment" -->
<div>
  ```bash
  tar xzf make-4.0.tar.gz
  ```
</div><!-- .element: class="fragment" -->
<div>
  ```bash
  cd make-4.0
  ./configure --prefix=`pwd`/../install
  make -j4
  make install
  ```
</div><!-- .element: class="fragment" -->

===
Autotools
------------------------------------------------------------------------
Standard set of tools/scripts that allow to test for dependencies and
generate a `configure` script

Never try to modify a `Makefile` that has been generated by `autotools`

Instead, look at `Makefile.am`. `Makefile` should be regenerated
automatically. In case of doubt, <br>
`autoreconf` and fresh build

---
Parallel Make
------------------------------------------------------------------------
You can simply supply the number of `j`obs you want `make` to use

If you leave out an exact number (`make -j`), <br>
`make` will fork as many processes as allowed <br>by the dependencies
(problematic in huge parallel builds)

You can make an alias like `m=make -j $num_cores`

===
Silent make
------------------------------------------------------------------------
Verbosity can be controlled with `-s`, which will not print the commands
as they are executed <br>
(nice if you already know whats happening)

If the `Makefile` is generated by `autotools`, you can suppress output
with `V=0`

===
Summary
------------------------------------------------------------------------
- Makefile syntax
- Writing and running Makefiles
- Compling, linking and installing software
