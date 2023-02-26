# E

When defining a language, we shall be primarily concerned with its *abstract
syntax*, specified by a collection of *operators and their arities*.

The abstract syntax provides a systematic, unambiguous account of the
hierarchical and binding structure of the language and is considered **the
official presentation of the language**.

## Statics

### Syntax chart

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

### Type System

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
\huge{\frac{}{\Gamma,\ \mathcal{x}\ :\ \mathcal{t}\ \vdash\ \mathcal{x}\ :\ \mathcal{t}}} &
\\\ &\ \\
\huge{\frac{}{\Gamma\ \vdash\ \texttt{str}[s]\ :\ \texttt{str}}} &
\text{Intro}
\\\ &\ \\
\huge{\frac{}{\Gamma\ \vdash\ \texttt{num}[n]\ :\ \texttt{num}}} &
\text{Intro}
\\\ &\ \\
\huge{
  \frac{\Gamma\ \vdash\ e_1\ :\ \texttt{num}\ \ \Gamma\ \vdash\ e_2\ :\ \texttt{num}}
       {\Gamma\ \vdash\ \texttt{plus}(e_1;e_2)\ :\ \texttt{num}}} &
\text{Elim}
\\\ &\ \\
\huge{
  \frac{\Gamma\ \vdash\ e_1\ :\ \texttt{num}\ \ \Gamma\ \vdash\ e_2\ :\ \texttt{num}}
       {\Gamma\ \vdash\ \texttt{times}(e_1;e_2)\ :\ \texttt{num}}} &
\text{Elim}
\\\ &\ \\
\huge{
  \frac{\Gamma\ \vdash\ e_1\ :\ \texttt{str}\ \ \Gamma\ \vdash\ e_2\ :\ \texttt{str}}
       {\Gamma\ \vdash\ \texttt{cat}(e_1;e_2)\ :\ \texttt{str}}} &
\text{Elim}
\\\ &\ \\
\huge{
  \frac{\Gamma\ \vdash\ e\ :\ \texttt{str}}
       {\Gamma\ \vdash\ \texttt{len}(e)\ :\ \texttt{num}}} &
\text{Elim}
\\\ &\ \\
\huge{
  \frac{\Gamma\ \vdash\ e_1\ :\ t_1\ \ \Gamma,\ x\ :\ t_1\ \vdash\ e_2\ :\ t_2}
       {\Gamma\ \vdash\ \texttt{let}(e_1;x.e_2)\ :\ t_2}} &
\text{Side condition:}\ \mathcal{x} \notin \mathcal{dom}(\Gamma)
\end{array}
$$

The typing rules are *syntax-directed*: there is exactly one rule for each form
of expression (Lemma 4.2, page 35, "Inversion of Typing").

The *introduction forms* for a type determine the *values*, or *canonical
forms*, of that type. The *elimination forms* determine how to manipulate the
values of a type to form a computation of another (possibly the same) type.

## Dynamics

The *dynamics* of a language describes how programs are executed.

The most important way to define the dynamics of a language is by the method of
*structural dynamics*, which defines a *transition system* that inductively
specifies the step-by-step process of executing a program.

### Transition Systems

A *transition system* is specified by the following four forms of judgment:

1. $\mathcal{s}\ \text{state}$, asserting that $\mathcal{s}$ is a *state* of the
   transition system.
2. $\mathcal{s}\ \text{final}$, where $\mathcal{s}\ \text{state}$, asserting
   that $\mathcal{s}$ is a *final* state.
3. $\mathcal{s}\ \text{initial}$, where $\mathcal{s}\ \text{state}$, asserting
   that $\mathcal{s}$ is an *initial* state.
4. $\mathcal{s}\ \longmapsto\ \mathcal{s'}$, where $\mathcal{s}\ \text{state}$
   and $\mathcal{s'}\ \text{state}$, asserting that state $\mathcal{s}$ may
   transition to state $\mathcal{s'}$.

A *transition sequence* is a sequence of states
$\mathcal{s_0}, \cdots, \mathcal{s_n}$ such that $\mathcal{s_0}\ \text{initial}$
and $\mathcal{s_i}\ \longmapsto\ \mathcal{s_{i+1}}$ for every
$\mathcal{0 \leq i < n}$. A transition sequence is *maximal* iff there is no
$\mathcal{s}$ such that $\mathcal{s_n}\ \longmapsto\ \mathcal{s}$, and it is
*complete* iff it is maximal and $\mathcal{s_n}\ \text{final}$. The judgment
$\mathcal{s} \downarrow$ means that there is a complete transition sequence
starting from $\mathcal{s}$, which is to say that there exists
$\mathcal{s'}\ \text{final}$ such that
$\mathcal{s} \longmapsto^* \mathcal{s'}$.

The *iteration* of transition judgment $\mathcal{s} \longmapsto^* \mathcal{s'}$
is inductively defined by the following rules:

$$
\begin{array}{c}
\huge{\frac{}{\mathcal{s}\ \longmapsto^* \mathcal{s}}}
\\\ \\
\huge{
  \frac{\mathcal{s}\ \longmapsto \mathcal{s'}\ \ \mathcal{s'}\ \longmapsto^* \mathcal{s''}}
       {\mathcal{s}\ \longmapsto^* \mathcal{s''}}
}
\end{array}
$$

### Structural Dynamics

A *structural dynamics* for the language `E` is given by a transition system:

* States are closed expressions
* All states are initial
* The final states are the (closed) values (completed computations)

The judgment $\mathcal{e}\ \text{val}$, which states that $\mathcal{e}$ is a
value, is inductively defined by the following rules:

$$
\begin{array}{ c }
\huge{\frac{}{\texttt{num}[\mathcal{n}]\ \text\{val}}}
\\\ \\
\huge{\frac{}{\texttt{str}[\mathcal{s}]\ \text{val}}}
\end{array}
$$

The transition judgment $\mathcal{e} \longmapsto \mathcal{e'}$ between states is
inductively defined by the following rules:

$$
\begin{array}{ c c }
\huge{
  \frac{\mathcal{n_1} + \mathcal{n_2} = \mathcal{n}}
       {\texttt{plus}(\texttt{num}[\mathcal{n_1}];\texttt{num}[\mathcal{n_2}])\
	    \longmapsto\ \texttt{num}[\mathcal{n}]}
} & \text\{IT}
\end{array}
$$
