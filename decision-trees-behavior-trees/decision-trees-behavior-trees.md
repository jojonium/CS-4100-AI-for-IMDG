% Decision Trees and Behavior Trees Readings
% Joseph Petitti
% November 18, 2019

Differences between decision trees and behavior trees:

  - Decision trees are relatively simple compared to behavior trees, just being
    a set of decisions an agent makes based on things it knows.
  - Behavior trees can lead to more complex behavior because they can represent
    multiple behaviors running at once.
  - Decision trees are always traversed top to bottom, sibling behavior trees
    are traversed left to right.

Questions about behavior trees;

  - How can behavior trees be combined with other AI techniques like finite
    state machines?
  - In what situations would you want to use a behavior tree over the simpler
    decision trees?

Questions about decision trees;

  - Would it be more realistic or interesting to keep track of what each
    character knows for their own decision trees, rather than use a global game
    state?
  - How would you insulate the global game state to prevent hard-to-find bugs?
