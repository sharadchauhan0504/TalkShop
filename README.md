# TalkShop

## Instructions
- Clone and run directly

### Walkthrogh
- Loaders: Loading indicators are added in mock server call for 1 second.
- Alerts: API failure alerts are added. (To test, remove any '{' or '}' from mock response files)
- Home feed: Shows grid of videos ( only thumbnail, username and likes are shown on this screen). Pull to refresh is added. Fade in animation for cells added. Slight bounce effect on clicking any video.
- Post Details: On clicking video, it starts playing the video when it's ready (there is thumbnail at the beginning which fades out once player is ready to play the file). Profile picture, username and likes are shown. Double tap on screen or on like button to like a video and remove your like.
- Profile screen: Opens a screen with my feed area. Profile picture and username are shown. Clicking on any video from my feed open post details screen, which plays the video.

### API endpoints (Mock)
- /feed
- /post/{post_id}
- /profile/{username}
- base url: https://example.com/api
