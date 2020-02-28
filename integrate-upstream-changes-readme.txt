#To merge a specific tag from kubernetes/ingress-nginx into our master, do

1. Fetch all changes from upstream(kubernetes/ingress-nginx)

git fetch --tags upstream

2. Make sure we are on our fork's master:

git checkout master

3. Merge the tag from upstream (for example, tag controller-v0.34.1)

git merge controller-v0.34.1

4. Fix conflicts

5. Build


