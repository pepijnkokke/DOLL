---
title  : What do Data-Oriented Parsing and Categorial Grammar have to offer each other?
author : Pepijn Kokke
date   : April 6th, 2016
---

# Introduction

In this paper, we will look into the possible applications of
data-oriented parsing (DOP) to categorial grammars (CG). We do this by
examining two possible applications of DOP to CG. In
\autoref{the-problems-of-training-a-dop-model-on-a-corpus-of-cg-proofs}
we will discuss the possibility of training a DOP model on CG proofs,
and the problems that come with that. After that, in
\autoref{learning-grammar-logics-with-dop}, we will discuss  the
possibility of converting an existing DOP model to a categorial
grammar. First, however, we will briefly introduce DOP and CG.

## Data-Oriented Parsing

In the most general sense, data-oriented parsing (DOP) is a
methodology for deriving probabilistic rule-based grammars from
corpora. Most commonly, DOP is used to derive a probabilistic tree
substitution grammar (PTSG) from a treebank. So what is a PTSG? The
PTSG formalism is an extension over probabilistic context-free
grammars (PCFG). In short, we can view the rules in a context-free
grammar as trees. For instance, $\text{S}\to\text{NP}\;\text{VP}$
corresponds to the tree
$$
    \begin{tikzpicture}
    \Tree [.{S} NP VP ]
    \end{tikzpicture}
$$
Generating a sentence then corresponds to putting the right trees
together, using a composition operator "$\circ$" (called *label
substitution*) which replaces the left-most non-terminal in its first
argument with its second argument. For instance,

\begin{center}
  \begin{minipage}{0.15\linewidth}\centering
  \Tree [.{S} NP VP ]
  \end{minipage}%
\begin{minipage}{0.025\linewidth}\centering
  $\circ$
  \end{minipage}%
  \begin{minipage}{0.15\linewidth}\centering
  \Tree [.{NP} mary ]
  \end{minipage}%
  \begin{minipage}{0.025\linewidth}\centering
  $\circ$
  \end{minipage}%
  \begin{minipage}{0.15\linewidth}\centering
  \Tree [.{VP} laughs ]
  \end{minipage}%
  \begin{minipage}{0.025\linewidth}\centering
  $\mapsto$
  \end{minipage}%
  \begin{minipage}{0.25\linewidth}\centering
  \Tree [.{S} [.{NP} mary ] [.{VP} laughs ] ]
  \end{minipage}
\end{center}

Because of the structure of rules in CFG, rules will always correspond
to trees of depth *one*, i.e. consisting of a single node. Tree
substitution grammar simply drops this restriction, and allows
arbitrary trees as rules. Going back to *probabilistic* TSGs, in PTSG
each tree is assigned a probability, similar to the way this is done
in PCFGS---i.e. the probabilities for all trees with root label $X$
have to sum to one.

The derivation of a grammar using the DOP methodology is done in two
steps:

  1. take all subtrees of all the parse trees in the treebank as rules;

  2. compute the probability of each rule by counting the frequency of
     the associated subtree in the treebank.

Since taking *all* subtrees is practically infeasible, there is a
large body of work on statistical methods which aid the derivation of
approximate DOP grammars. However, since such methods approximate the
simple, deterministic process outlined above, and the exact manner in
which DOP grammars are constructed will be irrelevant for the
remainder of this paper, we will assume that DOP grammars are derived
using the simpler, deterministic procedure instead.


## Categorial Grammar

Over the years, categorial grammar (CG) has come to be
different things. In the form of the Lambek calculus [L;@lambek1958],
categorial grammar was purely a grammar formalism---a logical method
to decide whether or not a list of words formed a grammatical
sentence. However, the presence of associativity in the Lambek
calculus turned out to be too permissive, leading to the formulation
of the non-associative Lambek calculus [NL;@lambek1961]. Ostensibly,
this changed the formalism---it had become a logical method to decide
whether or not a *tree* of words formed a grammatical
sentence. However, this interpretation is misleading. L and NL both
support *two* methods of proof search: forward-chaining and
backward-chaining. As backward-chaining proof search is incredibly
simple to implement, most researchers gravitate towards it---and using
backward-chaining search, the above interpretation (that the formalism
has changed) is true. One uses proof search to find a proof *given* a
sequent, and in NL, such a sequent invariably contains a tree
structure for the sentence.
However, using *forward-chaining* proof search, one derives all
possible sentences given a list of words. Therefore, forward-chaining
proof search with NL will actually give you *more* than with L. In L,
you obtain a grammaticality judgement, whereas in NL you obtain a
grammaticality judgement *and* a parse tree.

