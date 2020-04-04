# reddit-app
reddit-app is a basic reddit client  (https://www.reddit.com) wherein you can see list of subreddits, search for it, and browse through its posts. It’s written in Swift 5 in MVVM architecture.

I chose this assumption for this exam:\n
**B. Design and Implement an app as a long term project**\n
*You are a tech-lead of an iOS team with 5 members. The team is going to develop a new iOS
app. It is supposed to be a long term project to develop and maintain the app within the team.
Before starting the development with the team members, you are going to design the app and
implement fundamental functionalities as the tech lead.*

Based on it, I coded it in a way that all of the team members can easily understand, do bug fixes, and insert additional features. An app with better architecture, is a flexible/scalable app which is good for a long term basis project. 

## Authorization
I used Application Only OAuth for authorization. It’s a user-less way of authorization provided by Reddit so I make API requests without a user context.
Source: (https://github.com/reddit-archive/reddit/wiki/oauth2)

## Libraries/API 
* Alamofire 5
* Reddit API 
