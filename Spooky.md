##Avoid Spooky Action at a Distance

The perhaps never entirely achievable ideal is that at any location of a program all relevant and no irrelevant code is close 
by.  Perhaps one of the strengths of object oriented programming in general is that it comes much closer to this ideal.

Unfortunately, there are a handful of tools and ancient commandments that go directly counter to this ideal and greatly aid in 
making code harder to maintain.  For example in Swift, both implied types and the typedef command are among the most powerful 
tools in reducing the readability of code.  I highly advocate against using either in almost all cases.

The 70s error commandment to never put ‘magic numbers’ in the code base is also huge boon to reducing code readability, 
maintainability and in injecting crazy side effect bugs.

Once I’ve added a constant to represent a value, for example the pixel distance between two controls, I’ve created all sorts 
of problems.  I can’t just go to the code to see what the distance is because instead of seeing a “10”, I see 
“distanceBetweenControls” variable.  I now need to find that variable to see where it’s set.  If I want to change the value to 
“12”, I then need to see if anyone else is making use of the variable and if they are I need to make sure that they all want 
to be moved to 12.  And if they don’t, now I need to make another variable?

Aside from all that what are the chances that the name of the control actually tells me what it represents?  It would be 
infinitely better to just be able to see how it is used.

Of course, with all that being said there *are* cases where it makes sense to have a constant.  But, those are the exception 
and not the rule; we are not programming in assembly language any more.
