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
3. Bash scripting
4. <mark>Regular Expressions</mark>
5. Makefiles
6. Git
8. DESY IT (Sven Sternberger)


---
Regular Expressions
------------------------------------------------------------------------
Also known as
- RegExp
- Regex
- ASCII puke

*A way to describe a <mark>set of strings</mark>*

===
Regular Expressions
------------------------------------------------------------------------
Can be used in
- programming languages
- editors, IDEs
- command line tools (grep, sed, etc.)
- databases
- ...

Often similar syntax with notable differences

===
The greps
------------------------------------------------------------------------
FYI: grep = global/regular expression/print

- Standard `grep` understand basic regular expressions
- `egrep/grep -E` interprets extended regular expressions
- `grep -P` uses Perl-compatible regular expressions (PCRE)

PCRE is also seen in some other tools

---
Technical side note
------------------------------------------------------------------------
Make sure you have color in grepping

Put in your `.bashrc` or running terminal
```bash
  export GREP_OPTIONS='--color=auto'
```

===
Basic grep examples
------------------------------------------------------------------------
Let's say you want to find all the words in `/usr/share/dict/words` that
contains the letter `a`

<div>
  ```bash
  cat /usr/share/dict/words | grep a
  ```
</div><!-- .element: class="fragment" -->

<div>
  Or you actually only need the words that start with an `a`.
  E.g.
  ```bash
  cat /usr/share/dict/words | grep '^a'
  ```
</div><!-- .element: class="fragment" -->

<div>
  Or the ones that end with an `a`
  ```bash
  cat /usr/share/dict/words | grep 'a$'
  ```
</div><!-- .element: class="fragment" -->

Note:
- Quotes avoid that special characters get interpreted by bash


===
Basic bash examples
------------------------------------------------------------------------
`bash` has globbing, which is a very basic `regex`

We already used `*` occassionally to select everything

We can also prepend or append letters
<div>
  ```bash
  echo D*
  # Desktop Documents Downloads
  echo *.png
  ```
</div><!-- .element: class="fragment" -->

<div>
`*` is called the wildcard character and <br>
you can use any number of them
  ```bash
  echo *l*
  ```
</div><!-- .element: class="fragment" -->

---
Back to grep
------------------------------------------------------------------------
You might wonder how many words not only end with `a` but have one
character before that and an `o` before that
<div>
  ```bash
  cat /usr/share/dict/words | grep 'o.a$'
  ```
</div><!-- .element: class="fragment" -->

<div>
  While `^` and `$` only specify start and end of a line, `.` allows to
  match exactely one character (numbers are also characters)
</div><!-- .element: class="fragment" -->

<div>
If we want to search for an explicit `.`, <br>
we have to <mark>escape</mark> it with `\ `
  ```bash
  cat /usr/share/dict/words | grep 'o\.a$'
  ```
</div><!-- .element: class="fragment" -->

Note:
-  (like `yoga`)
- Either you want to cheat at scrabble or you really want to become a
  rap artist

===
Ranges
------------------------------------------------------------------------
We can also look for ranges of characters instead of one specific or any
character (also called classes)
<div>
  ```bash
  cat /usr/share/dict/words | grep '[t-z]$'
  ```
</div><!-- .element: class="fragment" -->
<div>
Same goes for numbers
  ```bash
  cat /proc/cpuinfo | grep '[0-9][0-9]'
  ```
</div><!-- .element: class="fragment" -->
<div>
Or directly specify the characters you want
  ```bash
  cat /usr/share/dict/words | grep 't[aeiou]z$'
  cat /usr/share/dict/words | grep 't[aeiou][t-zT-Z0-9]$'
  ```
</div><!-- .element: class="fragment" -->

===
Character Class Abbreviations
------------------------------------------------------------------------
Predefined set of classes
- `[[:alpha:]]` is `[a-zA-Z]`
- `[[:upper:]]` is `[A-Z]`
- `[[:lower:]]` is `[a-z]`
- `[[:digit:]]` is `[0-9]`
- `[[:alnum:]]` is `[a-zA-Z0-9]`
- `[[:space:]]` is any whitespace including tabs

Help to keep `regex` cleaner/more readable

