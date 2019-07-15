# Stuff that doesn't get automatically installed
- unlox - the little utility for unlocking the screen
- awsecscli - use `sudo curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-darwin-amd64-latest` fot this
Hopefully all else is covered in this repo

# holman does dotfiles

Your dotfiles are how you personalize your system. These are mine.

I was a little tired of having long alias files and everything strewn about
(which is extremely common on other dotfiles projects, too). That led to this
project being much more topic-centric. I realized I could split a lot of things
up into the main areas I used (Ruby, git, system libraries, and so on), so I
structured the project accordingly.

If you're interested in the philosophy behind why projects like these are
awesome, you might want to [read my post on the
subject](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## what's inside

A lot of stuff. Seriously, a lot of stuff. Check them out in the file browser
above and see what components may mesh up with you.
[Fork it](https://github.com/holman/dotfiles/fork), remove what you don't
use, and build on what you do use.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **Brewfile**: This is a list of applications for [Homebrew Cask](https://caskroom.github.io) to install: things like Chrome and 1Password and Adium and stuff. Might want to edit this file before running any initial setup.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/install.sh**: Any file named `install.sh` is executed when you run `script/install`. To avoid being loaded automatically, its extension is `.sh`, not `.zsh`.
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

## install

Run this:

```sh
git clone https://github.com/holman/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

`dot` is a simple script that installs some dependencies, sets sane macOS
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.


# Software that I installed manually
## PDF Printer
Download and install
https://sourceforge.net/projects/pdfwriterformac/

Then follow these steps to create the PDF Printer 

- Install PDFWriter package by double clicking
- Go to system preferences Printers and Scanners pane
- Click the Plus sign to add a printer and select PDFwriter
- In the Use: field it defaults to Generic PostScript Printer-- this doesn't work--- use the drop down and choose "Other..."
- Now you have a file dialog box, navigate to /Library/Printers/Lisanet/PDFwriter/PDFwriter.ppd and click the Open button
- You are back in the Add printer dialog box, click the Add button and you are done!

Additionally one has to know that the output of the PDF printer ends up in
`/private/var/spool/pdfwriter/YOUR-USERNAME`
so that you might want to create a symlink to this directory


## Setting up saml2aws
Follow the steps on 
https://medium.com/devopslinks/single-sign-on-with-g-suite-on-the-amazon-web-services-console-18b88c838cae
to setup a SAML app in your google G Suite account to use the G Suite 
accounts for single sign-on into AWS. When downloading the google metadata.xml
file, open the file and look for 
`Location="https://accounts.google.com/o/saml2/idp?idpid=YOUR_IDP_ID`
Additionally go into your G Suite Admin Console, navigate to your SAML Apps
https://admin.google.com/AdminHome?hl=en#AppsList:serviceType=SAML_APPS
and click on details. In the URL bar, you'll see 
`https://admin.google.com/AdminHome?hl=en#AppDetails:service=YOUR_SPID `

Then set up saml2aws with
`saml2aws configure`
Enter 
`https://accounts.google.com/o/saml2/initsso?idpid=YOUR_IDP_ID&spid=YOUR_SPID&forceauthn=false`
as URL and then just follow the remaining instructions. 
Afterwards you can login and retrieve temporary AWS CLI credentials via
`saml2aws login` 
They are automatically saved into `~/.aws/credentials`. You might have to
activate the AWS profile. To gain an overview of your available profiles,
just enter `awscp` to see the available and the currently chosen profile.
With `awsp <profile_id>` you can change the used profile.
You can the use the aws cli with the assumed role's scope.
If there is just one role, this will be assumed automatically.
If there are multiple roles, you have to specify the role with which you
want to use in the attribute `--role=arn:.....`

## Sketchup Weld Plugin / Extension 
https://extensions.sketchup.com/en/content/weld
I downloaded it and then installed it via the Window -> Extension Manager
dialogue

## Audacity
There is no Cask for installing audacity anymore unfortunately
https://www.fosshub.com/Audacity.html?dwl=audacity-macos-2.3.2.dmg
This is the version I installed

## bugs

I want this to work for everyone; that means when you clone it down it should
work for you even though you may not have `rbenv` installed, for example. That
said, I do use this as *my* dotfiles, so there's a good chance I may break
something if I forget to make a check for a dependency.

If you're brand-new to the project and run into any blockers, please
[open an issue](https://github.com/holman/dotfiles/issues) on this repository
and I'd love to get it fixed for you!

## thanks

I forked [Ryan Bates](http://github.com/ryanb)' excellent
[dotfiles](http://github.com/ryanb/dotfiles) for a couple years before the
weight of my changes and tweaks inspired me to finally roll my own. But Ryan's
dotfiles were an easy way to get into bash customization, and then to jump ship
to zsh a bit later. A decent amount of the code in these dotfiles stem or are
inspired from Ryan's original project.