There is a second component that has become inseperable from
categorial grammar and is arguably its greatest feature: *derivational
semantics*. Because categorial grammars are sound, logical systems, it
is possible to interpret grammaticality proofs as programs in a lambda
calculus, and obtain compositional semantics in this manner.

Lastly, there is large group of extensions over both L and NL, which
are known as extended Lambek calculi. For an overview of such extended
calculi, see @moortgat2010.

In summary, there are two main branches of categorial grammar as a
*grammar formalism*: the branch based on the Lambek calculus, and the
branch based on the non-associative Lambek calculus. Both of them are
logical grammar formalisms with derivational semantics. When we talk
about CG, we are referring to the group composed of L and NL with
derivational semantics, and their extensions.

# The problems of training a DOP model on a corpus of CG proofs

The DOP model proposes "to directly use corpus fragments as a grammar"
[@bod2008]. It does this by generating grammars based on thee
*subtrees* of trees in the corpus.  In CG, a grammaticality judgement
is a proof, and a proof is a *tree structure*. This means that, if we
had a corpus of CG proofs, we could theoretically train a DOP model
based on this corpus. In this case, label substitution would be the
actual label substitution operator, and the labels would be sequents.

Here, we immediately run into the problem that there *are* no large
corpuses available for CGs (since CG research tends to focus on
rule-crafting rather than corpus-building) and there are definitely no
*hand-annotated golden standards* such as the Penn Treebank---there is
hardly a canonical logical system. The only CG formalism which has
fairly large corpuses available is CCG, and this is one of the few CG
formalisms which *does not admit cut*.

There is another problem with the use of corpuses of CG derivations,
which has to do with the tendency of CGs to *fit*---an ideal
categorial grammar does not overgenerate, and in practice, many CGs
have the tendency to *undergenerate*. This means that if we have a
corpus of derivations, we have a set of logical rules which perfectly
analyse and generate the syntactic phenomena in the corpus. Therefore,
building a DOP model out of these derivations will add very litte.
In addition, if we were have *generated* golden standard corpus, it
would imply that we already have a CG which generates that corpus. It
would be doubtful whether the DOP parsing algorithm would offer much
in the way of an improvement over the CG algorithm.

Furthermore, this suggestion begs the questions of whether CG
derivations have the same useful subtree structure which we find
in parse trees. It is quite likely that the usefulness of
subderivations will vary greatly between different categorial
grammars, and between various styles---sequent calculus, natural
deduction, etc. One problem for such subderivation structure is the
fact that proofs generally either have a great deal of spurious
ambiguity, or a normal form and a normalisation procedure.
If the first is the case, it is in no way guaranteed that the same
derivation will always have the same structure, and in the second
case, there label substitution is not guaranteed to will not preserve
this structure.

For the concept of "subderivation" to make sense, the CG will have to
have a rather strict normal-form. Depending on the properties of this
normal-form, we may have to move away from TSG and into TAG---for
instance, some simple linguistic phenomenon may consist of multiple
rule applications which happen at different steps in the proof. To
capture these dependencies, and group them as a single, often
occurring, linguistic phenomenon, we would need to use TAG.

Furthermore, it may be hard to capture some phenomena in subtrees---or
subderivations. Let us assume we have some restricted version of
exchange, which would allow us to perform some form of movement,
e.g. quantifier movement
$$
    \AXC{$A$}
    \UIC{${\updownarrow}A$}
    \DisplayProof
    \quad
    \AXC{$A \prod (B \prod {\updownarrow}C)$}
    \doubleLine
    \UIC{${\updownarrow}C \prod (A \prod B)$}
    \DisplayProof
    \quad
    \AXC{$A \prod ({\updownarrow}B \prod C)$}
    \doubleLine
    \UIC{${\updownarrow}B \prod (A \prod C)$}
    \DisplayProof
