# Repository mirror

Periodically and automatically bring a select repository up to date with the current state of an actively worked on repository. This is scheduled through a cron job who gets a cloned mirror of the origin repository and mirror-pushes it to the select repository. This process ensures that all branches, tags, and commits are replicated in the new repository.

## How to use it
Make sure you setup SSH authentication for both repositories.

For that you need to generate a new SSH key on your local machine. After you generate the key, you have to add the public key to your account on the platforms your repositories will be on to enable authentication for Git operations over SSH.

### Generate a new SSH key
1. Open Git Bash
2. Paste the text below, replacing the email used in the example with your platform specific email address.
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```
See https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=windows for an instruction.
