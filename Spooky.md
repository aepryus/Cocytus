# Avoid Spooky Action at a Distance

The (perhaps never entirely achievable) ideal is that at any location in the code all relevant code is at hand.  If I want to understand an aspect of a program I'd love to be able to see all of the related and none of the unrelated code on the screen at once.  Arguably, this is the primary goal of object oriented programing itself.

However, there are both ancient commandments and more mundane common practices that fly directly counter to this ideal, including some features of Swift itself:

## Magic Numbers

The 70s era piety to "never use magic numbers!" was born out people struggling to understand someone else's assembly code.  And certainly, there ARE cases where using magic numbers greatly reduce the readibility of code.  However, once people start using the words 'always' and 'never', problems arise.

For example, if I want a control B to be located 10 pixels to the right of control A, I could create a ```pixelsBetweenControls``` constant.  But, once I do this I create all sorts of issues:

- If I want to know how many pixels are between the controls I now can't see it at the relevant area of the code.  I need to navigate some where else.
- If I want to adjust the value I need to do so where the constant is defined instead of at the code where it is used.
- If I do adjust the value I now have to worry about if and how many other places use the value and if I want those changed also.
- It can be very difficult to give such a variable a clear name and certainly not as clear as simply seeing how it's being in the code directly.

## Typedefs

Along the same lines, but even more troublesome are typedefs especially in regard to closures that hide the types of input parameters and return types.  Use of a typedef guarantees the need for subsequent developers to repeatedly need to navigate to the definition just to see basic type information.

Similarly, implied types are even more unfriendly, because not only can you not just glance up and know what the variable represents, but you also can't right click on it and navigate to the type definition.

## Vertical Spacing

Being stingy with vertical spacing allows for more code to be shown on the screen at the same time.  Obviously, using vertical spaces to help group related code can greatly increase readibility.  But, unnecessary and arbitrary extra vertical spaces, as well as unhelpful comments just reduces the amount of code that can be put up on the screen at the same time.

Simularly, always putting input parameters of method calls on their own line can greatly reduce the amount of code that can be seen and in most cases (but certainly not all) doesn't enhance the readibility of the code.
