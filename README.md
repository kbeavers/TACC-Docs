# TACC Core CMS

The base CMS code for TACC WMA Workspace Portals & Websites

## Local Development Setup

Local development instructions assume the use of Docker. You may choose instead to locally develop directly via [MkDocs], but you will be responsible for installing dependencies.

[MkDocs]: https://www.mkdocs.org/

### Prequisites for Running the Docs

* Docker 20.10.7
* Docker Compose 1.29.2
* Python 3.6.8

The Docs can be run using [Docker][1] and [Docker Compose][2]. You will
need both Docker and Docker Compose pre-installed on the system you wish to run the Docs
on.

If you are on a Mac or a Windows machine, the recommended method is to install
[Docker Desktop](https://www.docker.com/products/docker-desktop), which will install both Docker and Docker Compose as well as Docker
Machine, which is required to run Docker on Mac/Windows hosts.


### Running the Docs

2. [Create and run][docker-compose-up] the CMS and database containers:

    ```bash
    docker-compose up
    ```

[docker-compose-up]: https://docs.docker.com/compose/reference/up/


## Linting and Formatting Conventions

Not standardized. See [(internal) Formatting & Linting](https://confluence.tacc.utexas.edu/x/HoBGCw).


## Automatic Builds

Automatic builds (not deploys) should occur on pushes to any branch.


## Automatic Deployment

Automatic deploys should occur after an automatic build on the `main` branch.


## Contributing

### Development Workflow

We use a modifed version of [GitFlow](https://datasift.github.io/gitflow/IntroducingGitFlow.html) as our development workflow. Our [development site](https://dev.cep.tacc.utexas.edu) (accessible behind the TACC Network) is always up-to-date with `main`, while the [production site](https://prod.cep.tacc.utexas.edu) is built to a hashed commit tag.
- Feature branches contain major updates, bug fixes, and hot fixes with respective branch prefixes:
    - `task/` for features and updates
    - `bug/` for bugfixes
    - `fix/` for hotfixes

### Best Practices

Sign your commits ([see this link](https://help.github.com/en/github/authenticating-to-github/managing-commit-signature-verification) for help)

### Resources

* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)


<!-- Link Aliases -->

[1]: https://docs.docker.com/get-docker/
[2]: https://docs.docker.com/compose/install/
