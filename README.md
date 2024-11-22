## Weather Tracker App

### Steps to run the app:
- Pull down the app from the git repository and run the app in Xcode. 
- When the app is ran for the first time, you will be presented with the empty state view until you search and select a weather query result.
- Tap on the search bar and type in the city you want to query for the current day's weather.
- When you are ready to search, tap "return" or tap the magnifying glass image.
- If your search is valid, a preview of the weather from the city that is found from your query will be displayed in a small card. If invalid, you will be alerted to try again as the query was not valid.
- Once the result card is tapped, you will be shown the full view of the app with more detail of the queried weather result. This will save the result in the app as well, until another successful queried result is tapped.
- When the app is hard closed and restarted, the last tapped queried result will be shown instead of the empty state view. This will also stay persisted until another successful queried result is tapped.

### Focus Areas: 
Async await networking layer with generic object setting for parsing and flexibility, dependency injection, Swift Concurrency. I feel these areas are key because they are essential for not only the app to run smoothy, but for other developers to come in and be able to hit the ground running to add features and maintain the app. I practice these no matter the size of the app.

### Time Spent: 
About 5.5 hours. The extra time was spent on adding some unit tests to the app for light coverage.

### Trade-offs and Decisions:
Instead of using a external framework for image caching, I created a custom cache that utilized SwiftUI's AsyncImage. This saved on significant built time and gave more to customization of caching in the app, and could be used as a template to use for other objects.

### External Code and Dependencies:
I used some code snippets that I have had from previous personal projects. I did not use any external dependancies for this project.

### Additional Information:
This is an awesome take home interview project and it is refreshing to see. I feel I was able to exhibit a lot of my SwiftUI knowledge here.






