# 1. The Easiest Code to Read is the Code that is not There

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

## Always be Cognizant About Trade Offs

Software development is a constant balancing act. One is constantly weighing the relative merits of a number of different 
factors. It is helpful to be cognizant of this process and to make thoughtful decisions about which to prioritize when they 
come into conflict with one another. Here is a partial list of these considerations:

- form and function of the app
- readability of the code
- reusability of the code
- speed to develop
- performance of the code
- other app footprints such as memory, storage, bandwidth and battery usage

The above list is loosely ordered by relative importance, however, everything really needs to be decided on a case by case 
basis. There really, is never case where any one of these items can’t trump another.

For example, the form and function of the app is obviously of utmost importance. But, perhaps one has a very cool animation in 
mind that would slightly improve the form of the app, but will take two weeks to implement. In that case, perhaps ‘speed to 
develop’ may override ‘form and function’.

##  Concision is Almost Never a Trade Off
Concise code with few exceptions tends to enhance all of the above listed considerations.

- Concise code increases readability since there is less code to understand.
- It pushes one to avoid copy and paste and increase code reuse where possible.
- Typing less code can boost speed to develop.  Although, writing reusable code does usually take longer to develop initially, long term it can greatly speed the rate of development.
- Concise code is usually efficient code. There are, of course, counterexamples where particularly tight loops require clever solutions that increase the amount of code and decrease its readability, but these situations are fairly rare and can be confined in a code base.
- Such a code base will be faster to iterate on, more maleable and less buggy; the end result of all that is improved form and improved function.

Concise code is very close to being a programming magic bullet.


[[2. Work from the Outside In; Not from the Inside Out]](Outside.md)
