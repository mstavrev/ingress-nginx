#To merge a specific tag from kubernetes/ingress-nginx into our master, do

1. Fetch all changes from upstream(kubernetes/ingress-nginx)

git fetch --tags upstream

2. Make sure we are on our fork's proper release branch, for example my-release-1.13:

git checkout my-release-1.13

3. Merge the tag from upstream (for example, tag helm-chart-4.13.3)

git merge helm-chart-4.13.3

4. Fix conflicts if any

5. Edit:
    - NGINX_BASE: update to point to the nginx base image (should be the combination of docker.io/mstavrev/nginx and the tag in images/nginx/TAG)

6. Commit and push

7. Update master's head to point to the head of the release branch - for example, my-release-1.13

8. Trigger the build via github site
