. .config

cd "$absolute_path_to_cloned_repo"

# Download objects and refs from origin repository, prune unreachable objects
git fetch -p origin

# Update remote refs along with associated objects to target repo
git push --mirror
