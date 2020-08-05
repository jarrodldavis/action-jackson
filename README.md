# Action Jackson

> A template for developing a WordPress site locally in Visual Studio Code and deploying to Flywheel.

## Overview

This template contains the necessary configuration to set up a WordPress site:

- in development, using local containers with Visual Studio Code and Docker
- in production, using GitHub Actions to deploy changes to Flywheel

## Usage

### New Sites

If you're just getting started on a new site, click the "Use this template" button. See [these instructions in the GitHub Docs][use-template] for more information.

### Existing Sites

If you already have repository you'd like to deploy to Flywheel, [create a workflow file][creating-a-workflow] in your repository and copy the contents of [this workflow][main.yml] into it.

Optionally, you can copy the `.devcontainer` directory into your repository if you want to use the [Visual Studio Code Remote Containers][remote-ext] extension.

## Deployment Configuration

Once you have a repository with the GitHub Actions worfklow, you'll need to configure it with your SFTP details.

This workflow is set up to deploy a `wp-content` directory to `sftp://sftp.flywheelsites.com/[site-owner]/[site-name]/wp-content`, where `[site-owner]` is the user or organization that owns the site, and `[site-name]` is the name/ID of the site.

The `wp-content` directory is chosen as the destination of the deployment since Flywheel, as a [Managed WordPress host][flywheel-managed], automatically [manages core WordPress files][flywheel-security], and as such only the `wp-content` directory is relevant for deployments.

In the GitHub Actions workflow file, update [these `env` values][env-values]:

### `SFTP_SOURCE`

This is the folder in your git repository that will be uploaded to your site on Flywheel.

By default, this workflow assumes the root of the repository is the `wp-content` directory such that `themes` and `plugins` are top-level folders in the repository (as exemplified in this template). If `wp-content` is in a sub-directory of your repository, be sure to update `SFTP_SOURCE` to point to it.

#### Examples

- `SFTP_SOURCE: ./`
- `SFTP_SOURCE: ./path/to/wp-content`

### `SFTP_OWNER`

This is the Flywheel user or organization that owns the site. Keep in mind that this may be different from your Flywheel username if the site is part of an organization or you are a collaborator on the Flywheel site.

#### Examples

- `SFTP_OWNER: my-username`
- `SFTP_OWNER: org-my-organization-name`

### `SFTP_SITE`

This is the site ID (sometimes called a "slug") for the site, as you would see in your SFTP client. This corresponds to the site name as configured in the Flywheel Dashboard.

#### Examples

- `SFTP_SITE: my-site-name`

### `SFTP_USER`

This is the username you use to log into Flywheel. Keep in mind that this may be different from the site owner.

#### Examples

- `SFTP_USER: my-username`

### `SFTP_PASSWORD`

**Do not configure your SFTP password in the GitHub Actions workflow file**. It is *dangerous* to put your password in plaintext configuration files, even if your repository is private. Instead, [configure a repository secret][repo-secret] named `SFTP_PASSWORD`.

[use-template]: https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-from-a-template

[main.yml]: https://github.com/jarrodldavis/action-jackson/blob/main/.github/workflows/main.yml

[remote-ext]: https://code.visualstudio.com/docs/remote/containers

[creating-a-workflow]: https://docs.github.com/en/actions/configuring-and-managing-workflows/configuring-a-workflow#creating-a-workflow-file

[flywheel-managed]: https://getflywheel.com/wordpress-support/what-does-managed-wordpress-hosting-mean/

[flywheel-security]: https://getflywheel.com/wordpress-support/how-does-flywheel-keep-my-site-secure/#wp-core-locked

[env-values]: https://github.com/jarrodldavis/action-jackson/blob/50358697f17328631d095d556959e7638c2adcfc/.github/workflows/main.yml#L19-L51

[repo-secret]: https://docs.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets#creating-encrypted-secrets-for-a-repository
