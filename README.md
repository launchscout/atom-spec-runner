# spec-runner package

A spec runner. Lets you run specs from within Atom. Defines two commands

Command               | Description       | Default key binding
--------------------- | ----------------- | ---------------------------
spec-runner:run-file  | Runs entire file  | Ctrl-alt-r f
spec-runner:run-line  | Runs spec at line | Ctrl-alt-r l

It defines one config setting, `spec-runner.command` which defaults to rspec.
Use this to specify a custom spec runner, if you need to do something crazy, like,
oh, say, wrap rvm or something terrible like that.

Also, see `rspec-runner.sh` in the repo for this package for an example of
wrapping rvm. There's got to be a better way than this, but it works for me
for now.

## Warning

This is a total hack as I learn how to Atom.IO. It works for me, but very likely
will cause your computer to catch on fire. Pull requests encouraged.
