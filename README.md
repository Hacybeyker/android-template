# Android Template

This is a template project to facilitate the creation of a project or library in android.
It has different configurations, which are:

- SonarQube
- JaCoCo
- Github Actions

And it also has the configuration of
- KtLint
- Detect.

The `jarvis.sh` wizard facilitates the creation and configuration of the project from the console as selected, it is located in the root of the project. Check the usage section for the creation of projects.

You can create these 3 types of projects which are:

| Template | Description |
|--|--|
|  main| For main project, generate apk or aab.  |
|  module| For library project, generate aar.  |
|  flavors| For library project with flavors, generate apk or aab for flavor. |


## Feature

### 🖼️ UI
Interface with compose support

### 🧱 Build
* [KTS gradle files](https://docs.gradle.org/current/userguide/kotlin_dsl.html)
* [Version catalog](https://docs.gradle.org/current/userguide/platforms.html)

### 🏠 Architecture
* Dependency injection with [Hilt](https://developer.android.com/training/dependency-injection/hilt-android)
* [Jetpack ViewModel](https://developer.android.com/topic/libraries/architecture/viewmodel)
* UI using [Jetpack Compose](https://developer.android.com/jetpack/compose) and
  [Material3](https://developer.android.com/jetpack/androidx/releases/compose-material3)
* [Jetpack Navigation](https://developer.android.com/jetpack/compose/navigation)
* [Kotlin Coroutines](https://developer.android.com/kotlin/coroutines)
* [Unit tests](https://developer.android.com/training/testing/local-tests)
* [UI tests](https://developer.android.com/jetpack/compose/testing) using fake data with
  [Hilt](https://developer.android.com/training/dependency-injection/hilt-testing)


## Usage

1. Download the [jarvis.sh](https://raw.githubusercontent.com/Hacybeyker/android-template/feature-actions-lint/jarvis.sh) file:
2. Run the `jarvis.sh` file from your preferred terminal:
```
bash jarvis.sh
```
3. Provide the wizard with the required information and the settings you want to add to the project.
