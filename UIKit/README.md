<h1 align="center">
  Organizer UIKit
</h1>


<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#introduction">Introduction</a></li>
    <li>
      <a href="#architecture">Architecture</a>
      <ul>
        <li><a href="#mvvm">MVVM</a></li>
        <li><a href="#coordinator">Coordinator</a></li>
        <li><a href="#viewrepresentation">ViewRepresentation</a></li>
      </ul>
    </li>
  </ol>
</details>

## Introduction
The Organizer app (described [here](../README.md)) developed with `UIKit` (see the [SwiftUI](../SwiftUI) counterpart)

It uses [SwiftData](https://developer.apple.com/documentation/swiftdata), [Concurrency](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/), [Property wrappers](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Property-Wrappers), [Opaque types](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/opaquetypes/) and [Share extension](https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/Share.html).

## Architecture
This project is developed with the `MVVM-C` and `ViewRepresentation` patterns 


Each module (`ProjectList`, `ProjectForm`, `ContentList`, `ContentForm`) is mainly composed of the following:
```
Module Name
    Controller
    Coordinator
    Models
    Views
        ViewRepresentation
    ViewModel
```

### MVVM
MVVM stands for `Model - View - View Model` and is structured to separate program logic from user interface controls.


The **View** handles the layouts and display the data.<br>
The **ViewModel** formats the data and deals with the business logic.<br>
The **Model** represents the data.

### Coordinator
This pattern lets us remove the job of app navigation from the view controllers making them unaware of their position in the app’s flow and thus helps making them more manageable and more reusable.

Resources: [Soroush Khanlou](https://khanlou.com/2015/01/the-coordinator/), [Hacking with Swift](https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps)

### ViewRepresentation
This pattern adds an extra layer that lets us remove the details about how a view should be setup from the view itself (colours, fonts, …) and thus making it easier to read and edit.

