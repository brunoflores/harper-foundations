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

**Variables in ASTs range over sorts** in the sense that only ASTs of the
specified sort of the variable can be plugged in for that variable.

#### Language example

Consider a language of arithmetic expressions built from numbers, addition, and
multiplication. The AST consists of a single sort $\mathtt{Exp}$ generated by
these operators:

1. An operator $\mathtt{num[\mathit{n}]}$ of sort $\mathtt{Exp}$ for each
   $\mathit{n} \in \mathbb{N}$
2. Two operators, $\mathtt{plus}$ and $\mathtt{times}$, of sort $\mathtt{Exp}$,
   each with two arguments of sort $\mathtt{Exp}$

The expression $\mathtt{2 + (3 \times \mathit{x})}$ would be represented by the
AST of sort $\mathtt{Exp}$, under the assumption that $\mathit{x}$ is also of
this sort:

$$\mathtt{plus(num[2];times(num[3];\mathit{x}))}$$

#### Structural induction

The tree structure of ASTs provides a very useful principle of reasoning, called
*structural induction*.

To prove that some property $\mathit{P(a)}$ holds for all ASTs
$\mathit{a}$ of a given sort, it is enough to consider all the ways in which
$\mathit{a}$ can be generated and show that the property holds in each case
under the assumption that it holds for its constituent ASTs (if any). It
exhausts all possibilities for the formation of $\mathit{a}$.

#### Formalization with Sets

Let $\mathit{S}$ be a finite *set of sorts*.

For a given set $\mathit{S}$ of sorts, an *arity* has the form,

$$\mathit{(s_1, \cdots, s_n)s}$$

which specifies the sort $\mathit{s} \in \mathit{S}$ of an operator taking
$\mathit{n} \geq 0$ arguments, each of sort $\mathit{s_i} \in \mathit{S}.$

Let $\mathcal{O} = \\{ \mathcal{O_\alpha} \\}$ be an arity-indexed family of
disjoint sets of *operators* $\mathcal{O_\alpha}$ of arity $\alpha$. If
$\mathit{o}$ is an operator of arity $\mathit{(s_1, \cdots, s_n)s}$, we say that
$\mathit{o}$ has sort $\mathit{s}$ and has $\mathit{n}$ arguments of sorts
$\mathit{s_1, \cdots, s_n}$.

Fix a set $\mathcal{S}$ of sorts and an arity-indexed family $\mathcal{O}$ of
sets of operators of each arity. Let
$\mathcal{X} = \\{ \mathcal{X}_s \\} _{s \in S}$ be a sort-indexed
family of disjoint finite sets $\mathcal{X}_s$ of *variables* $\mathcal{x}$
of sort $\mathcal{s}$. When $\mathcal{X}$ is clear from context, we say that a
variable $\mathcal{x}$ is of sort $\mathcal{s}$ if $\mathcal{x \in X_s}$, and we
say that $\mathcal{x}$ is *fresh for* $\mathcal{X}$, or just *fresh* when
$\mathcal{X}$ is understood, if $\mathcal{x \notin X_s}$ for any sort
$\mathcal{s}$. If $\mathcal{x}$ is fresh for $\mathcal{X}$ and $\mathcal{s}$ is
a sort, then $\mathcal{X,x}$ is the family of sets of variables obtained by
adding $\mathcal{x}$ to $\mathcal{X_s}$.

The family
$\mathcal{A}[\mathcal{X}] = \\{ \mathcal{A}[\mathcal{X}] _s \\} _\mathcal{s \in S}$
of ASTs of sort $\mathcal{s}$ is the smallest family satisfying the following
conditions:

1. A variable of sort $\mathcal{s}$ is an AST of sort $\mathcal{s}$: if
   $\mathcal{x \in X_s}$, then $\mathcal{x} \in \mathcal{A}[\mathcal{X}]_s$.
2. Operators combine ASTs: if $\mathcal{o}$ is an operator or arity
   $(s_1, \cdots, s_n)s$, and if
   $\mathcal{a_1} \in \mathcal{A}[\mathcal{X}] _{s1}, \cdots, \mathcal{a_n} \in \mathcal{A}[\mathcal{X}] _{sn}$,
   then $\mathcal{o(a_1; \cdots; a_n)} \in \mathcal{A}[\mathcal{X}]_s$.

**Variables are given meaning by substitution.** If
$\mathcal{a} \in \mathcal{A}[\mathcal{X,x}] _{s'}$, and
$\mathcal{b} \in \mathcal{A}[\mathcal{X}] _s$, then
$[\mathcal{b/x}]\mathcal{a} \in \mathcal{A}[\mathcal{X}] _{x'}$ is the result of
substituting $\mathcal{b}$ for every occurrence of $\mathcal{x}$ in
$\mathcal{a}$.

```
[b/x]a
   ^ ^
   ^-^--subject
     ^
     ^--target
```

### Abstract Binding Trees

*Abstract binding trees* enrich ASTs with the means to introduce new variables
and symbols, called a *binding*, with a specified range of significance, called
its *scope*. ABTs generalize ASTs by allowing an operator to bind any finite
number (possibly zero) of variables in each argument.

The **scope** of a binding is an ABT within which the bound identifier can be
used, either as a placeholder or as the index of some operator.

Different subtrees may introduce identifiers with disjoint scopes.

The crucial principle is that **any use of an identifier should be understood as
a reference, or abstract pointer, to its binding**.

* The choice of identifiers is immaterial, so long as we can always associate a
  unique binding with each use of an identifier.
* The names of bound variables are immaterial insofar as they determine the same
  binding.

An argument to an operator is called an *abstractor* and has the form,

$$\mathcal{x_1, \cdots, x_k.a}.$$

The sequence of variables $\mathcal{x_1, \cdots, x_k}$ are bound within the ABT
$\mathcal{a}$. In the form of an ABT, the expression
$\mathtt{let~\mathcal{x}~be~a_1~in~a_2}$