$$
Now, regardless of whether or not these are good rules for quantifier
raising---but, for the record, they are not---you can see the problem
here. The rules allow for any quantifier to move up, and back
down. But, as the movement is done step-wise, for any given sentence,
there will be a *new* sequence of rule applications. Therefore, it is
unlikely that such a pattern will be picked up by a DOP model.

On the other hand, if you engineer your CG such that it summarizes the
quantifier movement in a single rule application, e.g as
$$
    \AXC{$A\prod\Gamma[\emptyset]$}
    \doubleLine
    \UIC{$\Gamma[{\updownarrow}A]$}
    \DisplayProof
$$
then you have a different problem, namely that the context $\Gamma$
will be different for each application of the rule. Therefore, such
subderivations, even if they consist of a single rule application,
are also unlikely to be picked up by a DOP model.

In previous work, Bod has "shown how discourse and semantics can be
incorporated into DOP if we have corpora containing discourse
structure and semantic annotations" [@bod1998;@bod2008]. He refers to
work on the OVIS corpus, which has semantics that are essentially
application-only. This is already more or less equivalent to using a
CG limited to the application-only AB fragment. We can cover quite a
lot of linguistic examples with such an approach: @kiselyov2014 have
demonstrated how to elegantly handle scope-taking in-situ, and using
extensible effects [@shan2002;@kiselyov2013] we should be able to
analyse many non-compositional semantic phenomena (anaphora,
expressives, intensionality, etc.) without leaving the
application-only fragment. However, we would run into problems with
movement.
While these would be taken care of *syntactically* by the DOP
framework, there is no mechanism which assigns them the correct
semantics.
Additionally, for this to work, we would need a corpus annotated with
function-application structure---so, in essence, the OVIS
corpus---which is quite a lot to ask for an approach that aims to be
example-based. Furthermore, it's not entirely obvious how to
generalise such an approach to be *unsupervised*. Therefore, this
might be a viable option in the development of domain-specific
grammars, but for general grammars we should expect it to be
infeasible. And, since our grammar will be application-only, there is
no value added by DOP, since an AB grammar will be equally successful,
and much less expensive to run.

It seems, therefore, that this sort of application of DOP to CG will
futile. The patterns that you would need to learn are not easily as
simple as subtrees.

# Learning grammar logics with DOP

There is another obvious similarity between DOP and CG: the notions of
trees and label substitution in TSG on the one hand, and sequents and
cut in CG on the other. We can define a mapping $X^*$ which interprets
labelled binary trees as formulas or structures, where $\prod$ is the
product, either structural or logical:
$$
    [_A\;X\;Y]^* = X \prod Y
    \qquad
    w^* = w
$$
We can extend this mapping to generate sequents by taking the root
label to be the output type. We write the resulting mapping
$\overline{X}$:
$$
    \overline{[_A\;X\;Y]} = [_A\;X\;Y]^* \vdash A
$$
This mapping does assume that the TSG only contains binary
trees. However, in practice this should not be a problematic
restriction to overcome, either by training the TSG in such a way that
it will consist solely of binary trees, or perhaps by extending the CG
formalism to include arbitrary products.

If we apply the above translation to our earlier example of label
substitution, we get:
$$
    \text{NP}\prod\text{VP}\vdash\text{S}
    \quad\circ\quad
    \text{mary}\vdash\text{NP}
    \quad\circ\quad
    \text{laughs}\vdash\text{VP}
    \quad\mapsto\quad
    \text{mary}\prod\text{laughs}\vdash\text{S}
$$
The link with cut is clear. However, there is one problem. On the CG
side of things, this notion of sequents and cut contains some
additional derivational structure---represented below by the vertical
dots---which is absent in DOP:
\begin{prooftree}
    \AXC{$\vdots$} \noLine \UIC{$\text{NP}\prod\text{VP}\vdash\text{S}$}
    \AXC{$\vdots$} \noLine \UIC{$\text{mary}\vdash\text{NP}$}
    \RightLabel{cut} \BIC{$\text{mary}\prod\text{VP}\vdash\text{S}$}
    \AXC{$\vdots$} \noLine \UIC{$\text{laughs}\vdash\text{VP}$}
    \RightLabel{cut} \BIC{$\text{mary}\prod\text{laughs}\vdash\text{S}$}
