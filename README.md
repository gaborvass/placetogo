Simple app to show interesting places around the user.

How to run the app:
- open `PlaceToGo.xcworkspace` in Xcode and click on `Run`

Configuration:
App uses the Foursquare API to fetch venues, which requires registration.
The Foursquare credentials have to be added to the app's `Info.plist` file.

Note
Please take in mind that getting venue details is a Premium endpoint, meaning max. number of requests are 50 per day.
If quota exceeded, request will fail and app won't be able to show the details.
