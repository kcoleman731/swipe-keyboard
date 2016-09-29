# Staples Chat UI

This repository contains the source code for the `staples-chat-ui` pod. This pod is used to display custom Chat UI on top of the LayerKit SDK within the core Staples application.

The project also provides rake automation tasks to help developers version and deploy new releases (tags). Run `rake -T` to see what is available.

## Usage

The `staples-chat-ui` framework is built as a [CocoaPod](https://cocoapods.org/) using a [private specs repository](https://guides.cocoapods.org/making/private-cocoapods.html). In order to integrate the Pod into your project, put the following line at the top of your `Podfile`.

```
source 'https://bitbucket.org/tanvishah/staples-cocoapods.git'
```

Add the `staples-chat-ui` pod.

```
pod "staples-chat-ui", "0.3.7"
```

Run `pod install` to install the dependency.

## Development

### Setup

Initialize the project and its dependencies with the following command.

```
rake init
```

## Releases

### Versions

In order to release a new version of the `staples-chat-ui` pod, you must first set a new version. Set a version for a release via the following:

```
rake version:set VERSION={version_number}
```

### Releases

To tag and push a new version, do the following:

```
rake release
```
