. .config

# Make sure that the cloned repository (still) exists
git ls-remote "$absolute_path_to_cloned_repo" -q

if [ $? -eq 0 ]; then
    cd "$absolute_path_to_cloned_repo"

    # Download objects and refs from origin repository, prune unreachable objects
    git fetch -p origin

    # Update remote refs along with associated objects to target repo
    git push --mirror
else
    echo "The local repository folder has been deleted or has been moved."
fi
