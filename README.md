# Dotfiles

## Description

This repository contains my dotfiles for various programs that I use in
Unix-like environment.

To manage these files, I use a technique described
[here](https://www.atlassian.com/git/tutorials/dotfiles)

## Installation

It is assumed here that the current working directory is `$HOME`.

To install dotfiles, first clone the code on a local machine:

    # Clone the repository to $HOME/.dotfiles
    git clone --bare git@github.com:dmitry-kabanov/dotfiles .dotfiles
    
then checkout to the `$HOME` directory:

    GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME git checkout

then run the installation script:

    bash .bin/setup.sh
    
Every time when you need to work with the `dotfiles` repo, set environment
variables `$GIT_DIR` and `$GIT_WORK_TREE` by the following command:

    source .bin/activate_dotfiles_repo.sh
    
After finishing working with the repo, the best is to close the terminal tab
to "undo" the environment variables.


## Usage

Every time, I need to modify the dotfiles, I work in a fresh terminal instance,
where I source a shell script that sets the environment variables `$GIT_DIR`
and `GIT_WORK_TREE`:

    source .bin/activate_github_repo.sh

After all git-related operations are done, I just close this terminal instance
to make sure that these environment variables do not interfere with any other
git repository.

## References

https://www.atlassian.com/git/tutorials/dotfiles
