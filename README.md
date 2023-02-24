# Harper-foundations

But what are these phrases? What is a program made of?

* Programming languages *express computations* in a form comprehensible to both
  people and machines

## Concrete syntax

*Surface* or *concrete syntax* is concerned with how phrases are entered and
displayed on a computer. Usually thought of as given by strings of characters
from some alphabet.

## Abstract syntax

*Structural* or *abstract syntax* is concerned with the structure of phrases,
specifically how they are composed from other phrases.

At this level, a phrase is a *tree* whose nodes are operators that combine
several phrases to form another phrase.

```
AST -> nodes are operators.
```

The *binding structure* of syntax is concerned with the introduction and use of
identifiers: how they are declared, and how declared identifiers can be used.

```
ABT -> identifiers, binding and scope.
```

Functions and relations on ABTs give precise meaning to the informal ideas of
binding and scope of identifiers.

**Our focus: finite trees augmented with a means of expressing the binding and
scope of identifiers within a syntax tree.**

## A "piece of syntax"

Define a "piece of syntax" in two stages: ASTs then ABTs.

### Abstract Syntax Trees

An ordered tree whose leaves are *variables*, and whose interior nodes are
*operators* whose *arguments* are its children.

#### Sorts, operators and arity

ASTs are classified into *sorts* corresponding to different forms of syntax.

A *variable* stands for an unspecified piece of syntax of a specified sort.

ASTs can be combined by an *operator*, which has an *arity* specifying the sort
of the operator and the number and sorts of its arguments.

#### Variables

A *variable* is an *unknown* object drawn from some domain.

The unknown can become known by *substitution* of a particular object for all
occurrences of a variable in a formula, thereby specializing a general formula
to a particular instance. **Example:**

In school algebra variables range over real numbers:

```
x^2 +  2x   + 1
7^2 + (2*7) + 1 <-- substitute 7 for x
64
```

#### Syntactic categories

*Sorts* divide ASTs into *syntactic categories*.

**Example:** familiar programming languages have a syntactic distinction between
*expressions and commands*.

**Variables in ASTs range over sorts** in the sense that only ASTs of the specified
sort of the variable can be plugged in for that variable.