===
Shorter Character Class Abbreviations
------------------------------------------------------------------------
In PCRE (`grep -P`), you can also use the shorter variants
- `\d` is `[0-9]`
- `\w` is `[a-zA-Z0-9_]`
- `\s` is `[ \t\n\r\f]` (space)

And there is negation
- `\D` is `[^0-9]`
- `\W` is `[^a-zA-Z0-9_]`
- `\S` is `[^ \t\n\r\f]` (space)

===
Negation
------------------------------------------------------------------------
Negation with the caret `^` of course also works in custom classes
  ```bash
  cat /usr/share/dict/words | grep 't[^aeiou]z$'
  cat /usr/share/dict/words | grep 't[^aeiou][^z]$'
  ```

Logic gets more complicated with negation,<br>
so use it only when really needed

===
Word boundaries
------------------------------------------------------------------------
- `\b` and `\>` matches at word boundaries
- `\B` matches not at word boundaries <br><br>

<div>
  ```bash
  cat /usr/share/dict/words | grep  'mi\B'
  cat /usr/share/dict/words | grep  'mi\b'
  cat /usr/share/dict/words | grep  'mi\>'
  ```
</div><!-- .element: class="fragment" -->

---
Quantifiers
------------------------------------------------------------------------
We can specify how many of a specific character should occur
- `+` is 1 or more of a character (class)
- `?` is 0 or 1 of a character (class)
- `*` is 0 or more of a character (class)
- `{4}` is exactely 4 of a character (class)

===
Examples
------------------------------------------------------------------------
<div>
  ```bash
  cat /usr/share/dict/words | egrep  'm{2}'
  cat /usr/share/dict/words | egrep  '[aeiou]{4}'
  echo 'bijan@chokoufe.com' | egrep '^\w+@\w+.\w+$'
  cat /usr/share/dict/words | egrep  'bo?t'
  cat /usr/share/dict/words | egrep  'bo+t'
  cat /usr/share/dict/words | egrep  'bo*t'
  ```
</div><!-- .element: class="fragment" -->


===
More quantifiers
------------------------------------------------------------------------
You can also give a range in the braces `{3,5}`

- `+` is `{1,}`
- `?` is `{0,1}`
- `*` is `{0,}`

---
Groups
------------------------------------------------------------------------
You can put patterns in groups <br>
that might <mark>repeat</mark> or be <mark>combined</mark>

<div>
  ```bash
  cat /usr/share/dict/words | grep -P '(k){2,}'
  cat /usr/share/dict/words | grep '\(k\)\{2,\}'
  ```
</div><!-- .element: class="fragment" -->
<div>
  ```bash
  cat /usr/share/dict/words | grep -P 'e((ak)|(fo))'
  ```
</div><!-- .element: class="fragment" -->

===
Greedyness
------------------------------------------------------------------------
`Regex` searches are usually greedy

They match as much as possible
<div>
  ```bash
  echo '<p>foo</p>' | egrep '<.+>'
  ```
</div><!-- .element: class="fragment" -->
<div>
You can have a `lazy` or `non-greedy` search by adding the modifier `?`
after the quantifier
  ```bash
  echo '<p>foo</p>' | grep -P '<.+?>'
  ```
</div><!-- .element: class="fragment" -->
---
Replacing
------------------------------------------------------------------------
`sed` the `s`tream `ed`itor modifies streams of data

Good for find and replace

E.g.
  ```bash
  cat /proc/cpuinfo | sed 's/:/---/'
  cat /proc/cpuinfo | sed 's/:/---/' | sed 's/bits/BITS/g'
  ```
The `g`lobal flag substitutes multiple times on a <mark>line</mark>

`s` specifies a `s`ubstitution command. There is also `d`eletion

===
Deleting
------------------------------------------------------------------------
<div>
  ```bash
  cat /proc/cpuinfo | sed '/\(bogo\|flags\)/d'
  cat /proc/cpuinfo | grep -v '\(bogo\|flags\)'
  ```
</div><!-- .element: class="fragment" -->

===
Extracting
------------------------------------------------------------------------
You have access to the groups matched in the regexp and <br>
can use them in the replacement as <mark>back reference</mark>
<div>
  ```bash
  cat /proc/cpuinfo | grep 'cpu MHz' | sed 's/^.*\( [0-9]\+\.[0-9]\+\)/\1/'
  ```
</div><!-- .element: class="fragment" -->
