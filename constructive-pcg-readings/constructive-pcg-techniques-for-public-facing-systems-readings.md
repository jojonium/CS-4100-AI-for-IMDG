% Constructive PCG Techniques for Public-Facing Systems Readings
% Joseph Petitti
% October 31, 2019

## Algorithms and Approaches: Chapter 26, Procedural Generation in Game Design

Questions:

  - When experimenting with using a particular method for randomly generating
    some desired characteristic, e.g. making caves with a cellular automaton, is
	there some better way for guiding these experiments than guessing and seeing
    what looks good?

  - What is the relative performance of these algorithms? What are some of the
    drawbacks of using one over another?

  - How can these techniques be applied to AI? For example, how can we randomly
    generate realistic/interesting NPC actions?

Takeaways:

  - There are a few general techniques and algorithms that are commonly used for
    generating random content.

  - Each of these techniques are just tools with upsides and downsides for
    different situations. Consider which ones might be useful in different
    situations.

Quote:

``Procedural generation opens endless doors in endless hallways to endless
untracked worlds.''

## So you want to build a generator…

Questions:

  - What's a good way to narrow down your artifacts to make describing
    constraints easier?

  - What are some techniques for filtering out ugly, boring, or otherwise
    undesireable generated content?

  - What are some of the downsides of agent-based generation?

Takeaways:

  - Define your what you want your generator to do as strictly as possible.

  - Test your generators a lot to make sure they succeed at making interesting
    content that fits your constraints

Quote:

``The most common way that generators fail is that they produce content that
fails to be interesting.''


## Ethical bot-making

Questions:

  - What happens when ``do no harm'' is ambiguous? What if a self-driving car
    has to choose between running over a group of pedestrians or swerving into a
    wall and possibly killing its owner?

  - The article says that creators are not completely absolved of responsibility
    when users misuse their bots, but where do we draw the line? If the creator
    tries their best to make an inoffensive chatbot but it is still abused into
    becoming racist (e.g. Microsoft's Tay), is it still the creator's
    responsibility?

  - What defines a good-faith attempt to prevent a bot from acting unethically?

Takeaways:

  - Keep in mind the possible negative actions your bot could do, because you
    are still responsible for them.

  - Monitor your bots and make it easy for users to report errors or problematic
    content.

Quote:

``What matters is not that you mess up, but how you respond when you do.''

## Microsoft's Tay is an Example of Bad Design

Questions:

  - What could Microsoft have done to prevent this outcome?

  - How can you find a meaningful but inoffensive corpus of data to train bots
    like Tay?

  - How can you teach a bot to understand the context of words like
    ``holocaust?''

Takeaways:

  - AI designers are responsible for their creations.

  - Failing to consider the interactions a bot can have with users is bad
    design.

Quote:

``With the future of chat and AI, designers and engineers have to start thinking
about codes of conduct and how accidentally abusive an AI can be, and start
designing conversations with that in mind.''

## Summary

Each of these articles are about how to design good procedurally generated
content. Designers have to make a conscious effort to generate content that is
not only interesting and meets the goals of the project, but that is also
non-problematic and inoffensive. We are all responsible for the things we
create, and with artificial intelligence these things can have far-reaching
consequences that we never considered when initially designing them. That's why
AI designers need to put in the effort to ensure their procedurally generated
content is safe.

These challenges have come up in CS 4100 as well as other classes I've taken at
WPI. For the Twitter chat bot I made I had to consider whether it could generate
tweets that were offensive or inflammatory. In other CS and IMGD classes I have
had to consider how users would interact with the programs I created, and
whether these interactions would be problematic.
