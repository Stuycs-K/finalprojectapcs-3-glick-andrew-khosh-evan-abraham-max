
# Technical Details:

### Period: 3

### Group Members: Andrew Glick, Max Abraham, Evan Khosh

### Group Name: CodeSwing Kings

### Project Title: Pitch Please

### Brief Project Description:

We are recreating the baseball mini-game from Friv.com where the player tries to hit a pitched ball at the right time. The goal is to swing at the right moment in order to hit the ball further, giving the runner more time to round the bases.

Link to Inspo: https://www.friv.com/z/games/baseball/game.html

 ### Expanded Description:

Critical Features (Minimum Viable Product):

These are the features we want working by the 1.5-week MVP deadline:
- Pitcher that throws balls
- Bat that swings on mouse click
- Collision detection to see if the ball is hit
- Each at-bat will result in one of two things: a homerun or an out
- The outcome of each at bat will be determined by the accuracy and timing of the hit
- Batter will be able to strike out and if he gets 4 balls he will get a homerun instead of a walk
- Game resets and keeps score
- Basic UI: score display and game over text
  
Nice to Have Features:
- Different pitch speeds/directions
- Stats for the different Batters/Pitchers (speed, strength, staminda, etc)
- Weather Conditions / Wind Speed
- The ability to have different runners on different bases that will act according to the batter
- Batter will walk when they have four balls(instead of an instant homerun in MVP)
     
# Project Design

![UML](/FinalProjectUML.drawio.png)

Within the game loop in the Game class, the code to run the batting simulation will be looping. When the mouse is clicked, the Player hit method will be called and within that the Ball hit method will be called. If the ball is hit, the run method from Game will be called starting the top-down view of the players running the bases. The tick method from the Ball class will constantly be called to move the ball trhough the air. The run method from the Player class will be called every time a Player needs to run to the next base. The homeRun method from the Game class will be called whenever a player rounds all the bases, increasing the score. If the pitcher throws 4 balls instead of the batter hitting a pitch, the walk method from the Game class will be called, moving the PLayers round the bases automatically.
    
# Intended pacing:

Part 1: Setup & Core Mechanics  
Expected Completion: May 24

Andrew:
- Create basic game loop and UI display (score, game over text)
- Implement input handling for bat swing (mouse click triggers swing)

Max:
- Initiate ball throw animation
- Add collision detection logic between ball and bat
- Add logic for ball movement
  - Use velocity vectors
  - Handle ball reset on out or home run

Evan:
- Create Ball class with basic physics
  - Position and velocity

Part 2: MVP Completion  
Expected Completion: May 29

Andrew:
- Improve collision detection (accuracy based on timing)
- Improve Visuals
  - Allow user to choose color of jerset for their team and opponents


Max:
- Handle ball counts and auto-homerun after 4 balls
- Add strikeout detection after 3 strikes
- Implement basic outcomes
  - Track homerun/out based on timing

Evan:
- Improve UI: show current score and game status

Part 3: Make the game better
Expected Completion: June 3

Andrew:
- Add support for multiple batter stats (Strength, swing speed)
- Animate bat movement (swing follow-through)
- Update 4 balls to cause a walk and not a homerun
- Make it so the opponents play offense to (random amount of points based on a few factors)

Max:
- Implement different pitch types (fastball, curve, etc.)
- Introduce wind/weather conditions impacting ball physics

Evan:
- Add base runners and logic for them to advance
- Make it so there are more options that homerun or out
- Enhance runner decision-making (stealing, tagging, etc.)


