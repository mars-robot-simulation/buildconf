# Reference Architectures Build Configuration

This is the main build configuration of an autoproj installation for the
MARS example application.
If asked for it during the installation select 'master' as flavour of Rock.

### How to add/request changes?
If you want to change this build configuration please create a merge request for
the master branch of this build configuration. Make sure you use meaningful commit messages.

Merge requests can be commented/reviewed by other maintainers.
Final merge, should only be performed after a minimum of review.

## Usage of autoproj
See https://rock-robotics.org/documentation/autoproj/ for detailed information about autoproj.
To install this build configuration:
Make sure you have the required autoproj dependencies installed:

```
sudo apt-get install ruby ruby-dev wget build-essential
```

Then continue with:

```
mkdir mars-dev
cd mars-dev
wget http://rock-robotics.org/master/autoproj_bootstrap
ruby autoproj_bootstrap git git@github.com:mars-robot-simulation/buildconf.git
```
Once bootstrapped, the main build configuration is checked out in the
workspace's `autoproj/` folder.
You can now comment the software that you do not need in the autoproj/manifest.
After that perform the installation of the operating system dependencies 
and build the remaining packages with:
```
source env.sh
autoproj osdeps
amake
```

### Day-to-day workflow

`aup` updates the current package (or, if within a directory, the packages
under that directory). Use `--all` to update the whole workspace.

`amake` build the current package (or, if within a directory, the packages
under that directory). Use `--all` to build the whole workspace.

`autoproj status` will show the difference between the local workspace and
the remote repositories

`autoproj show PACKAGE` will display the configuration of said package, which
includes whether that package is selected in the current workspace ("a.k.a.
will be updated and built") and the import information (where the package
will be downloaded from)

### Autoproj configuration structure

The main build configuration tells autoproj about:

- which extra configurations should be imported ("package sets") in the
  `package_sets` section of the `manifest`. Once loaded, these package
  sets are made available in the `remotes/` subfolder of this configuration.
- which packages / package sets should be built in the `layout` section of
  the `manifest`
- which local overrides should be applied on package import (e.g. allowing
  to change a package's import branch or URL) in `.yml` files located in
  the `overrides.d` folder.

Overall, autoproj does the following with its configuration:

- load package description by (1) importing the package sets listed in
  `manifest` and (2) loading the `.autobuild` files in the imported package sets.
  Imported package sets are made available in the `remotes/` folder of this
  directory.
- resolve the import information (which can be inspected with `autoproj show`)

### Using extra RubyGems in an autoproj workspace

One can add new gems to a workspace, without passing through autoproj's osdeps
system, by adding new `.gemfile` files to the workspace's
`autoproj/overrides.d/` folder. These files must follow
[Bundler](http://bundler.io) gemfile format


# Contact
If you have questions on how to use/adapt this buildconf please contact Malte.Langosz@dfki.de


