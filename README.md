# Staples Chat UI

This repository contains the source code for the `staples-chat-ui` pod. This pod is used to display custom Chat UI cards within the core Staples application.

The core application relies on two third party frameworks to power its chat functionality:

* [LayerKit](https://github.com/layerhq/releases-ios) - Messaging SDK that powers the messaging infrastructure and data synchronization.  
* [Atlas](https://github.com/layerhq/Atlas-iOS)-  UI framework that powers the actual chat UI.

The `Atlas` UI framework provides simple out of the box messaging UI, but requires applications to provide custom `UICollectionViewCell`s for more advanced usage. The `staples-chat-ui` pod provides a number of custom collection view cells that handle displaying the Staples BOT cards. The framework leverages the `Atlas` customization hooks in order to do so.

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

The `staples-chat-ui` project relies on multiple Ruby tools for dependency management (CocoaPods, Bundler) and automation (Rake). In order to ensure that your machine has all of the proper dependencies installed, initialize the project by running the following command. This will install any missing dependencies and update versions as needed.

```
rake init
```

This project provides numerous `rake` automation tasks to help developers version and deploy new releases (tags). Run `rake -T` to see what is available.

## Releases

### Versions

In order to release a new version of the `staples-chat-ui` pod, you must first set a new version. The `staples-chat-ui` project uses [semantic versioning](http://semver.org/).

Set a version for a release via the following:

```
rake version:set VERSION={version_number}
```

### CHANGELOG

After bumping the version number, you must also add an entry to the CHANGELOG.md. CHANGELOG entries should be descriptive of the changes that are included in the release.

### Releases

To tag and push a new version, do the following:

```
rake release
```
