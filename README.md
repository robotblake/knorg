# knorg

Changes the current knife organization.

## Installation

Place the `share/knorg/knorg.sh` file anywhere and source it in your
`~/.bashrc` or `~/.bash_profile`.

By default, the script looks in the `~/.knives` directory and includes
any sub-directories that contain a `knife.rb` file. If you want to
override or manually include any additional directories, just modify the
`KNIVES` environment variable after loading the script.

## Commands

* `knorg -h` for usage information
* `knorg -v` for version information
* `knorg` will list available organizations
* `knorg myorg` will attempt to find the **myorg** organization and set
  `KNIFE_HOME` to its path

## Development

The tests require [shunit2] to run.
