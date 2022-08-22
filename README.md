Overview: This is a sentiment analysis mood journaling app designed in swiftUI to try to make daily journaling an easy and rewarding experience for the average person. The three major pages can be found and navigated through the top left expanding navigation tab. On the main and first page, you will find the journal entry page, where users and self report a mood value for the day and write down what's on their minds. Note how the question is randomized as well as changes depending on the self-reported mood value to keep journalling fun and engaging for the users. Once the user saves an entry, the entry appears on the past entires page, which includes a dynamic table view containing all past entries, with each entry having a background custom gradient color dependent on the self-reported mood value as well as an emoji dependent on the sentiment analysis value for that day's journal. You can full swipe to delete, collapse, or swipe to edit each entry. Suppose you click on each entry on this page. In that case, it brings you to a separate page displaying information for that day, including all your entry information as well as sentiment analysis values for the journal you wrote. These analysis values are conveniently displayed in various ways, including a custom color that represents your daily mood. On the third and final page, we communicate the trends of the user's mood over time with a specialized weekly and monthly view as well as a custom date range view to graphically present the user's change in mood over time. Each graph is completely dynamic, and the user can hover over each value to see more information.



Suryansh:
Created and handled trends view page entirely
Helped in code refactoring and bug fixes
Tested the code thoroughly to ensure proper functioning




Rishi Ravula:

Views Created / Edited : Main Journal Entry Page, Edit Page
Created all Data model and structure, implemented all persistant storage, saving, loading, etc
Implemented the main API call to push jounral entries to a server and pull them back uploading the value
Implemented SwiftyJSON to make everything encodable, and easily decipherable
Custom created every UI Design / themes using Krita
Created overall data structure that stores all entries along with every property necessary for each view to call and respond with
Created unique identifiers for each data model instantiation
Refactored all the slider bar elements to implement gradients and color hues along with them
Added all notification elements, notifications should remind you at noon to ensure you fill out your jounral entry
Added App icon Support (also designed with krita)
Fixed entry storage and states of when elements are loaded and saved
Created the custom weighting analysis to weight the API call result and slider value to display overall mood color
Mood color gradient implemented on EntryViews
Helped with bug fixes and testing





Stuart:
Views Created - Past entries page, Past entries edit page, Entry information display page
Created navigation between all pages, Custom created a hidden sidebar with animation and navigation functions.
Created the display of all past entries including swipe actions for delete and editing. Multiple views for entry display and editing. Made modelData functional throughout all pages through enviromental object. Wrote function for date manipulations, unique ID for each entry. 
Made major UI updates to Journal Entry page, including the text input field with dynamic sizing and save fucntionality. Made Question bank on front page dynamic depending on inputed mood value. 
Created Dynamic Table view for past entries with custom color gradients that reflected entry mood values. 
Helped with Bug fixes and testing. 
