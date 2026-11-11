Emacs config command to initialize borg
```
emacs -Q --batch -L lib/borg -l borg --eval '(borg-initialize)' --eval '(borg-batch-rebuild)'
```
