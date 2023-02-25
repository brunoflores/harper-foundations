# E

When defining a language, we shall be primarily concerned with its *abstract
syntax*, specified by a collection of *operators and their arities*.

The abstract syntax provides a systematic, unambiguous account of the
hierarchical and binding structure of the language and is considered **the
official presentation of the language**.

## Syntax chart

It is also useful to specify minimal concrete syntax conventions.

```
Typ t := num             num                  numbers
         str             str                  strings

Exp e := x               x                    variable
         num[n]          n                    numeral
         str[s]          "s"                  literal
         plus(e1;e2)     e1 + e1              addition
         times(e1;e2)    e1 * e2              multiplication
         cat(e1;e2)      e1 ^ e2              concatenation
         len(e)          |e|                  length
         let(e;x.e2)     let x be e1 in e2    definition
```

This chart defines two sorts. `Typ`, ranged over by `t`, and `Exp`, ranged over
by `e`. For example, the operator `let` has arity `(Exp, Exp.Exp)Exp`, which
specifies that it has two arguments of sort `Exp`, and binds a variable of sort
`Exp` in the second argument.

## Type System

**The role of a type system is to impose constraints on the formation of phrases
that are sensitive to the context in which their occur.**

In the general case, the *only* information required about the context of an
expression is the type of the variables within whose scope the expression
lies. The statics of `E` consists of an inductive definition of generic
hypothetical judgments of the form,

$$\vec{x}\ |\ \Gamma \vdash \mathcal{e} : \mathcal{t}$$

where $\vec{x}$ is a finite set of variables, and $\Gamma$ is a *typing context*
consisting of hypotheses of the form $\mathcal{x} : \mathcal{t}$, one for each
$\mathcal{x} \in \vec{x}$. We write $\mathcal{x} \notin \mathcal{dom}(\Gamma)$
to say that the variable $\mathcal{x}$ is *fresh* for $\Gamma$.

The rules defining the statics of `E` are as follows,

$$
\begin{array}{ c c }
\frac{}{\Gamma, \mathcal{x} : \mathcal{t} \vdash \mathcal{x} : \mathcal{t}} &
\text{Intro} \\
\frac{}{\Gamma, \mathcal{x} : \mathcal{t} \vdash \mathcal{x} : \mathcal{t}} &
\text{Intro} \\
\end{array}
$$
