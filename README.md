Insied the xcodeproject you will wind 3 subsystems, 1 of them (starships) is implemented with GraphQL and Apollo, 
but doesnt have pagination feature. Other 2 are implemented with basic REST-API, but they do have pagination feature 
(need to mention, that in personView i do have GraphQL request to the planet name).

Regarding security I implemented only FaceID recognition, as it was defined, that i have a choice between pin and biometrics.

My code works for Version 17.0++

Description
The goal of this task is to implement a reference book for the Star Wars universe using SwiftUI
and the GraphQL endpoint SWAPI. Even though the tasks build on each other it is recommended
to read the whole task description before starting to code.
Part 1: Core functionalities
The application consists of the following three lists that can be switched using a nav bar at the
bottom of the screen. For each of the list items display the corresponding name as the title and
the amount of film references as a subtitle.
1. Characters list (called people in the Api)
2. Star ships
3. Planets
Part 2: Lazy list
You now realize that there are plenty of items per list. If not already implemented, add pagination
to your list queries. You can play around to find a suitable page size. SWAPI’s pagination is a
cursor pagination. It is up to you whether you keep the data cursor paginated on the end users
phone or map the data model as a lazy list.
Part 3: Detail view
Clicking on a list item must forward to a dedicated view that contains at least 6 additional at-
tributes for the selected list item. You can check out the endpoint SDL / playground to get some
insights. You decide how you want to present this information. Be creative!
Part 4: Favorites
We like some characters more than others and want to reflect that in the app. For this reason,
the list of characters should have an additional function with which you can mark individual list
elements as favorites. Possible solutions are SwiftUI swipe actions, a button in the list element
or a context menu. If an element has been marked as a favorite, it should also be highlighted
visually. To be able to access the favorites even faster, this list must have a filter, which limits
the content to our favorites. Note: Make sure that no additional request is made to the server
when the filter is applied.
Part 4: Security
Since our app contains sensitive data :), we have to make sure that it remains protected. To
access the app, it must be unlocked in advance either via iPhone pin or biometrically.
Our expectations
What we want to see from you is a logical view based breakdown of the project. Make sure
to separate data fetching code and UI code. We do not provide any design templates. Please
come up with an appealing and consistent UI while sticking to best practices throughout the
project. Furthermore, we want to see that you understand the SwiftUI lifecycle and can apply it.
The libraries below will give you some ideas how to start and are mandatory for the completion
of the task.
Resources and libraries
• SWAPI endpoint + playground
• SwiftUI
• SwiftUi MVVM
• Apollo Client iOS
• ApolloSQLite
• Graphql Codegeneration