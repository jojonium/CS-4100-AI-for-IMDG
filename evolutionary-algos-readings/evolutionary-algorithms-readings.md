% Evolutionary Algorithms and Parameterized Design Readings
% Joseph Petitti
% November 4, 2019

## Search-Based Procedural Content Generation

This paper describes the state of the art of search-based procedural content
generation (PCG). This field is relatively new, and new techniques are still
being explored for it. PCG opens up a lot of possibilities for new types of
games with mechanics built around it. One of the major problems is that it's
hard to ensure that all generated content is high-quality and interesting. It is
also prohibitively time-consuming for some applications. Still, the potential
for streamlining the game development process and inventing new procedural-based
game genres is exciting.

## Automated Game Tuning

Adjusting the parameters of a that go into making a game is a difficult and
messy process. There is usually an unfathomably huge number of possible
combinations of parameters, and each can lead to a very different game. This
reading provides guidelines for tuning these parameters. Figure out what your
parameters are, choose a set of values for them, and generate a level. Then
model a simple AI to play the levels, and give it some imperfections to simulate
human skill level. Have thousands of AIs play different versions of your levels
with different parameters to generate some data. You can then analyze the data
to see what combinations of parameters are easy at the start, impossible to
beat, hard at the end, etc. Finally, use this data to craft a set of parameters
that are fun to play for humans.

## Summary of ProcJam Videos

The first ProcJam video I watched was from ProcJam 2018, about using Tarot cards
for generating stories. The program picks random Tarot cards and generates a
basic story based on the meanings of those cards. There are a couple of basic
frameworks, for generating tragedies and comedies. Although the frameworks were
pretty basic, the stories ended up being quite complex and included some common
themes from fiction.

The second video I watched was called "What can Procedural Generation Add?",
from ProcJam 2017. This video went over some cool examples from past ProcJams.
It featured some simple games like Acre6, a game where you move a dot around a
generated map that shows random events you achieve at each location along the
way, and Ocean Tribes, a simple turn-based strategy game in a procedurally
generated world. It also explained some non-game projects like Frankenstein,
which is a library for generating monsters based on body part sprites.

## Endless Forms

No, because it would probably take thousands of hand-picked evolutions to get
anything that looked even remotely like a giraffe.
