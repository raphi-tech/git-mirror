# Repository mirror

Periodically and automatically bring a select repository up to date with the current state of an actively worked on repository. This is scheduled through a cron job who gets a cloned mirror of the origin repository and mirror-pushes it to the select repository. This process ensures that all branches, tags, and commits are replicated in the new repository.

## How to use it (Windows)
Make sure you setup SSH authentication for both repositories.

> Keep in mind: "With SSH keys, if someone gains access to your computer, the attacker can gain access to every system that uses that key. To add an extra layer of security, you can add a passphrase to your SSH key. To avoid entering the passphrase every time you connect, you can securely cache the key in the SSH agent."

First you need to generate a new SSH key on your local machine. 
After you generate the key, you have to add the public key to your account on the platforms your repository is on to enable authentication for Git operations over SSH.

### Generate a new SSH key
1. Open Git Bash
2. Paste the text below, replacing the email used in the example with your platform specific email address.
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```
When you're prompted to "Enter a file in which to save the key", type the default file location and replace id_ALGORITHM with your custom key name.

> Enter file in which to save the key (/c/Users/YOU/.ssh/id_ALGORITHM): [/c/Users/YOU/.ssh/custom_key_name]


3. At the prompt, type a secure passphrase or leave empty for no passphrase.
> Enter passphrase (empty for no passphrase): [Type a passphrase]
> Enter same passphrase again: [Type passphrase again]

### Adding your key to the SSH agent
1. Open new admin elevated PowerShell window to launch the ssh-agent manually (or skip this if you already configured auto-launching ssh-agent on Git for Windows - see point 3)

```powershell
# start the ssh-agent in the background
Get-Service -Name ssh-agent | Set-Service -StartupType Manual
Start-Service ssh-agent
```

2. In a terminal window without elevated permissions, add your SSH private key to the ssh-agent.

```bash
ssh-add 'C:\Users\YOU\.ssh\custom_key_name'
```

3. To run ssh-agent automatically when you open bash or Git shell, copy the following lines and paste them into your ~/.profile or ~/.bashrc file in Git shell
```bash
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env
```


## References
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=windows (see also for: setup in MacOS or Linux)
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/working-with-ssh-key-passphrases (see also for: adding and changing a passphrase)
