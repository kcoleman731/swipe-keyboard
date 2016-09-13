# Staples Chat UI

This repository contains the source code for the `staples-chat-ui` pod. This pod is used to display custom Chat UI on top of the LayerKit SDK within the core Staples application.

The project also provides rake automation tasks to help developers version and deploy new releases (tags). Run `rake -T` to see what is available.

## Usage

```
source 'https://bitbucket.org/tanvishah/staples-cocoapods.git'

pod 'staples-chat-ui'
```

## Development

### Setup

Initialize the project and its dependencies with the following command.

```
rake init
```

### Versions

Set a version for a release via the following:

```
rake version:set VERSION=<version_number>
```

### Releases

To tag and push a new version, do the following:

```
rake release
```
