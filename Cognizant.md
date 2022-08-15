# Always be Cognizant About Trade Offs

Software development is a constant balancing act. One is constantly weighing the relative merits of a number of different 
factors. It is important to be cognizant of this process and to make thoughtful decisions about which to prioritize when they 
come into conflict with one another. Here is a partial list of these considerations:

- form and function of the app
- readability of the code
- reusability of the code
- speed to develop
- performance of the code
- other app footprints such as memory, storage, bandwidth and battery usage

The above list is loosely order by relative importance, however, everything really needs to be decided on a case by case 
basis. There really, is never case where any one of these items can’t trump another.

For example, the form and function of the app is obviously of utmost importance. But, perhaps one has a very cool animation in 
mind that would slightly improve the form of the app, but will take two weeks to implement. In that case, perhaps ‘speed to 
develop’ may override ‘form and function’.

##  A Quick Aside:
One thing I'd like to point out about concerning the previous ["The Easiest Code to Read is the Code that is not There"](Concise.md) article, with few exceptions concise code tends to enhance all of the above listed considerations.

- Concise code increases readability since there is less code to understand.
- It pushes one to avoid copy and paste and increase code reuse where possible.
- Typing less code can boost speed to develop.  Although, writing reusable code does usually take longer to develop initially, long term it can greatly speed the rate of development.
- Concise code is usually efficient code. There are, of course, counterexamples where particularly tight loops require clever solutions that increase the amount of code and decrease its readability, but these situations are fairly rare and can be confined in a code base.
- Such a code base will be faster to iterate on, more maleable and less buggy; the end result of all that is higher form and higher function.

Concise code is very close to being a programming magic bullet.
