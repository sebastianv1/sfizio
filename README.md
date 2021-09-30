# Sfizio - Homebrew Version Control

Sfizio is a Homebrew version control system. Keeping a formula's version consistent across developer machines and CI isn't a natural process of using `brew`. Keeping all machines up to date requires refreshing the taps and upgrading the formulas (if there's a new release) on each install. If you've managed to configure this correctly, you'll find at some point it's impossible to downgrade a version if a new release breaks your workflow. Homebrew's suggested solution to versioning your formulas is to setup your own third-party tap. This works for the most part; however, downgrading a formula due to an issue still isn't an easy process due to Homebrew's affinity for keeping formulas at the latest available version.

Sfizio solves this by providing a familiar `Brewfile` for versioning your formulas and controlling the versions installed across all machines.

## Using Sfizio

Create a `Brewfile` in the root of your repo, and add formulas with the syntax: `formula [name], [version], tap: [source]`.

```
formula 'cloc', '1.90'
formula 'sqlite', '3.36.0'
formula 'python', '3.9'
```

To install, run `sfizio install` instead of `brew install` or your previous installation command.

## Next Steps & Contributing
This project is still in its infancy. Next steps for this project include:
* Creating a `Brewfile.lock`. Currently Sfizio only supports specific verions and cleans up state before each installation. This means that we may `unlink` and then `link` the same version again in each release if nothing has changed. Although this is fast, it's not optimal.
* Configure proper CLI commands. Existing implementation
    - Include a `cleanup` option
* Properly distribute this with RubyGems.

