# Any Weather by Loi Tran

First of all, I'd like to say thanks for this oppoturnity. This small take home project is an nice challenge to me to learn more about SwiftUI along with MVVM model. As an iOS developer for 8 years, this is an interesting asignment that I ever given to.

I'm not familiar with SwiftUI and MVVM prior this project, but I managed to use them instead of traditional MVC. There were issues and problems while working on this small app but resolving them teach me new things. Writing just some unit tests also bring up something about asynchronous problems and testable coding.

# Project Organizing
Follow the requirements, this project is built using Swift language, and the codebase is organized in MVVM pattern:
	- Model: contain structs/classes declaration for handling data.
	- View: all views for displaying screen, table cell, reusable components
	- ViewModel: handling logic flow, data binding between modal and display view
	- Service: contains caching and networking service
	- Constant, Utils: utilities for formatting data & managing string constants.

3rd party frameworks:
	- Alamofire: API network
	- Kingfisher: download and cache images
	- DYPopoverView and AlertToast: UI components that make life easier

# Caching Responses
Any Weather is capable to caching response JSON for a custom duration of 1 hour, using iOS built-in NSCache, with a small wrapper to allow NSCache work with structs. The strategy is to cache any successful request from OpenWeatherMap, base on the city's name. If user searchs the same city within 1 hour from the last cache, Any Weather will load data from cache instead of sending an API request. This works even the device is disconnected from internet.
Pros: simple and fast, decrease unneeded network calls, thread-safe if accessing concurrently.
Cons: NSCache will be cleared when exiting app.

# Debouncing search
User's input will only trigger API search after they stop typing for 1.5 second.

# Accessibility supports
User can change the text size via the top left button.
User can use VoiceOver to speak out loud the weather forecast information.

# Steps to run locally
Open terminal and run below commands:
git clone https://github.com/baloi91/anyweather.git
cd anyweather
pod install

Then open anyweather.xcworkspace, there a 2 targets: anyweather app and anyweatherTests.

# Item checklist
✓ 1. Programming language: Swift is required, Objective-C is optional.
✓ 2. Design app's architecture (recommend VIPER or MVP, MVVM but not mandatory)
✓ 3. UI should be looks like in attachment.
✓ 4. Write UnitTests
X 5. Acceptance Tests
✓ 6. Exception handling
✓ 7. Caching handling
✓ 8. Accessibility for Disability Supports:
	✓ a. VoiceOver: Use a screen reader.
	✓ b. Scaling Text: Display size and font size: To change the size of items on your screen, adjust the display size or font size.
X 9. Entity relationship diagram for the database and solution diagrams for the components, infrastructure design if any
✓ 10. Readme file
