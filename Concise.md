# The Easiest Code to Read is the Code that is not There

If two programs are exactly the same; they look the same; they behave the same; they take the same input and provide the same 
output, but one was written with 1000 lines of code and the other with 10,000 lines of code. The code of the 1000 line program 
is going to be easier to read, easier to maintain and easier to extend.

If there were no other advantages, simply eliminating lines of code, in and of itself, would be advantageous, because it 
reduces the amount of complexity and the shear mass of instructions that a developer must deal with in order to work with a 
program.

But, once one becomes zealous in their quest to eliminate lines from the code base; once each line added becomes pain and each 
line trimmed becomes joy, the developer will start to notice other advantages.

Suddenly, there is a natural incentive to write for code reuse; copy and paste becomes quite unpalatable. Code starts to 
naturally get pushed into objects that encapsulate elegant constructs of data and function. Generally, smaller amounts of code 
translates into more performant code. Code written for reuse, gets run more times, from more directions; it therefore becomes 
harder for bugs to hide. And of course there is less code to search through when looking for those bugs. And when a bug does 
get fixed, it gets fixed everywhere it is called (which doesn’t happen when code is copy and pasted).

The side effects of always trying to write concise code, perhaps become a larger asset than the concise code itself.
