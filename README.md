# Repository mirror

Periodically and automatically bring a select repository up to date with the current state of an actively worked on repository. This is scheduled through a cron job who gets a cloned mirror of the origin repository and mirror-pushes it to the select repository. This process ensures that all branches, tags, and commits are replicated in the new repository.
