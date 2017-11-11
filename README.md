# Language Detection Using Ruby and FANN

## Windows / Mac

I'm sure there are ways to get things going both on Windows and Mac OSX natively.
But I don't have any of those things, so I won't describe how to get there. Instead,
why not trying to use Linux for a change? Don't worry, it will not affect your
environment in any way and will be very easy to remove if you don't want it
anymore. But let's face it... You won't remove it.

First of all, download VirtualBox [here](https://www.virtualbox.org/wiki/Downloads).
Download the right version for your operating system and install it.

Once done and on the same page, make sure to download and install that thing
called the "Extension Pack", as it will make things run much faster.

Now, you can download a pre-installed, pre-configured, pre-chewed and everything
version of Xubuntu [here](https://drive.google.com/file/d/0B_HAFnYs6Ur-ZFBGM3gwd0pEMms/view).
Once downloaded, you should end up with a file in your Downloads folder. You will
most likely have to uncompress the file (It might take a while).

Now open VirtualBox (We installed it earlier) and:

- click that big fat **New** button.
You'll be asked to enter a name, just choose "Ubuntu" and press **Next**.
- When asked for memory, just slap 2048MB in there and press **Next** again.
- When asked for a *Hard Disk*, pick the option reading *Use an existing hard disk file*, and browse to that Ubuntu thing we downloaded earlier and then press **Create**.
- You can power it on now. It will boot and offer you to login. Just pick that big user named *osboxes.org*, and type in the same for the password.
- Wait for a while and you should be in a brand new shiny Ubuntu simulation.
- Once inside, wait for a while because the system will automatically update to in the background. Like, 5mn or so.

## Linux

You'll first need to install everything your system needs to run Ruby and FANN.

Open a terminal and run: `sudo apt-get install build-essential libfann-dev libgmp-dev`
and press enter. You'll be asked for your password. Unless you changed it, it is
*osboxes.org*.

TO BE CONTINUED:

- Install [RVM as a user](https://rvm.io/rvm/install).
- Using RVM, get a recent version of Ruby, run `rvm install 2.3.1` and wait.
- Set the installed Ruby to the one you will use by default, run `rvm use 2.3.1 --default`.
- Install Bundler, run `gem install bundler`.

**Very great success**, you've got a neat Ruby setup. For real, I'm using that
exact same one for very serious customers who pay me with real-world money so I'm
not messing around with it.

## Tooling

Regardless of whether you're runnin Ruindows, Minix, Billux or Bullcrap OSX, you
**really** might want to install the awesome [Sublime Text 3](https://www.sublimetext.com/3). It is free unless
you want to get rid of the **It is free!** message.

Then generally speaking, you really want to get comfortable working only with your
keyboard. Because let's face it, only marketting people, artists and windows users
need a mouse, but we're into AI and machine learning, not becoming hippies. So go
online and learn whatever shortcuts your operating system offers for:

- Switch window rapidly,
- Manage workspaces with your keyboard.
- Move window from one workspace to another.
- Learn how to manipulate text, perform multi-selection etc using Sublime 3.

Congratulations you're now a technical person and you're about to enter the 35
years long **lazyness** period I started myself 35 years ago, and still get tons
of respect and awe from the other hippies.