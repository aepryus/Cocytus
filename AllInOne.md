# Cocytus

_a few things to consider while coding_

<p>
  <img src="07bic0ao8d571.jpg" width=500>
</p>

## Contents

1. [The Easiest Code to Read is the Code that is not There](#1-the-easiest-code-to-read-is-the-code-that-is-not-there)
2. [Work from the Outside In; Not from the Inside Out](#2-work-from-the-outside-in-not-from-the-inside-out)
3. [Avoid Spooky Action at a Distance](#3-avoid-spooky-action-at-a-distance)
4. [Aspire to Memorize the Code Base](#4-aspire-to-memorize-the-code-base)
5. [Simplify Over Commenting](#5-simplify-over-commenting)
6. [Don’t Solve Problems You Don’t Have](#6-dont-solve-problems-you-dont-have)
7. [Don’t Blindly Follow Rules](#7-dont-blindly-follow-rules)

---

## 1. The Easiest Code to Read is the Code that is not There

If two programs are exactly the same; they look the same; they behave the same; they take the same input and provide the same output, but one was written with 1000 lines of code and the other with 10,000 lines of code. The code of the 1000 line program is going to be easier to read, easier to maintain and easier to extend.

If there were no other advantages, simply eliminating lines of code, in and of itself, would be advantageous, because it reduces the amount of complexity and the shear mass of instructions that a developer must deal with in order to work with a program.

But, once one becomes zealous in their quest to eliminate lines from the code base; once each line added becomes pain and each line trimmed becomes joy, the developer will start to notice other advantages.

Suddenly, there is a natural incentive to write for code reuse; copy and paste becomes quite unpalatable. Code starts to naturally get pushed into objects that encapsulate elegant constructs of data and function. Generally, smaller amounts of code translates into more performant code. Code written for reuse, gets run more times, from more directions; it therefore becomes harder for bugs to hide. And of course there is less code to search through when looking for those bugs. And when a bug does get fixed, it gets fixed everywhere it is called (which doesn’t happen when code is copy and pasted).

The side effects of always trying to write concise code, perhaps become a larger asset than the concise code itself.

### Always be Cognizant About Trade Offs

Software development is a constant balancing act. One is constantly weighing the relative merits of a number of different factors. It is helpful to be cognizant of this process and to make thoughtful decisions about which to prioritize when they come into conflict with one another. Here is a partial list of these considerations:

- form and function of the app
- readability of the code
- reusability of the code
- speed to develop
- performance of the code
- other app footprints such as memory, storage, bandwidth and battery usage

The above list is loosely ordered by relative importance, however, everything really needs to be decided on a case by case basis. There really, is never case where any one of these items can’t trump another.

For example, the form and function of the app is obviously of utmost importance. But, perhaps one has a very cool animation in mind that would slightly improve the form of the app, but will take two weeks to implement. In that case, perhaps ‘speed to develop’ may override ‘form and function’.

### Concision is Almost Never a Trade Off

Concise code with few exceptions tends to enhance all of the above listed considerations.

- Concise code increases readability since there is less code to understand.
- It pushes one to avoid copy and paste and increase code reuse where possible.
- Typing less code can boost speed to develop. Although, writing reusable code does usually take longer to develop initially, long term it can greatly speed the rate of development.
- Concise code is usually efficient code. There are, of course, counterexamples where particularly tight loops require clever solutions that increase the amount of code and decrease its readability, but these situations are fairly rare and can be confined in a code base.
- Such a code base will be faster to iterate on, more maleable and less buggy; the end result of all that is improved form and improved function.

Concise code is very close to being a programming magic bullet.

---

## 2. Work from the Outside In; Not from the Inside Out

It is always tempting to start with the beginning. It is much better to start with the ending.

When approaching a new problem, it is easy to make the first question, ‘How am I going to solve this problem?’, but the actual first question should be ‘Once I have solved this problem, how do I want to use it?’

For example if one were creating a persistence layer for their app, it might be tempting to start with the technical problem. Perhaps the first question that comes to mind is ‘How am I going to store this data?’ And once one figures out how to store it, they might next ask in what form will it be saved? And then, how will the API access and perhaps cache the data? And then, how will the API structure the data internally? And then finally the question of how the ‘end user’, i.e., the programmer using the API, will interact with the API comes to mind.

But when an API comes about in this manner, that last step, the programmer's interface, suffers. It suffers because rather than being designed for the developer that will use it, it was designed for the tool that it encapsulates.

The first question should not have been ‘how do I solve this problem’; but rather, ‘if this problem were solved, how would I want to interact with it?’

Once one figures out what an ideal interface looks like they then can start to figure out how to implement that interface. In this way, whether creating a class, an API or an app itself, the end product is much improved.

One visceral example of this is the TV remote. The average TV remote is designed from the inside out and as a result it is a cacophony of buttons, most of which only the engineers who made the TV have any idea what they do. On the other hand an Apple TV remote was designed for the end user and the contrast between the two remotes is quite striking.

---

## 3. Avoid Spooky Action at a Distance

The (perhaps never entirely achievable) ideal is that at any location in the code all relevant code is at hand. If I want to understand an aspect of a program I'd love to be able to see all of the related and none of the unrelated code on the screen at once. Arguably, this is the primary goal of object oriented programing itself.

However, there are both ancient commandments and more mundane common practices that fly directly counter to this ideal, including some features of Swift itself:

### Magic Numbers

The 70s era piety to "never use magic numbers!" was born out people struggling to understand someone else's assembly code. And certainly, there ARE cases where using magic numbers greatly reduce the readibility of code. However, once people start using the words 'always' and 'never', problems arise.

For example, if I want a control B to be located 10 pixels to the right of control A, I could create a ```pixelsBetweenControls``` constant. But, once I do this I create all sorts of issues:

- If I want to know how many pixels are between the controls I now can't see it at the relevant area of the code. I need to navigate some where else.
- If I want to adjust the value I need to do so where the constant is defined instead of at the code where it is used.
- If I do adjust the value I now have to worry about if and how many other places use the value and if I actually want to change those other usages.
- It can be very difficult to give such a variable a clear name and certainly not as clear as simply seeing how it's being used in the code directly.

### Typedefs

Along the same lines, but even more troublesome are typedefs especially in regard to closures that hide the types of input parameters and return types. Use of a typedef guarantees that subsequent developers will repeatedly need to navigate to the definition just to see basic type information.

Similarly, implied types are even more unfriendly, because not only can you not just glance up and know what the variable represents, but you also can't right click on it and navigate to the type definition.

### Vertical Spacing

Being stingy with vertical spacing allows for more code to be shown on the screen at the same time. Obviously, using vertical spaces to help group related code can greatly increase readibility. But, unnecessary and arbitrary extra vertical spaces, as well as unhelpful comments just reduces the amount of code that can be put up on the screen at the same time.

Simularly, always putting input parameters of method calls on their own line can greatly reduce the amount of code that can be seen at one time and in most cases (but certainly not all) doesn't enhance the readibility of the code.

---

## 4. Aspire to Memorize the Code Base

Another certainly unachievable, but desired ideal is to have any code base you are working in entirely in your head. If one has all the code in their head, if they know where any given function is located and what it does, extending and maintaining the project becomes substantially easier.

Of course memorizing 1000s of lines of code is impossible. But, there are a number of things one can do to make the task easier. For example, if one were to memorize the following 6 ten digit numbers:

- 8729216833
- 1976070400
- 1111111111
- 1234567890
- 3141592653
- 1010010001

It would quickly become apparent that some of these numbers are easier to remember than others and for various reasons; some relate to things a person may already know, some are algorithmic with varying degrees of complexity.

One of the goals of coding should be to write the code in a way that maximizes ones chance of keeping it in their head. As code becomes more algorithmic, more predictable, it becomes increasingly easy to keep it in one’s head.

One area where this can be important is naming. For example, perhaps one has a view with an image on it; here are some potential names:

```Swift
let empPortraitView: UIImageView
let pictureOfEmployeeImageView: UIImageView
let employeesPicImageView: UIImageView
let employee: UIImageView
let imageView: UIImageView
```

There a number of factors to consider when naming this object and one of them is memorableness. One thing that instantly reduces the ability to remember something is to abbreviate it. There are any number of ways to abbreviate a word and once an abbreviation is chosen one has created something that needs to be remembered.

Another temptation is to over describe a variable. Long variable names may make it easier to “self document” a variable, but they can reduce their ability to be remembered and can also reduce the readability of code. With any trivial calculation using overly long variable names can greatly reduce the readability of an equation. It can also make calling methods with parameters overly verbose, hiding what is actually happening.

Even if one choses a relatively concise non abbreviated name that contains an adjective, they are adding something that needs to be remembered. The most memorable way to handle this particular situation is simply call something what it is: imageView. There is no need for adjectives in the name until there are two of something. If a view has one UILabel, call it label. If it has one UIImageView, call it imageView.

There are a number of other ways one can increase the memorability of their code:

- Alphabetize imports and other areas of the code base that contain long lists of something.
- Keep the order of code in a file consistent. Group methods for extensions and interfaces; their order in one file should match their order in all files.
- Keep the order of properties the same wherever they are located. I.e., the order properties are defined, should be the same order they are translated to and from JSON and the same order getters and setters are defined, etc.
- Match the order of UI elements in the code to the order of the UI element on the screen.
- Properties themselves should be organized in a logical order; primary key at top, foreign keys next; data next and utility properties last, for example. Similar properties should be grouped together; new properties should go where they belong not just be tacked to the bottom or randomly placed.
- Static methods should be placed where they logically belong; where one would most expect them to be.
- In some cases, a concise distinct name is preferable to a long winded name. For example, if you have an object that contains a list of all drugs available, you could call it the FullDrugListRepository, or you could call it Apothecary. One of those is substantially more memorable than the other.

---

## 5. Simplify Over Commenting

Another decree from back in the day is to _"always comment your code"_. And perhaps when writing Assembly code this _is_ really important. But, since we are probably not, perhaps its time for a little blasphemy.

One of a programmer’s jobs is to understand the language they are using. If they understand the language and see the code in front of them why is there a need to add comments? Comments add noise to a code file, comments can get stale, comments reduce the amount of code visible at one time. But, most importantly, comments excuse poor, overly complicated or convoluted code. If your code requires comments to explain, perhaps its time to re-write it instead.

Much better than highly commented code is concise, elegant code with elegant structure and well named classes, methods and variables. A class’s name should make it apparent what it is; a method name should make it apparent what it does. The implementation of methods should be clear and concise.

Certainly, there will be times when comments are actually needed, but that should be the exception not the rule.

---

## 6. Don’t Solve Problems You Don’t Have

As a programmer it is good to be thinking about performance when coding and to not waste resources unnecessarily. However, there will always be many ways to solve a problem and while one of those ways is the most performant, perhaps many if not all of them are performant enough.

In general, the starting point should always be simple and clean code; don’t worry about performance until a performance problem arises; i.e., avoid premature optimization.

But, this concept can be applied more generally, not just to performance and other computer resources such as memory, storage, battery usage, networking bandwidth etc. It can also apply to functionality both of the code and more broadly to the program’s user interface itself.

Don’t try to predict the future. Design your program to meet the current requirements, not requirements that may or may not exist in the future.

---

## 7. Don’t Blindly Follow Rules

Rules and religion can be useful tools for software developers. But experienced and competent developers should not be afraid to leave them behind and consider whether they make sense on a case by case basis.

‘Don’t ever use goto!’ If there was never a case to use goto in C, than why did they add it to the language? No programming rule is right in 100% of cases and certainly none of the guidelines presented in THIS guide are right 100% of the time.

Don't turn off your brain and cede decisions to some old book. Never stop thinking; never stop trying to come up with a better way.