\end{prooftree}
In order for this similarity to be useful in practice, we would
somehow have to add in or recover this structure. There is one
interesting way in which we might be able to go about this.

As outlined in the previous section, if we were in the possession of a
golden standard corpus of CG derivations, it is likely that we would
also be in the possesion of some set of CG rules which perfectly
generate the subset of the language used in the corpus. Futhermore, if
we were to apply DOP to such a corpus, there is no guarantee that the
subderivations we would extract from it would be in any way meaningful
or useful.

However, we could assume that we don't have a perfect CG. The main
problem in categorial grammar is to find the right set of structural
rules which correspond exactly to the structure of language.
We can be reasonably sure that---in terms of expressivity---such rules
must lie somewhere between linear logic and NL.
Could we start out with a CG that drastically overgenerates---such as
linear logic---and somehow use DOP to find a set of axioms which form
an accurate model of language, however illogical they may be?
In order to do so, we would need a corpus of grammatical derivations
in linear logic and, somewhat predictably, such a corpus does not
exist. However, we might be able to avoid the need for such a corpus.
I propose the following approach:

  1. take a system for linear logic which has explicit structural
     rules and extend it with a second implication in the style of the
     Lambek calculi;
  2. define a cost measure on proofs which penalises uses of
     permutation rules;
  3. learn a DOP model with a PTSG;
  4. for each subtree, compute the associated sequent using the
     procedure outlined above, and search for a proof in linear logic;
  5. select those proofs which have the lowest cost.

Using this procedure, we should obtain a derivational DOP model. The
question is, how good would this model be? First, let us discuss some
properties that we require of the linear logic. The fragment of linear
logic that we will target is MALL (or propoisitional mutiplicative
additive linear logic). Furthermore, this system must be *focused*;
that is to say, it must have a normal form so that we can search for
proofs free of spurious ambiguity. Fortunately, linear logic has
such a system, first discovered by @andreoli1992, and later refined by
@andreoli2001 and @laurent2004. Of course, once we make the
permutation rules explicit, this normal-form property is lost. Rather
htan attempt to recover it by defining a normal form for permutations,
I suggest that we use *two* fragments of linear logic: a focused
system for proof search, and a system with explicit permutation for
cost analysis, which need not necessarily have a normal form.

Why would we target MALL? More specifically, the Lambek calculus
[@lambek1958] only has multiplicative constructs, so why include the
additives? First off, @lambek1961 already mentions the usefulness of
the additive conjunction for expressing ambiguity---and recently,
@morrill2015 demonstrated that *both* additives have their use in
this. Since there is no reason to believe that the treebank
part-of-speech tags have an exact one-to-one correspondence with
types in CG, the ability to map them to ambiguous types is important.

Why, then, would we extend MALL with Lambek-style directional
implications? The reasoning here is that we wish to penalise the use
of permutation. However, if we only had right-implication, then the
derivation of e.g. "Mary saw John"---or any other phrase with an
transitive verb, and hence a left-implication---would require a use of
the permutation rule. This may lead to undesirable consequences in
more complex sentences, when we really have to depend on our cost
function to select the ideal interpretation.  If we use directional
implications, then the permutation is built into the rules for
left-implication, and therefore not penalised.

Let's go over an example, and let's assume that we get to use a
somewhat normal two-sided sequent calculus version of linear logic,
so that we do not have to introduce focusing. We present such an
(implication-only) fragment in \autoref{fragment}. Let's have a look
at the analysis of the following tree:
\begin{center}
\Tree
  [.{S}
    [.{NP} She ]
    [.{VP} [.{VP} [.{V} saw ]
      [.{NP} [.{DT} the ] [.{NN} man ] ] ]
      [.{PP} [.{IN} with ]
        [.{NP} [.{DT} the ] [.{NN} telescope ] ] ] ]
    ]
