Falling Words
===============

In order to win the game, you need to arrive to the indicated number of 💚.
In order to do not lost, you need to avoid 3 failures 💀.

## Design considerations
High-level design and architecture decisions and guidelines

Use of [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) architectural pattern.

### Time Invested
Approximately 4 hours.

#### Time distribution
Concept: 10%
General Spike on how to aproach UI/ animations: 10%
Model / read Json: 10%
View Model / business logic: 30%
Manual Test: 10%
Unit Test: 20%
Refactor:  10%

#### Decisions made to solve certain aspects of the game


#### Decisions made because of restricted time
1- Simplify UI as much as possible, use of simple tools such as emojis.
2- Keep all the view logic in the same view controller to save time.

#### What would be the first thing to improve or add if there had been more time
1- Coming back to the previous point 2, Try to modularize more the views/UI components
2- Make more reactive, and respond to events from the view model rather than update booleans in the view controller.
3- Apply TDD.
4- Localise the app
5- Use the API rather than the JSON local file
6- Extract the score and speed as params for chose the difficulty of the game (connect with UI)

