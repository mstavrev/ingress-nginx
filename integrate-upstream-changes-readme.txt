#To merge a specific tag from kubernetes/ingress-nginx into our master, do

1. Fetch all changes from upstream(kubernetes/ingress-nginx)

git fetch --tags upstream

2. Make sure we are on our fork's master:

git checkout master

3. Merge the tag from upstream (for example, tag controller-v0.34.1)

git merge controller-v0.34.1

4. Fix conflicts if any

5. Edit:
    - Makefile: set the TAG to the value for this nginx-ingress release
    - NGINX_BASE: update to point to the nginx base image (should be the combinateion of docker.io/mstavrev/nginx-1.25 and the tag in images/nginx-1.25/TAG)

6. Commit and rebase on the remote/upstream/tag that had been merged

7. Push
