---
title: Eask DSL
permalink: dsl
---

# Eask Domain Specific Language (DSL)

This document provides a reference on the [DSL](https://en.wikipedia.org/wiki/Domain-specific_language#:~:text=A%20domain%2Dspecific%20language%20(DSL,is%20broadly%20applicable%20across%20domains.).

## Example

`Eask` is the magic file that `eask` will read it as the init file in Emacs.
The syntaxes are very similar to the `Cask` file, but different.

```el
(source "gnu")

(package "your-package" "1.0.0" "Your package description")

(package-file "your-package-file.el")
```

Remember, `Eask` is just the regular elisp file, and should be read it from
the Emacs itself!

## Advanced Usage

```el
; Regular Eask file content...

(setq byte-compile-error-on-warn t)  ; Singal error if warning occurred
```

`eask` provides some hooks so you can define your own action before/after
each command. The name of the hook follows the rule of
`eask-BEFORE/AFTER-command-NAME-hook`.

For example, to enable compile on warn on `byte-compile` command

```el
(add-hook 'eask-before-command-compile-hook 
          (lambda () (setq byte-compile-error-on-warn t)))
```