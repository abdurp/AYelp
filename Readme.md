Assignment 2: Yelp
Developer: Abdur Rehman

Date: September 23, 2014

Description:

The goal of this assignment is to create a Yelp App which reads actual data from Yelp, and displays the results. The search results can also be filtered based on pre-defined criteria

Number of Hours Taken: 18

All Required Stores Completed:
    - Search results page
        - Table rows should be dynamic height according to the content height
        - Custom cells should have the proper Auto Layout constraints
        - Search bar should be in the navigation bar (I added the search bar between the navigation bar and the table view)

        - Extra: Clearing the search bar resets the results

    - Filter page (modally presented)

        - The filters are: category, sort (best match, distance, highest rated), radius (meters), deals (on/off).
        - The filters table are organized into sections as in the mock.
        - Default UISwitch for on/off states. 
        - Radius filter expands as in the real Yelp app
        - Categories show a subset of the full list with a "See All" row to expand. 
        - Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.

Known Issues:
    - On setting a filter switch on a row other than 0, row 0 is always displayed (even though the switch is correctly selected)
        - I tried using reloadRowsAtIndexPaths but it kept crashing with all possible values

Installation:
    - Run "pod install" on the command line
    - Build on Xcode 6 GM and deploy on iPhone 5 / 5S / 6 / 6Plus

Open Source Libraries:
    - AFNetworking
    - BDBOAuth1Manager

GIF Walkthrough (created using LiceCap):
![YelpGIF-AbdurR.gif](https://github.com/abdurp/AYelp/blob/master/YelpGIF-AbdurR.gif)
