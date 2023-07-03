#To merge a specific tag from kubernetes/ingress-nginx into our master, do

1. Fetch all changes from upstream(kubernetes/ingress-nginx)

git fetch --tags upstream

2. Make sure we are on our fork's master:

git checkout master

3. Merge the tag from upstream (for example, tag controller-v0.34.1)

git merge controller-v0.34.1

4. Fix conflicts if any

5. Edit:
    - images/nginx/Makefile: increment the value for TAG
    - Makefile: set the BASE_IMAGE's tag to the same value as incremented above 
    - (optionally) Update TAG file

6. Commit and rebase on the remote/upstream/tag that had been merged

7. Push