\end{center}
We assume that the tree is analysed in the presence of a corpus, and
that DOP finds that the following subtrees are the ideal rules when
taking this corpus into account:
\begin{center}
  \begin{minipage}{0.3\linewidth}\centering
  \Tree [.{S} [.{NP} She ] [.{VP} [.{VP} [.{V} saw ] NP ] PP ] ]
  \end{minipage}%
  \begin{minipage}{0.2\linewidth}\centering
  \Tree [.{PP} [.{IN} with ] NP ]
  \end{minipage}%
  \begin{minipage}{0.2\linewidth}\centering
  \Tree [.{NP} [.{DT} the ] NN ]
  \end{minipage}%
  \begin{minipage}{0.1\linewidth}\centering
  \Tree [.{NN} man ]
  \end{minipage}%
  \begin{minipage}{0.1\linewidth}\centering
  \Tree [.{NN} telescope ]
  \end{minipage}
\end{center}
We apply our mapping $\overline{X}$, which gives us the following set
of sequents:
$$
    {\textsc{she}}\prod(({\textsc{saw}}\prod\text{NP})\prod\text{PP})\vdash\text{S}
    \quad\textsc{with}\prod\text{NP}\vdash\text{PP}
$$
$$
    \textsc{the}\prod\text{NN}\vdash\text{NP}
    \quad\textsc{man}\vdash\text{NN}
    \quad\textsc{telescope}\vdash\text{NN}
$$

When I write $\textsc{she}$ in the above sequents, this means two
things. First of all, it is an abbreviation of the type of 'she',
which, as we can tell from the above tree, is NP. But it conveys
more: it conveys a commitment to using a specific lexical item when
we translate to the $\lambda$-calculus---the lexicical definition of
'she'.

Anyway, let's assume that we did proof search in a version of linear
logic with implicit exchange, and that we have some procedure to
translate the resulting proofs to the fragment in
\autoref{fragment}. Below, we show the proofs for the first
sequent. For the other sequents there is only one proof, so we will
not go into those.

\begin{gather}
    \label{prfA}\tag{A}
    \AXC{she}\UIC{${\textsc{she}}\vdash\text{NP}$}
    \AXC{saw}\UIC{${\textsc{saw}}\vdash((\text{NP}\impr\text{S})\impl\text{PP})\impl\text{NP}$}
    \AXC{$\vdots$}\noLine\UIC{$\text{NP}\vdash\text{NP}$}
    \RightLabel{${\impl}$E}
    \BIC{${\textsc{saw}}\prod\text{NP}\vdash(\text{NP}\impr\text{S})\impl\text{PP}$}
    \AXC{$\vdots$}\noLine\UIC{$\text{PP}\vdash\text{PP}$}
    \RightLabel{${\impl}$E}
    \BIC{$({\textsc{saw}}\prod\text{NP})\prod\text{PP}\vdash\text{NP}\impr\text{S}$}
    \RightLabel{${\impr}$E}
    \BIC{${\textsc{she}}\prod(({\textsc{saw}}\prod\text{NP})\prod\text{PP})\vdash\text{S}$}
    \DisplayProof
    \\
    \label{prfB}\tag{B}
    \AXC{$\vdots$}\noLine\UIC{$\text{NP}\vdash\text{NP}$}
    \AXC{saw}\UIC{${\textsc{saw}}\vdash((\text{NP}\impr\text{S})\impl\text{PP})\impl\text{NP}$}
    \AXC{she}\UIC{${\textsc{she}}\vdash\text{NP}$}
    \RightLabel{${\impl}$E}
    \BIC{${\textsc{saw}}\prod{\textsc{she}}\vdash(\text{NP}\impr\text{S})\impl\text{PP}$}
    \AXC{$\vdots$}\noLine\UIC{$\text{PP}\vdash\text{PP}$}
    \RightLabel{${\impl}$E}
    \BIC{$({\textsc{saw}}\prod{\textsc{she}})\prod\text{PP}\vdash\text{NP}\impr\text{S}$}
    \RightLabel{${\impr}$E}
    \BIC{$\text{NP}\prod(({\textsc{saw}}\prod{\textsc{she}})\prod\text{PP})\vdash\text{S}$}
    \RightLabel{Ass.}
    \UIC{$\text{NP}\prod(({\textsc{saw}}\prod{\textsc{she}})\prod\text{PP})\vdash\text{S}$}
    \RightLabel{Ass.}
    \UIC{$(\text{NP}\prod({\textsc{saw}}\prod{\textsc{she}}))\prod\text{PP}\vdash\text{S}$}
    \RightLabel{Ass.}
    \UIC{$((\text{NP}\prod{\textsc{saw}})\prod{\textsc{she}})\prod\text{PP}\vdash\text{S}$}
    \RightLabel{Comm.}
    \UIC{$(({\textsc{saw}}\prod\text{NP})\prod{\textsc{she}})\prod\text{PP}\vdash\text{S}$}
    \RightLabel{Ass.}
    \UIC{$({\textsc{saw}}\prod(\text{NP}\prod{\textsc{she}}))\prod\text{PP}\vdash\text{S}$}
    \RightLabel{Comm.}
    \UIC{$({\textsc{saw}}\prod({\textsc{she}}\prod\text{NP}))\prod\text{PP}\vdash\text{S}$}
    \RightLabel{Ass.}
    \UIC{$(({\textsc{saw}}\prod{\textsc{she}})\prod\text{NP})\prod\text{PP}\vdash\text{S}$}
    \RightLabel{Comm.}
    \UIC{$(({\textsc{she}}\prod{\textsc{saw}})\prod\text{NP})\prod\text{PP}\vdash\text{S}$}
    \RightLabel{Ass.}
    \UIC{$({\textsc{she}}\prod({\textsc{saw}}\prod\text{NP}))\prod\text{PP}\vdash\text{S}$}
    \RightLabel{Ass.}
    \UIC{${\textsc{she}}\prod(({\textsc{saw}}\prod\text{NP})\prod\text{PP})\vdash\text{S}$}
    \DisplayProof
