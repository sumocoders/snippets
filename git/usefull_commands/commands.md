# Show changed files between two commits

    git diff --name-only <commit1> <commit2>

# Show changed files since specific commit

    git diff --name-only HEAD <commit>

# Git status for multiple folders

	for dir in *; do cd $dir; git st; cd ..; done
	
# Push local branch to remote

	git push origin <branchname>
	
# List changed files in a given commit

	git show --pretty="format:" --name-only <commit>
