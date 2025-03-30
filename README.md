# Zsh Configuration

## Step 1: Install Antidote [Plugin Manager](https://antidote.sh/)

## Step 2: Create Symbolic Links for `.zshrc` and `.zsh_plugins.txt`
After cloning this dotfiles repository, create symbolic links for the `.zshrc` and `.zsh_plugins.txt` files to your home directory. This will allow you to load the configuration and plugin list automatically.
```sh
ln -s /path/to/cloned/repo/.zshrc $HOME/.zshrc
ln -s /path/to/cloned/repo/.zsh_plugins.txt $HOME/.zsh_plugins.txt
```

## Step 3: Add New Plugins
Any plugins you want to add can be listed in the `.zsh_plugins.txt` file. Simply open the file and add the plugin names (one per line). For example:

```text
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-autosuggestions
```

Once added, Antidote will automatically load them the next time you start a Zsh session.