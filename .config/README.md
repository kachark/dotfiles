# Dotfiles

## Requirements
- Git

## Setup

[Reference](https://www.atlassian.com/git/tutorials/dotfiles)

Note: This repository uses ```.config/``` instead of ```.cfg/```

### Tmux

See [this](https://discuss.kakoune.com/t/macos-terminal-app-with-tmux-guide/1526) for how to 
add italics to tmux. tmux-256color supports italics but doesn't ship with macOS due to it 
including an outdated version of the ncurses library.

Included is the tmux-256color terminfo file which can be compiled using the tic command.

```bash
/usr/bin/tic -x terminfo/tmux-256color.terminfo
```

Now, .tmux.conf can call tmux-256color and enable italics!
