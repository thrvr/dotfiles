# Dirk's dotfiles history

Here is first of all the history of everything:


## Setting up the Mac entirely from scratch - this time with dotfiles


After updating to MacOS X Mojave, my time machine backup failed when I needed \
a recovery. So I decided to do it professionally this time. And therefore I \
created dotfiles for my personal setup, that anyone can use.

I created the gitub account 
`thrvr`
with the email
`thrvr@thrvrs.com`
and chose the standard password notation for the account.

I'll use the directory 

`~/.dotfiles`

in my user's home folder `/home/****/.dotfiles`

as the root directory for everything else. 


I started by erasing the Mac's disc entirely and formatting it without
disk encryption.

# SUPER IMPORTANT
!!!DON'T CHOOSE THE CASE SENSITIVE HARD DRIVE FORMAT!!!
Otherwise a lot of things collide (most importantly adobe products won't install)
Simply go for AFPS or the first option there is.

## Mac OS X setup steps (from a blank Mojave as initial OS - not an older one).

- register in Germany (My guess is that it this defines the itunes store and default app store)
- U.S. Keyboard
- Select Wifi and enter password
- Don't transfer any information from another computer
- Enter itunes id d****4@gmail.com and password (password for itunes on 1st and last)
- confirm using the apple id from another device
- create a new computer account "******" for a*****o (password follows default pattern for adesso)
- Allow the itunes id to reset the password (afterwards enter the file vault password) setting up the account then takes a bit longer
- Set up iCloud keychain (yes)
- Storing files in iCloud (hell no)
- light theme


There you go - we have a newly setup mac with a very blank
Mac OS X Mojave

Add all email accounts.

- Now check for mojave updates in the system settings and install any OS updates
- Go to system settings -> time machine  and deactivate automatic backups
- Press select disk and check "Encrypt backups" -> back will then ask you for \
the Time Machine backup password (the password for Time Machine follows the \
standard password pattern)

Then test the backup again and see if we can truly recover the computer from the
freshly made backup. This is not automatically a given. And it should be 
repeated every now and then. And one should have more than one backup disk...
And maybe it is a good idea to store the data also in the cloud on S3.


- Afterwards have more patience - the backups will take more than twice as long \
so make an initial backup and relax - time is too precious to get upset
- During recovery from disk you have to first enter the password for the \
tima machine backup encryption and then the root user's password for the \
destination disk. File Vault will be disabled until it is being re-enabled \
after the recovery is done. Wait until after the recovery (which seems much \
faster after file vault is switched off)

- After the recovery enter the password for the iCloud account (same as itunes
in my case)

- (optionally) go to system preferences -> Securuty & privacy -> File Vault tab and activate \
File Vault with allowing iCloud Account to unlock the disk. In this scenario \
apple stores the recovery key encrypted in the iCloud and only you can decrypt \
it with the iCloud password (I guess). But most importantly - one doesn't have \
to write down the recovery key. \
The dialogue states that "You need your login password OR a recovery key to \
access your data" \
So I assume that it makes sure that the disk is encrypted with the login  \
password AND a recovery key. But now it doesn't ask for a "File Vault" password.

---

Now we achieved an initial state from which we can work on. 

- first activate all mail accounts that should have come with iCloud
- Remove t*****w@adesso.de and game center from the internet accounts and feel \
free to activate or deactivate the iCloud acocunt (d**k.t****w@me.com)
- Close and re-open mail in order to see all folders properly. They don't come up \
by themselves without a restart of mail
- set relevant internet accounts to sync for contacts and calendars \
 (t****w@srvvrs.com, d***.t****w@gmail.com) and open contacts for a full sync
- activate iMessage on the computer for the iTunes account

We have a naked operating system with which we can start working. We have our 
first machine backup and we are good to go.


In order to be able to test run dotfiles and its scripts, it is a very good idea 
to just run it in a virtual box hosted on the machine or the other computer. 
Probably on another machine would work better. And then working with snapshots 
to roll back to the beginning.

So after all this I installed VirtualBox that I downloaded from:
	https://www.virtualbox.org/wiki/Downloads
But the installation failed and I was reading through this article on
[Medium.com](https://medium.com/@DMeechan/fixing-the-installation-failed-virtualbox-error-on-mac-high-sierra-7c421362b5b5)
to fix it. It then (by allowing oracle as software vendor in 
`system preferences -> Security & Privacy`) worked on Mojave too. 

In order to run a Mojave guest on a Mojave host I was looking at 
https://github.com/AlexanderWillner/runMacOSinVirtualBox
(I didn't download the APP!!!)

As prerequisites I then had to install the VirtualBox extension pack that 
has to be downloaded and then added from within VirtualBox in the tab 
"extensions". 
Also I downloaded Mojave from the appstore again in order to be able to 
Create a VirtualBox image / hard drive.

Additionally there are a few more prerequisites that get 
automatically resolved when installing homebrew. So I installed home brew.


Installing HomeBrew with

`/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

Instead of just downloading the RunMojaveVirtualBox app, I downloaded the
Source code from GitHub and ran the following command to alter some 
Settings for the VM

`make all VM_SIZE=65536`

(formerly I also used `VM_RES=1280x720` but this lead to a display error
 After installing Mojave. After the installation one can use the scale mode
 by using left-Command - C key combination when running the VM)

We then don't need the app at all - everything is being installed without
It. Also VirtualBox gets started and everything gets installed automatically.

Initially we have to choose a language (English) and then use the disk utils
To delete the disk 
`VBox HARDDISK MEDIA`
 and format it as "Mojave" with 
"AFPS" so that we can use it to Install Mojave. The disk is now 64GB in size, 
so that we can play around With it a lot.

Then we go back to the main menu of the helper utils and start the 
installation of Mojave in the disk. After the installation is done, the
Helper utils screen will pop up again. Shut down the VM Mojave. Then remove
The disk 
`macOS-Mojave.iso.cdr`
 from within Virtualbox. 
Then reboot from the clover startup screen (use the arrow key and hit 
Enter). 

---

It is time to look at dotfiles now. 
First of all we need to make sure that all low level operating system 
settings are taken care of. 

I started reading about dotfiles here with the [Medium.com Article by \
Sajjad Hosseini] (https://medium.com/@Sajjadhosn/build-a-macos-empire-a0c83879ac24)

The core concepts are:
- Be a one-liner => To copy from Dotfiles repository’s README.md
- Have no dependencies => Should be executable on a fresh macOS.
- Require no manual intervention => Apart from initial sudo prompting, “it \
 shouldn’t insist on interactive input” as McIlroy puts it.
- Be able to install apps from the App Store and the rest will always get \
 Installed via homebrew (if available) or scripted
- Have everything scripted in single scripts or in an extractable way, so it \
 Is easy to re-use 


The documentation then refers to 
http://dotfiles.github.io \
Which led me to \
https://medium.com/@driesvints/getting-started-with-dotfiles-76bf046d035c \
which led me to \
https://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/ \
Which led me to \
https://github.com/holman/dotfiles


There I figured, that I can use the brew extension `mas` for downloading
Everything I ever bought or used from the appstore. For this to work I need
All the IDs from the appstore of the application.
---

## AppStore apps and their IDs:
---

- 1Password: 443987910 \
https://itunes.apple.com/de/app/1password/id443987910?l=en&mt=12
- Alinof Timer: 512464723 \
https://itunes.apple.com/de/app/alinof-timer/id512464723?l=en&mt=12
- Audio Merge & Split: 963571828 \
https://itunes.apple.com/de/app/audio-merge-split/id963571828?l=en&mt=12
- BetterSnapTool: 417375580 \
https://itunes.apple.com/de/app/bettersnaptool/id417375580?l=en&mt=12
- Camtasia 2: 478330793\
https://itunes.apple.com/de/app/camtasia-2/id478330793?l=en&mt=12
- CheatSheet: 529456740 \
https://itunes.apple.com/de/app/cheatsheet/id529456740?l=en&mt=12
- Evernote: 406056744 \
https://itunes.apple.com/de/app/evernote/id406056744?l=en&mt=12
- Folder Compare: 535348544 \
https://itunes.apple.com/de/app/folder-compare/id535348544?l=en&mt=12
- Get Plain Text: 508368068 \ 
https://itunes.apple.com/de/app/get-plain-text/id508368068?l=en&mt=12
- Infographics Lab - Templates: 577411683 (for keynote) \
https://itunes.apple.com/de/app/infographics-lab-templates/id577411683?l=en&mt=12
- Kindle: 405399194 \ 
https://itunes.apple.com/de/app/kindle/id405399194?l=en&mt=12
- Keynote: 409183694 \
https://itunes.apple.com/de/app/keynote/id409183694?l=en&mt=12
- Numbers: 409203825 \ 
https://itunes.apple.com/de/app/numbers/id409203825?l=en&mt=12
- Slack: 803453959 \
https://itunes.apple.com/de/app/slack/id803453959?l=en&mt=12
- SplitPrint: 412574988 \
https://itunes.apple.com/de/app/splitprint/id412574988?l=en&mt=12
- The Unarchiver: 425424353 \
https://itunes.apple.com/de/app/the-unarchiver/id425424353?l=en&mt=12
- VitaDock: 638118857 \
https://itunes.apple.com/de/app/vitadock/id638118857?l=en&mt=12
- WhatsApp Desktop: 1147396723 \
https://itunes.apple.com/de/app/whatsapp-desktop/id1147396723?l=en&mt=12


##This list translates into the following commands:
```
mas "1Password", id: 443987910
mas "Audio Merge & Split", id: 963571828
mas "BetterSnapTool", id: 417375580
mas "Camtasia 2", id: 478330793
mas "Folder Compare", id: 535348544
mas "Get Plain Text", id: 508368068
mas "Infographics Lab - Templates", id: 577411683
mas "Keynote", id: 409183694
mas "Numbers", id: 409203825
mas "SplitPrint", id: 412574988 
mas "VitaDock", id: 638118857
```

The missing apps that don't require a license and that can be installed with
brew casks are handled there further below

There are some more apps that I once purchased, but since I can't 
remember the last time I used them, I'll skip them for now. 
Maybe at one point in the future it is worth looking at them again.

## And here comes the list of apps / programs, that I haven't covered yet. 
- Alfred
- Alinof Timer
- Bartender
- Balsamiq
- BetterTouchTool
- Camunda Modeler
- Commander One
- CheatSheet
- Daisy Disk
- DbSchema
- Diffmerge
- DropBox
- Duet
- Evernote
- Firefox
- Forklift
- Google Chrome
- id-3 editor
- iterm 2
- Java
- KeePass
- Kindle
- Logitech Presenter
- Magic Prefs
- Mailbutler
- MySQL Workbench
- OmniDiskSweeper
- OmniFocus
- OmniGraffle
- OmniPlan
- Reflector
- PhpStorm
- Sequel Pro
- slack
- Skype
- Skype for Business
- Snagit
- SourceTree
- sublime text 3
- TeamViewer
- TheBrain
- The Unarchiver
- Tipp10
- µTorrent
- Vagrant (I did not install it just yet)
- VirtualBox 
- VLC
- Xmind 

---
With finding all casks, this website helps a lot: 
http://macappstore.org
## The above list translates into the following commands with brew
```
brew cask install alfred
brew cask install bartender
brew cask install balsamiq-mockups
brew cask install bettertouchtool
brew cask install camunda-modeler
brew cask install cheatsheet
brew cask install commander-one
brew cask install daisydisk
brew cask install dbschema
brew cask install diffmerge
brew cask install dropbox
brew cask install duet
brew cask install evernote
brew cask install firefox
brew cask install forklift
brew cask install google-chrome
brew cask install id3-editor
brew cask install iterm2
brew cask install java
brew cask install keepass
brew cask install kindle
brew cask install magicprefs
brew cask install mailbutler
brew cask install microsoft-office
brew cask install mongodb-compass-community
brew cask install mysqlworkbench
brew cask install omnidisksweeper
brew cask install omnifocus
brew cask install omnigraffle
brew cask install omniplan
brew cask install phpstorm
brew cask install reflector
brew cask install robo-3t
brew cask install sequel-pro
brew cask install slack
brew cask install skype
brew cask install skype-for-business
brew cask install snagit
brew cask install sourcetree
brew cask install sublime-text
brew cask install teamviewer
brew cask install thebrain
brew cask install the-unarchiver
brew cask install tipp10
brew cask install utorrent 
brew cask install vagrant
brew cask install vagrant-manager
brew cask install vagrant-vmware-utility
brew cask install virtualbox
brew cask install virtualbox-extension-pack
brew cask install vlc
brew cask install whatsapp
brew cask install xmind
``` 

## And here come the regular brew packages, that can be installed \
just with `brew install` 

\# Binaries
```
brew 'awscli'
brew 'ansible@2'
brew 'bash'
brew 'bat'
brew 'coreutils'
brew 'git'
brew 'gnupg2'
brew 'grep'
brew 'mas'
brew 'libgit2'
brew 'openssl'
brew 'tree'
brew 'unrar'
brew 'wget'
brew 'youtube-dl'
```


## These are the taps we'll use
```
tap 'caskroom/cask'
tap 'caskroom/eid'
tap 'caskroom/fonts'
tap 'caskroom/versions'
tap 'homebrew/bundle'
```

## Fonts
```
cask 'font-lato'
cask 'font-open-sans'
cask 'font-pt-sans'
cask 'font-roboto'
cask 'font-source-code-pro-for-powerline'
cask 'font-source-code-pro'
cask 'font-source-sans-pro'
cask 'font-source-serif-pro'
```

# After creating my personal adapted dotfiles
After I added all the software I need on my computer to the dotfiles repository
in `~/.dotfiles/Brewfile` and adjusted the Mac OS X settings in `~/.dotfiles/macos/set-defaults.sh`,
I ran everything in Mac OS X Mojave in the naked VM, that we created further up.

I downloaded the github repository from [https://github.com/thrvr/dotfiles/] into `~/.dotfiles/` and
executed the commands in the following order:
- `~/.dotfiles/homebrew/install.sh`
- `~/.dotfiles/macos/set-defaults.sh`
- `~/.dotfiles/script/bootstrap`

I used a test subset in the VM since it runs a lot slower than the host machine.
After successfully confirming that (almost) everything worked, I made a backup of
the virtual machine and its snapshots on an external harddrive.

I then used my initial time machine backup to reset the computer to a naked Mac OS X Mojave.

Following the experiences from the VM, I executed the same order of commands:

- `~/.dotfiles/homebrew/install.sh`
- `~/.dotfiles/macos/set-defaults.sh`
- `~/.dotfiles/script/bootstrap`

It turns out that when running the system default settings, the following errors occur:
```
2018-12-26 14:43:11.735 defaults[27992:147752] Could not write domain com.apple.universalaccess; exiting
override rw------T  root/wheel for /private/var/vm/sleepimage? y
rm: /private/var/vm/sleepimage: Operation not permitted
touch: /private/var/vm/sleepimage: Operation not permitted
chflags: /private/var/vm/sleepimage: Operation not permitted
2018-12-26 14:43:58.488 defaults[28056:148937] Could not write domain com.apple.universalaccess; exiting
2018-12-26 14:43:58.513 defaults[28057:148941] Could not write domain com.apple.universalaccess; exiting
2018-12-26 14:43:58.539 defaults[28058:148945] Could not write domain com.apple.universalaccess; exiting
2018-12-26 14:44:01.735 defaults[28182:149636] Could not write domain /.Spotlight-V100/VolumeConfiguration; exiting
410:480: execution error: Terminal got an error: The file /Users/tornow/init/Solarized Dark xterm-256color.terminal does not exist. (1)
disablelocal: Unrecognized verb.
```
and I still have to figure out, where they occur and how to change it.
Also I noticed that the icons in the dock are extremely tiny and that the key repetition is ultra fast (too fast).

When running the bootstrap script, the following errors occurred:
```
  [ .. ] ==> Caveats
  [ .. ] To install and/or use virtualbox you may need to enable their kernel extension in
  [ .. ] 
  [ .. ] System Preferences → Security & Privacy → General
  [ .. ] 
  [ .. ] For more information refer to vendor documentation or the Apple Technical Note:
  [ .. ] 
  [ .. ] https://developer.apple.com/library/content/technotes/tn2459/_index.html
  [ .. ] 
  [ .. ] ==> Satisfying dependencies
  [ .. ] ==> Downloading https://download.virtualbox.org/virtualbox/6.0.0/VirtualBox-6.0.0-127566-OSX.dmg
  [ .. ] ==> Verifying SHA-256 checksum for Cask 'virtualbox'.
  [ .. ] ==> Installing Cask virtualbox
  [ .. ] ==> Running installer for virtualbox; your password may be necessary.
  [ .. ] ==> Package installers may write to any location; options such as --appdir are ignored.
  [ .. ] Error: Failure while executing; `/usr/bin/sudo -E -- env LOGNAME=tornow USER=tornow USERNAME=tornow /usr/sbin/installer -pkg /usr/local/Caskroom/virtualbox/6.0.0,127566/VirtualBox.pkg -target /` exited with 1. Here's the output:
  [ .. ] installer: Package name is Oracle VM VirtualBox
  [ .. ] installer: Installing at base path /
  [ .. ] installer: The install failed (The Installer encountered an error that caused the installation to fail. Contact the software manufacturer for assistance.)
  [ .. ] 
  [ .. ] Follow the instructions here:
  [ .. ] https://github.com/Homebrew/homebrew-cask#reporting-bugs
  [ .. ] /usr/local/Homebrew/Library/Homebrew/system_command.rb:107:in `assert_success'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/system_command.rb:50:in `run!'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/system_command.rb:27:in `run'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/system_command.rb:31:in `run!'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/artifact/pkg.rb:59:in `block in run_installer'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/artifact/pkg.rb:65:in `with_choices_file'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/artifact/pkg.rb:52:in `run_installer'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/artifact/pkg.rb:32:in `install_phase'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/installer.rb:209:in `block in install_artifacts'
  [ .. ] /System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/lib/ruby/2.3.0/set.rb:674:in `each'
  [ .. ] /System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/lib/ruby/2.3.0/set.rb:674:in `each'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/installer.rb:200:in `install_artifacts'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/installer.rb:95:in `install'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/cmd/install.rb:21:in `block in run'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/cmd/install.rb:14:in `each'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/cmd/install.rb:14:in `run'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/cmd/abstract_command.rb:34:in `run'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/cmd.rb:89:in `run_command'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/cmd.rb:155:in `run'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/cmd.rb:120:in `run'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cmd/cask.rb:7:in `cask'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/brew.rb:89:in `<main>'
  [ .. ] installer: Package name is Oracle VM VirtualBox
  [ .. ] installer: Installing at base path /
  [ .. ] installer: The install failed (The Installer encountered an error that caused the installation to fail. Contact the software manufacturer for assistance.)
  [ .. ] ==> Purging files for version 6.0.0,127566 of Cask virtualbox
  [ .. ] Installing virtualbox has failed!
  [ .. ] ==> Caveats
  [ .. ] Installing virtualbox-extension-pack means you have AGREED to the license at
  [ .. ] https://www.virtualbox.org/wiki/VirtualBox_PUEL
  [ .. ] 
  [ .. ] ==> Satisfying dependencies
  [ .. ] ==> Installing Cask dependencies: virtualbox
  [ .. ] ==> Caveats
  [ .. ] To install and/or use virtualbox you may need to enable their kernel extension in
  [ .. ] 
  [ .. ] System Preferences → Security & Privacy → General
  [ .. ] 
  [ .. ] For more information refer to vendor documentation or the Apple Technical Note:
  [ .. ] 
  [ .. ] https://developer.apple.com/library/content/technotes/tn2459/_index.html
  [ .. ] 
  [ .. ] ==> Satisfying dependencies
  [ .. ] ==> Downloading https://download.virtualbox.org/virtualbox/6.0.0/VirtualBox-6.0.0-127566-OSX.dmg
  [ .. ] Already downloaded: /Users/tornow/Library/Caches/Homebrew/downloads/c68cfddc9133da5c221557cd77b23f34e0b513dc380e6b010dc36b3d0eb2df45--VirtualBox-6.0.0-127566-OSX.dmg
  [ .. ] ==> Verifying SHA-256 checksum for Cask 'virtualbox'.
  [ .. ] ==> Installing Cask virtualbox
  [ .. ] ==> Running installer for virtualbox; your password may be necessary.
  [ .. ] ==> Package installers may write to any location; options such as --appdir are ignored.
  [ .. ] Error: Failure while executing; `/usr/bin/sudo -E -- env LOGNAME=tornow USER=tornow USERNAME=tornow /usr/sbin/installer -pkg /usr/local/Caskroom/virtualbox/6.0.0,127566/VirtualBox.pkg -target /` exited with 1. Here's the output:
  [ .. ] installer: Package name is Oracle VM VirtualBox
  [ .. ] installer: Installing at base path /
  [ .. ] installer: The install failed (The Installer encountered an error that caused the installation to fail. Contact the software manufacturer for assistance.)
  [ .. ] 
  [ .. ] Follow the instructions here:
  [ .. ] https://github.com/Homebrew/homebrew-cask#reporting-bugs
  [ .. ] /usr/local/Homebrew/Library/Homebrew/system_command.rb:107:in `assert_success'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/system_command.rb:50:in `run!'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/system_command.rb:27:in `run'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/system_command.rb:31:in `run!'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/artifact/pkg.rb:59:in `block in run_installer'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/artifact/pkg.rb:65:in `with_choices_file'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/artifact/pkg.rb:52:in `run_installer'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/artifact/pkg.rb:32:in `install_phase'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/installer.rb:209:in `block in install_artifacts'
  [ .. ] /System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/lib/ruby/2.3.0/set.rb:674:in `each'
  [ .. ] /System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/lib/ruby/2.3.0/set.rb:674:in `each'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/installer.rb:200:in `install_artifacts'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/installer.rb:95:in `install'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/installer.rb:331:in `block in cask_dependencies'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/installer.rb:324:in `each'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/installer.rb:324:in `cask_dependencies'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/installer.rb:237:in `satisfy_dependencies'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/installer.rb:58:in `fetch'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/installer.rb:89:in `install'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/cmd/install.rb:21:in `block in run'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/cmd/install.rb:14:in `each'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/cmd/install.rb:14:in `run'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/cmd/abstract_command.rb:34:in `run'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/cmd.rb:89:in `run_command'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/cmd.rb:155:in `run'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cask/cmd.rb:120:in `run'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/cmd/cask.rb:7:in `cask'
  [ .. ] /usr/local/Homebrew/Library/Homebrew/brew.rb:89:in `<main>'
  [ .. ] installer: Package name is Oracle VM VirtualBox
  [ .. ] installer: Installing at base path /
  [ .. ] installer: The install failed (The Installer encountered an error that caused the installation to fail. Contact the software manufacturer for assistance.)
  [ .. ] ==> Purging files for version 6.0.0,127566 of Cask virtualbox
  [ .. ] Installing virtualbox-extension-pack has failed!
  [ .. ] ==> Satisfying dependencies
  [ .. ] ==> Downloading https://get.videolan.org/vlc/3.0.4/macosx/vlc-3.0.4.dmg
  [ .. ] ==> Downloading from http://videolan.mirror.vutbr.cz/vlc/3.0.4/macosx/vlc-3.0.4.dmg
  [ .. ] curl: (18) transfer closed with 46000823 bytes remaining to read
  [ .. ] Error: Download failed on Cask 'vlc' with message: Download failed: https://get.videolan.org/vlc/3.0.4/macosx/vlc-3.0.4.dmg
  [ .. ] Installing vlc has failed!


  [ .. ] ==> Satisfying dependencies
  [ .. ] ==> Downloading http://updater.thebrain.com/files/TheBrain10.0.30.0.dmg
  [ .. ] curl: (56) Recv failure: Connection reset by peer
  [ .. ] Error: Download failed on Cask 'thebrain' with message: Download failed: http://updater.thebrain.com/files/TheBrain10.0.30.0.dmg
  [ .. ] Installing thebrain has failed!
```

of which VLC and theBrain where just download errors.  For VirtualBox one has to allow the installation in 
`system preferences -> Security & Privacy` and on the first tab one has to allow Oracle as developer.
When the display of 'Do you want to allow Oracle....' disappears and one re-runs bootstrap, all runs through smoothly.

# After installing everything with .dotfiles
Here comes the aftermath. We start in the following order:
- restart the computer
- login into `skype for business` and afterwards remove it from the login items\
you don't really want it to start with the computer (at least I don't)
- launch `Dropbox`, login, sync everything to the local disk
- while `Dropbox` still syncs, launch `TheBrain`, login and download the brains to the local disk
- launch `BetterSnapTool`, allow it in `system preferences -> Security & Privacy -> accessibility` to control the computer and allow `BetterTouchTool` too, we'll need it in the next step. Activate autostart at login and on the tab `extras` activate the double click on the window title bar
- Go through the internet account iCloud and deactivate iCloud & Photos - only keep Mail, Safari, Keychain, Find my Mac and Home activated
- Delete Game Center internet account
- Activate the remaining accounts for mail, contact and calendars as appropriate -> launch mail and let it sync too
- launch `BetterTouchTool` and add the 2-finger TipTap left and right gesture to trackpads and the mouse, so that one can work sanely again
- Open iTerm and add it to the list of apps that have full accessibility in `system preferences -> Security & Privacy -> accessibility`
- launch 1password and sync with dropbox (open all vault files you need)
- reactivate the `BetterTouchTool` license from fastspring.com using the order reference and email used
- Start `Alfred` and enter the power pack lifetime license key - allow full access in `system preferences -> Security & Privacy -> accessibility`
- Go to system settings and change the key shortcut for spotlight to `alt + space`
- switch alfred to `command + space` and configure `in` and `open` - allow mails
- start google chrome and log into account and let them sync too
- in the `system prerferences -> Keyboard` activate F? keys again to work normally, activate tap to click and 3-finger drag
- activate `forklift` with its license
- start `bartender` grant access in `system preferences -> Security & Privacy -> accessibility`, activate license and configure
- open Outlook and sign in to activate license and start syncing the mail
- activate license in `OmniFocus` and use syncing with the omnigroup sync server account
- activate OmniGraffle license
- activate OmniPlan license
- register dbSchema
- register Balsamiq 3
- register Daisy Disk
- I then realized that I have a license for Snagit 4 only  and not the latest. So I changed this to Snagit4 in the brew cask install
- I then registered snagit and allowed snagit & snagit helper full access to control the computer for the scrolling feature and other things
- lastly I registered Reflector 3 and Commander One
- very late in the process I realized that I'll need adobe creative cloud for installing Adobe Illustrator and Photoshop. I also downloaded the ZII patch app [https://cmacapps.com/adobe-zii-patch-only-4-0-4/] in a DMG which should always be checked thoroughly. I currently use the account adobecc@smings.com for an adobe ID. The adobe creative cloud installer doesn't get linked into the `/Applications`. Instead it resides in `/usr/local/Caskroom/adobe-creative-cloud/latest` and has to be run from there
- I then initially ran into the problem that adobe doesn't support hard drives with case sensitive volumes at all. This sucks. But this is what I wrote all this for in the first place. It is going to take a long time, but I'll simply reinstall the entire Mac from scratch. 
- After painfully reinstalling the entire Mac with plain AFPS instead of anything case-sensitive the adobe installer worked and I could install adobe creative cloud
- I then started adobe creative cloud, installed the trials for photoshop and inDesign, deactivated launch at login, always keep up to date, enable auto update, creative cloud sync, enable adobe fonts. Just go and disable pretty much everything. But especially startup and update
- In Order to test the ZII app in a sandboxed environment, I decided to set up a new virtual box as described above with nothing else but the adobe creative cloud installer, the downloaded adobe apps and the zii app
- The 4.0.9 version of the zii app didn't work with adobe CC AI and PS 2019 version as of December 31st, 2018. Hopefully the next version will do it.
- Since I also installed the creative cloud app on my macs, I now have to handle the stupid processes, that automatically start. 
I first killed all adobe processes with `ps -ef | grep dobe` and then `sudo kill -9 pid1 pid2 ...`\
These processes seem to get started via LaunchAgents in\
 - /Library/LaunchAgents and
 - ~/Library/LaunchAgents\
I guess they can all easily be deleted. I bought LaunchControl in order to gain full control over what starts on my computer and what doesn't. I deactivated all user and global daemons as much as possible. The license is, as usual, stored in 1password.


# Working on private .dotfiles in Dropbox
Since there are a lot of .dotfiles, that contain sensitive data, we want to store those in the dropbox and symlink them automatically too. 
I don't want to have to do this manually ever again. We'll have to take this leap of faith and put them in the dropbox. Even if they contain
passwords. 
Since not everything is saved in and controlled by dotfiles, we need to change the location of preferences to a dropbox folder. 
This is easy for `Alfred`. Under the tab `advanced` there is the option to `set preferences folder` (bottom right).
- I chaged it to `~/Dropbox/personal/spoa/alfred` which makes it super simple to sync and recover from (just make sure that it doesn't accidentally overwrite the settings when rebuilding a computer)
- For Forklift I tried the following (IT DID NOT WORK => forklift doesn't accept symlinks it seems). Forklifts preferences are located in `/Users/your-username/Library/Preferences/com.binarynights.ForkLift-3.plist`. I moved them to `~/Dropbox/personal/spoa/forklift/com.binarynights.ForkLift-3.plist` and symlinked them. This should work (but it doesn't) as long as I am not using forklift on 2 computers at the same time. When setting up a new computer, I'll have to delete the installation settings and just place a symlink


