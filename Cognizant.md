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

Harping back to my point about concise code; while there are often times when these factors come into conflict with one 
another, with few exceptions writing concise code almost always enhances all of the above considerations.

On a basic level concise code increases readability since there is less code to understand. But, since it pushes one to avoid 
copy and paste and increase code reuse where possible, that increases code reusability which increases code readability.

Typing less code can boost speed to develop; however writing reusable code usually takes quite a bit longer than the 
alternative initially. But, this initial investment can pay huge development speed dividends eventually.

Concise code often times will be efficient code. There are of course counterexamples where particularly tight loops require 
clever solutions that increase the code and decrease its readability, but these are situations are fairly rare and fairly 
confined in a code base.

And of course all of this then allows for more iterations to be tried, more malleable, less buggy code; which all points to 
better form and function of the app itself. Concise code is very close to being a programming magic bullet.

Certainly, performant code is desirable. However, occasionally performant code may take longer to develop or may reduce the 
readability of the code. And in many cases, the difference in performance will not be noticeable to the user. So, it may be 
best to deprioritize performance until it becomes a problem. Don’t solve performance problems you don’t have, i.e, avoid 
premature optimization. This leads us to another guideline:
