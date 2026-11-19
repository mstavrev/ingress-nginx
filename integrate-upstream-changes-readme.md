# Integrating Chainguard upstream changes

The personal branch is `chainguard`. Its source branch is `main` on the
`chainguard` remote (`https://github.com/chainguard-forks/ingress-nginx`).
Do not merge from `origin/main` or replace the original fork's `master`.

## Sync the branch

Start with a clean working tree so conflicts and local work are easy to identify:

```sh
git status --short
git fetch chainguard main
git switch chainguard
git merge chainguard/main
```

Resolve conflicts by keeping upstream fixes while retaining the local image
publishing customizations below. Do not resolve them by replacing the whole file
with either side.

## Preserve the Docker Hub build

- Keep `REGISTRY` defaulting to `docker.io/mstavrev` in the root `Makefile` and
  `images/nginx/Makefile`. The release workflow supplies
  `docker.io/${{ vars.DOCKER_USERNAME }}` so the workflow uses the configured
  Docker Hub account.
- When updating from Chainguard, set the root `TAG` file to the version from
  the highest stable `controller-vX.Y.Z` tag on the `chainguard` remote. Inspect
  the available tags with
  `git ls-remote --tags chainguard 'refs/tags/controller-v*'`, choose the
  highest semantic version (not simply the last lexicographically listed tag),
  and drop the `controller-` prefix when writing `TAG` (for example,
  `controller-v1.15.16` becomes `v1.15.16`). This is the controller version;
  keep it distinct from `images/nginx/TAG`, which controls the NGINX image tag.
- The current build is amd64-only: keep `PLATFORMS` and `BUILDX_PLATFORMS`
  aligned in the root Makefile and `images/nginx/Makefile`.
- Keep `NGINX_BASE` pointed at the Docker Hub NGINX image whose tag matches
  `images/nginx/TAG`. Build/publish that NGINX image before building controller
  images.
- Keep `.github/workflows/release.yaml` restricted to `mstavrev`'s `watch`
  events, with Docker Hub credentials supplied by the
  `DOCKER_USERNAME` repository variable and `DOCKER_PERSONAL_TOKEN` secret.
  It publishes the NGINX image, then the controller and controller-chroot
  images.

## Check the NGINX parser patch

After an upstream NGINX update, check whether tab handling is already present
before keeping the local patch. If it is needed, update
`images/nginx/rootfs/patches/99_nginx-<version>-header-value-tab.patch` for the
new NGINX source version and ensure it remains last in the numbered patch order.
Verify that the full patch stack applies and that the NGINX build/tests pass.
Do not add a duplicate patch if upstream already handles tabs in all three
header-value parsing states.

Before publishing, review the diff and run relevant checks, such as
`make -C images/nginx test`, `make image`, and `make image-chroot`. These build
locally; the release targets `make -C images/nginx push` and `make release`
publish images. The release workflow also publishes when `mstavrev` stars the
repository, so review the workflow and configured credentials before enabling
it.

Push only the reviewed `chainguard` branch to `origin`; do not push to or change
the original fork's `master`.
