# Dotfiles

## Description

This repository contains my dotfiles for various programs that I use in
Unix-like environment.

To manage these files, I use a technique described
[here](https://www.atlassian.com/git/tutorials/dotfiles)

## Installation

To install dotfiles, first clone the code on a local machine:

    cd  # cd to the home directory
    # Clone the repository to $HOME/.dotfiles
    GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME git clone --bare git@github.com:dmitry-kabanov/dotfiles

then run the installation script:

    bash bin/setup.sh


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
