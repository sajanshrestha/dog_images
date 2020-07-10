# dog_images
  Practice app for MVVM, Networking and iOS File Systems

- Used Apple's URLSession class to make network calls. Received data is serialized using Codable protocol.

- User will get random dog images (they can choose breed) displayed on their home screen; They can put 
 images to their favorite list. The saved favorite images is persisted through iOS Sandbox environment.
 I used FileManager default instance to get the url for Documents Directory where user's favorite
 images are saved with unique ids. 
 
 - The app is implemented in MVVM architecture and SwiftUI.
 
 
 
 <img width="180" height="380" alt="Screen Shot One" src="https://user-images.githubusercontent.com/38868680/87209126-d2991f00-c2de-11ea-9b6d-3d6b8dc01b6a.png">
