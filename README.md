# my dot diles

These are config files that make a system feel right at home for me.

#my bash
My bash profile is no holy place. I change it haphazardly and frequently.  It's the engine of my productivity, and it's driven by my want to type things with as few characters as possible.  

I don't suggest you copy it and take it without looking at what it does since none of this is intuitive to anybody else other than me.  

Copy bits and pieces to experiment with and have fun.  

#my emacs

##why emacs
![solarized emacs](http://batsov.com/images/articles/solarized-emacs.png)
There are many reasons for using emacs over a fleshed-out IDE, the typical response you'll find is:

* You can use it in the terminal (emacs -nw, but I alias this)
* It saves time (it starts up much faster than eclipse or visual studio)
* You can add to it (fully programmable, you can even play tetris in it!)

However, the one reason that has made me appreciate emacs more is the bash shell.  

The bash shell is on _every_ *nix system. And it uses the GNU Readline library which utilizes emacs key-bindings by default.  
That means a lot of the typing tricks you've picked up for emacs will work in your bash shell.  More on that [here](http://www.skorks.com/2009/09/bash-shortcuts-for-maximum-productivity/).

It's a very petty reason, and you can easily switch the key-bindings to vi or customize it to something more familiar, but it's a the-more-you-know sort of thing.  

My personal .emacs, used with my .emacs.d that you can find [here](https://github.com/SuitAndThai/emacs.d).

This was partially influenced by [Magnar's emacs configurations](https://github.com/magnars/.emacs.d).

##installing emacs on fedora

get the latest tarball and extract it:

    LATEST_STABLE="http://ftp.gnu.org/gnu/emacs/"  
    FILENAME=$(curl -s ${LATEST_STABLE} | sed -n 's/^.*a href="\(emacs-24.[0-9\.]*tar.gz\)".*$/\1/p' )  
    curl -o ${FILENAME} ${LATEST_STABLE}${FILENAME}  
    tar -xzof $FILENAME  
    cd ${FILENAME%.tar.gz}

install the dependencies:

    yum-builddep emacs

configure, build, install:

    ./configure --prefix=/usr/local/emacs24 --with-dbus --with-gif --with-jpeg --with-png \
    --with-rsvg --with-tiff --with-xft --with-xpm --with-x-toolkit=gtk
    make
    ./src/emacs --version # Look good? The INSTALL doc suggests testing: ./src/emacs -Q
    sudo make install

tell fedora of the new emacs path:

    sudo alternatives --install /usr/bin/emacs emacs /usr/local/emacs24/bin/emacs 20000
    sudo alternatives --install /usr/bin/emacsclient emacsclient /usr/local/emacs24/bin/emacsclient 20000

badda bing, badda boom:

    emacs

Credit to jonEbird for his helpful [blog post](http://jonebird.com/2011/12/29/installing-emacs-v24-on-fedora/) on the topic.  I really only made minor adjustments to it based off of the comments and my own experience.

## survival guide for the first week of emacs

Shamelessly borrowed and editted from [magnar](https://github.com/magnars/.emacs.d).

When you start using emacs for the first time, your habits fight you every inch
of the way. Your fingers long for the good old familiar keybindings. Here's an
overview of the most commonly used shortcuts to get you through this pain:

* `C      ` Shorthand for the ctrl-key
* `M      ` Shorthand for the meta-key (typically esc or alt)
* `S      ` Shorthand for the shift-key

### recommended reading

* [A guided tour](http://www.gnu.org/software/emacs/tour/)
* [How to learn emacs](http://david.rothlis.net/emacs/howtolearn.html)

### files

* `C-x C-f` Open a file. Starts in the current directory
* `C-x C-s` Save this file

### cut copy and paste

Something you need to understand is that text highlighting in emacs is done via 'marking'.  
You must 'mark' the beginning of your highlighting and your cursor is the ending 'mark' of the highlight.  
The [guided tour](http://www.gnu.org/software/emacs/tour/) can explain this more thoroughly.

* `C-space` Start marking stuff. C-g to cancel.
* `C-w    ` Cut (aka kill)
* `C-k    ` Cut till end of line
* `M-w    ` Copy
* `C-y    ` Paste (aka yank)

### general

* `C-g    ` Quit out of whatever mess you've gotten yourself into, ABORT ABORT ABORT!
* `M-x    ` Run a command by name
* `C-/    ` Undo

### navigation

* `C-arrow` Move past words/paragraphs
* `C-a    ` Go to start of line
* `C-e    ` Go to end of line
* `C-l    ` Go to line number (based off of my key-binding)
* `C-s    ` Search forward. Press `C-s` again to go further.
* `C-r    ` Search backward. Press `C-r` again to go further.

### window management

* `C-x 0  ` Close this window
* `C-x 1  ` Close other windows
* `C-x 2  ` Split window horizontally
* `C-x 3  ` Split window vertically
* `S-arrow` Jump to window to the left/right/up/down

### help

* `F1 t   ` Basic tutorial
* `F1 k   ` Help for a keybinding
* `F1 r   ` Emacs' extensive documentation
