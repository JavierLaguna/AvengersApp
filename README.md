# Avengers App

[![forthebadge](https://forthebadge.com/images/badges/made-with-swift.svg)](https://forthebadge.com)

> Avengers App is a practice of 'persistencia-instrumentacion-optimizacion' for KeepCoding Mobile 10

## Application Structure

[Swift](https://developer.apple.com/swift/) app based on ([MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) + [Coordinators](https://medium.com/@saad.eloulladi/ios-coordinator-pattern-in-swift-39a15aa3b01b)) as main architecture.

App Features:

###### Avengers
   - Avengers List
   - Avenger Detail
   - Edit Avenger Power

###### Battles
   - Battle List
   - Crete New Battles
   - Battle Detail
   - Delete Battles
   
###### Villains
   - Villains List
   - Villain Detail
   - Edit Villain Power

###### Extra
   - Manage CoreData database on a background context
   - Keep last tab visited

### TODO
   - Fix bug - lose context when change tab and is not the main tab screen
   - Improve some equal classes for Avenger and Villains using protocols with generics
   - Improve avoid delegation patter, implement Rx for example
   - Notify database changes without delegates, impement Notifications for example
   - Initial load JSON data on background thread
   - Fix constraints console errors
   - Improve UI for all devices
   
##### Author
> Javier Laguna
