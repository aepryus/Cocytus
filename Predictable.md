[[3. Avoid Spooky Action at a Distance]](Spooky.md)

# 4. Aspire to Memorize the Code Base

Another certainly unachievable, but desired ideal is to have any code base you are working in entirely in your head.  If one has 
all the code in their head, if they know where any given function is located and what it does, extending and maintaining the 
project becomes substantially easier.

Of course memorizing 1000s of lines of code is impossible. But, there are a number of things one can do to make the task 
easier. For example, if one were to memorize the following 6 ten digit numbers:

- 8729216833
- 1976070400
- 1111111111
- 1234567890
- 3141592653
- 1010010001

It would quickly become apparent that some of these numbers are easier to remember than others and for various reasons; some 
relate to things a person may already know, some are algorithmic with varying degrees of complexity.

One of the goals of coding should be to write the code in a way that maximizes ones chance of keeping it in their head. As 
code becomes more algorithmic, more predictable, it becomes increasingly easy to keep it in one’s head.

One area where this can be important is naming. For example, perhaps one has a view with an image on it; here are some 
potential names:

```Swift
let empPortraitView: UIImageView
let pictureOfEmployeeImageView: UIImageView
let employeesPicImageView: UIImageView
let employee: UIImageView
let imageView: UIImageView
```

There a number of factors to consider when naming this object and one of them is memorableness. One thing that instantly 
reduces the ability to remember something is to abbreviate it. There are any number of ways to abbreviate a word and once an 
abbreviation is chosen one has created something that needs to be remembered.

Another temptation is to over describe a variable. Long variable names may make it easier to “self document” a variable, but 
they can reduce their ability to be remembered and can also reduce the readability of code. With any trivial calculation using 
overly long variable names can greatly reduce the readability of an equation. It can also make calling methods with parameters 
overly verbose, hiding what is actually happening.

Even if one choses a relatively concise non abbreviated name that contains an adjective, they are adding something that needs 
to be remembered. The most memorable way to handle this particular situation is simply call something what it is: imageView. 
There is no need for adjectives in the name until there are two of something. If a view has one UILabel, call it label. If it 
has one UIImageView, call it imageView.

There are a number of other ways one can increase the memorability of their code:

- Alphabetize imports and other areas of the code base that contain long lists of something.  
- Keep the order of code in a file consistent. Group methods for extensions and interfaces; their order in one file should match their order in all files.
- Keep the order of properties the same wherever they are located. I.e., the order properties are defined, should be the same order they are translated to and from JSON and the same order getters and setters are defined, etc.
- Match the order of UI elements in the code to the order of the UI element on the screen.
- Properties themselves should be organized in a logical order; primary key at top, foreign keys next; data next and utility 
properties last, for example. Similar properties should be grouped together; new properties should go where they belong not 
just be tacked to the bottom or randomly placed.
-  Static methods should be placed where they logically belong; where one would most expect them to be.
-  In some cases, a concise distinct name is preferable to a long winded name. For example, if you have an object that contains a 
list of all drugs available, you could call it the FullDrugListRepository, or you could call it Apothecary. One of those is 
substantially more memorable than the other.

[[5. Simplify Over Commenting]](Commenting.md)