\end{gather}

As you can see, there are two proofs for the sequent ${\textsc{she}}\prod
(({\textsc{saw}}\prod\text{NP})\prod\text{PP})\vdash\text{S}$, which
we've called \eqref{prfA} and \eqref{prfB}. While there are many more
ways to do the swapping of 'she' and the anonymous NP in our current
axiomatisation, our translation method has chosen this particular
one. Particular choice of such a method aside, it should be obvious
that there is no sane[^sane] translation under which \eqref{prfA}
would require the use of permutation rules, and because of this, we
can be sure that our cost function will always prefer it over
\eqref{prfB}---and it just so happens that \eqref{prfA} is the correct
one.

Of course, this is merely an example, and a very fortuitous one at
that. There is no reason to believe that this will work in general,
and there are probably many situations in which this would go wrong.
Our current metric seems to be related to the distance to the landing
site across the branches, and there are many examples where such a
metric might give undesirable results. Nonetheless, because the most
common subtrees in a DOP model tend to be small, as they have to be
reusable, we believe that the complexity of linguistic phenomena within
a tree may be somewhat limited, and that such simple measure as
"number of permutations" may be more useful on a DOP model.

For most of this section, we have avoided talking about mapping
part-of-speech tags. Instead, we have been pretending that the these
are already valid types in the CG. However, if you look at the above
proofs, you will see that for, for instance, saw, we expect the
type $((\text{NP}\impr\text{S})\impl\text{PP})\impl\text{NP}$,
whereas the part-of-speech tag assigned by the Penn Treebank is
V. There are several solutions to this problem. The number of
part-of-speech tags is rather limited, so it may be possible to assign
these mappings by hand. Alternatively, as you can see, using the above
proof, we have derived one of the desired types for 'saw'. We could
try to adapt this approach to work in general. For instance, we could
try to generate a proof by using only the application rules, and see
which types are required to make such a proof work. Then, for each
part-of-speech tag, we could join all the mappings found in this way
using the additive conjunction.

All in all, we believe that the idea of learning grammar logics using
DOP is interesting, though further research and experimentation would
be required to determine its merits.

