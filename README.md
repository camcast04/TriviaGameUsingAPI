# Project 4 - *Trivia Game APP Using Triva API*

Submitted by: **Camila Castaneda**

**Name of your app** is an app that ... utilizes the Open Trivia Database API to create a trivia game

Time spent: **4** hours spent in total

## Required Features

The following **required** functionality is completed:

- [x] User can view and answer at least 5 trivia questions.
- [x] App retrieves question data from the Open Trivia Database API.
- [x] Fetch a different set of questions if the user indicates they would like to reset the game.
- [x] Users can see score after submitting all questions.
- [x] True or False questions only have two options.


The following **optional** features are implemented:

  
- [x] Allow the user to choose a specific category of questions.
- [ ] Provide the user feedback on whether each question was correct before navigating to the next.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

## Video Walkthrough

<img src='https://i.imgur.com/Emseu12.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Notes

I had a problem with attempting to update the UI from a background thread. I found out on overstack that its common and that In iOS, all UI updates must occur on the main thread.
The solution i found online was to use:
DispatchQueue.main.async

and it worked for me. 

## License

    Copyright [2023] [Camila Castaneda]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
