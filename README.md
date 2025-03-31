# fetch-take-home

## Overview
An iOS weather app developed using SwiftUI that displays current weather and forecasts for a given location or place. It uses the "weatherapi.com" RESTful API as its data source.

### Requirements
- iOS 17.6 or later
- Xcode 16.0 or later
- SwiftUI

Just build, and run the app in a simulator or on a physical device!
The dark orange "document down arrow" icon at the top right lets you pick your test data source.

## Screenshots

| Main Screen (Light) | Main Screen (Dark) | Data Source Picker |
| -- | -- | -- |
| ![Main (Light)](https://github.com/user-attachments/assets/ba4a33fe-dc0f-41c1-9155-475ea646cb32) | ![Main (Dark)](https://github.com/user-attachments/assets/5ebdc458-db2a-4101-b7da-74dd69f542a3) | ![Data Source menu](https://github.com/user-attachments/assets/b6145c9b-457d-4fe0-be84-b35c0ebb6d38) |

## Details
### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I started off by putting together a data model that matches the JSON response.
I built an abstracted NetworkLayer with a "Live" implementation that fetches the recipes from online endpoints,
and a "Mock", used by unit tests and previews, that furnishes test data from internal JSON strings.
Also, I have enabled "Complete" Swift 6 concurrency warnings and have structured this to work with it.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent roughly six hours (somewhat broken up by some unexpected urgent tasks!)

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
I thought about using Combine and URLSession.dataTaskPublisher but opted for URLSession.shared.data(for: ) which is simple and appropriate for this task.

### Weakest Part of the Project: What do you think is the weakest part of your project?
Weakest part of this is lack of offline storage. Given more time, something I would do after a 
successful download of recipes is store/sync them with a local Core Data store for offline/no-network perusal.
One could even use the CloudKit persistent store for iCloud sync :)

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
Accessibility and Localization are always a priority when I begin a new project.
Strings are localized in this project using the newer "xcstrings" system.
Color assets for light and dark modes have been defined.
For accessibility, a summary Voice Over read off of each recipe row is performed as the user glides over them.
If less constrained for time, I would have loved to add a Details screen that shows the larger image file and provides 
the Youtube link so that the user can tapt and view the recipe video.
