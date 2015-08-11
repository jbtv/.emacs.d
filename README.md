# IRIS.TV Emacs config

#### Evil

My intention is first to make Emacs mimic my vim config and then to improve on it.

#### Clojure

It's clojure-centric at this point.

  + clojure-mode
  + clj-refactor
  + evil-paredit
  + evil-surround
  + clojure-snippets
  + cider
  + ac-cider

#### Requirements

  + Emacs >= 24.4.1
  + Cask https://github.com/cask/cask

#### Additional requirements for Clojure editing
  + Clojure
  + Leiningen
    + some lein plugins (see below)

##### Here's my ~/.lein/profiles.clj

```clojure
    {:user {:dependencies [[org.clojure/tools.nrepl "0.2.10" ]]
            :injections []
            :plugins [[lein-pprint "1.1.1"]
                      [lein-midje "3.0.0"]
                      [refactor-nrepl "1.0.0"]
                      [cider/cider-nrepl "0.9.0-SNAPSHOT"]
                      [lein-try "0.4.3"]]}}
```

#### Install

```bash
    $ mv ~/.emacs.d ~/.emacs.d.old
    $ git clone https://github.com/blak3mill3r/emacs.d.git ~/.emacs.d
    $ cd ~/.emacs.d
    $ rm -rf .git
    $ cask install
    $ emacs
```

#### Install for the impatient/credulous (it does the same as the above)

```bash
    $ curl -fsSL https://raw.githubusercontent.com/blak3mill3r/emacs.d/master/go | bash
```
