### Summary: Include screen shots or a video of your app highlighting its features
This app displays the recipe name and cuisine on each row. Each row is tappable to bring you to the source url if it exists. There is toggle in the toolbar that allows you to show videos for each row in a drop down. The videos are embedded in a web view so they open in the iOS video player.

![summary](./summary.mp4?raw=true "Summary")

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I focused the most on making sure my code was clean and readable. I value this a lot because it makes it easier to collaborate and your future self will thank you for it.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
This took me about one workday. I completed the required UI first, next worked on cleaning up the code to break down views and view models into their own files. Once everything was in a good spot I completed the tests, updating the views as necessary. At the end I added a few small enhancements and added a bit of polish and paint to the UI. I spent majority of my time on the tests and caching.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
I wanted to add more to the UI and possibly do some grouping or sorting of the recipes but I opted to spend more time on the requirements and tests.

### Weakest Part of the Project: What do you think is the weakest part of your project?
The YouTube video drop down has some intermittent issues that I would dig into with more time. I would also break out the logic there into a view model and test it with more time.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
I learned a lot about Swift Testing. I have looked into it previously but this was my first time using it fully in a project, seems like a great tool so far. I wanted to parameterize the tests in the RecipeViewModel which I need to look into further. I went deeper on embedding Youtube videos in apps which was interesting. Overall this was a fun challenge, thanks for the opportunity.