\begin{figure}[h]
\begin{mdframed}
  \centering
  \begin{minipage}{0.6\linewidth}
    \begin{align*}
      &\text{Atom}      &\!\!\!\!&\alpha        &\!\!\!\!&:= N\mid NP\mid S\mid PP\\
      &\text{Type}      &\!\!\!\!&A,B           &\!\!\!\!&:= \alpha\mid A\impr B\mid B\impl A\\
      &\text{Structure} &\!\!\!\!&\Gamma,\Delta &\!\!\!\!&:= A\mid\emptyset\mid \Gamma\prod \Delta\\
      &\text{Context}   &\!\!\!\!&\Sigma        &\!\!\!\!&:= \Box\mid \Sigma\prod \Delta\mid \Gamma\prod \Sigma
    \end{align*}
  \end{minipage}%
  \begin{minipage}{0.4\linewidth}
    \begin{align*}
      &\Box                 &\!\!\!\!&[\Gamma]&\!\!\!\!&\mapsto \Gamma\\
      &(\Sigma\prod \Delta) &\!\!\!\!&[\Gamma]&\!\!\!\!&\mapsto (\Sigma[\Gamma]\prod \Delta)\\
      &(\Delta\prod \Sigma) &\!\!\!\!&[\Gamma]&\!\!\!\!&\mapsto (\Delta\prod \Sigma[\Gamma])
    \end{align*}
  \end{minipage}
  \\[1\baselineskip]
  \begin{pfbox}
    \AXC{}\RightLabel{Ax}\UIC{$A\vdash A$}
  \end{pfbox}
  \\[1\baselineskip]
  \begin{pfbox}
    \AXC{$\Gamma\prod A\vdash B$}
    \RightLabel{$\impr${I}}
    \UIC{$\Gamma\vdash A\impr B$}
  \end{pfbox}
  \begin{pfbox}
    \AXC{$\Gamma\vdash A$}
    \AXC{$\Delta\vdash A\impr B$}
    \RightLabel{$\impr${E}}
    \BIC{$\Gamma\prod \Delta\vdash B$}
  \end{pfbox}
  \\[1\baselineskip]
  \begin{pfbox}
    \AXC{$\Gamma\prod A\vdash B$}
    \RightLabel{$\impl${I}}
    \UIC{$\Gamma\vdash B\impl A$}
  \end{pfbox}
  \begin{pfbox}
    \AXC{$\Gamma\vdash B\impl A$}
    \AXC{$\Delta\vdash A$}
    \RightLabel{$\impl${E}}
    \BIC{$\Gamma\prod\Delta\vdash B$}
  \end{pfbox}
  \\[1\baselineskip]
  \begin{pfbox}
    \AXC{$\Sigma[\Gamma\prod \emptyset]\vdash B$}
    \RightLabel{$\emptyset${E}}
    \UIC{$\Sigma[\Gamma]\vdash B$}
  \end{pfbox}
  \begin{pfbox}
    \AXC{$\Sigma[\Gamma]\vdash B$}
    \RightLabel{$\emptyset${I}}
    \UIC{$\Sigma[\Gamma\prod \emptyset]\vdash B$}
  \end{pfbox}
  \\[1\baselineskip]
  \begin{pfbox}
    \AXC{$\Sigma[\Delta\prod \Gamma]\vdash B$}
    \RightLabel{Comm.}
    \UIC{$\Sigma[\Gamma\prod \Delta]\vdash B$}
  \end{pfbox}
  \begin{pfbox}
    \AXC{$\Sigma[(\Gamma\prod \Delta)\prod \Pi]\vdash B$}
    \doubleLine\RightLabel{Ass.}
    \UIC{$\Sigma[\Gamma\prod (\Delta\prod \Pi)]\vdash B$}
  \end{pfbox}
  \vspace*{1\baselineskip}
\end{mdframed}
\caption{Fragment of Linear Logic with explicit structural rules.}
\label{fragment}
\end{figure}

# Conclusion

In this paper, we have looked at two main approach of applying
data-oriented parsing to categorial grammar (CG). The first approach,
to construct a DOP model based on a corpus of CG proof trees (as
opposed to parse trees) seems flawed and futile. However, the second
approach---learning a DOP model based on parse trees, and then
searching for matching proofs in a highly permissive logic
such as linear logic---seems an interesting way of using DOP to
construct a grammar logic in an exemplar-based fashion, as opposed to
the artismal hand-crafting of rules which is the status quo in CG.
All in all, however, further research is required to determine whether
this approach truly has merit.

[^sane]: For suitable definitions of 'sane'.

# References
