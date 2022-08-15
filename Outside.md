# Work from the Outside In; Not from the Inside Out

It is always tempting to start with the beginning. It is much better to start with the ending.

When approaching a new problem, it is easy to make the first question, ‘How am I going to solve this problem?’, but the actual 
first question should be ‘Once I have solved this problem, how do I want to use it?’

For example if one were creating a persistence layer for their app, it might be tempting to start with the technical problem.  
Perhaps the first question that comes to mind is ‘How am I going to store this data?’  And once one figures out how to store 
it, they might next ask in what form will it be saved? And then, how will the API access and perhaps cache the data? And then 
how will the API structure the data internally? And then finally the question of how the ‘end user’, i.e., the programmer 
using the API, will interact with the API comes to mind.

But when an API comes about in this manner, that last step, the programmers interface, suffers. It suffers because rather than being designed for the developer that will use it, it was designed for the tool that it encapsulates.

Instead, the first question should not have been ‘how do I solve this problem’; but rather, ‘if this problem were solved, how 
would I want to interact with it?’

Once one figures out what an ideal interface looks like they, then and only then, can start to figure out how to implement 
that interface. In this way, whether creating a class, an API or an app itself, the end product is much improved.

One visceral example of this is the TV remote. The average TV remote is designed from the inside out and as a result it is a 
cacophony of buttons, most of which only the engineers who made the TV have any idea what they do. On the other hand an Apple 
TV remote was designed for the end user and the contrast between the two remotes is quite striking.
