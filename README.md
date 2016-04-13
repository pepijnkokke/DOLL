---
title  : DOLL; or "What do Data-Oriented Parsing and Categorial Grammar have to offer each other?"'
author : Pepijn Kokke
date   : April 6th, 2016
---

# Introduction

In this essay, I am going to have a look into the possible
applications of data-oriented parsing to categorial grammars. Before
that, however, I'm going to briefly review these two formalisms.


## Data-Oriented Parsing

In the most general sense, data-oriented parsing (DOP) is a
methodology for deriving probabilistic rule-based grammars from
corpora. Most commonly, DOP is used to derive a probabilistic tree
substitution grammar (PTSG) from a treebank. So what is a PTSG? The
PTSG formalism is an extension over probabilistic context-free
grammars (PCFG). In short, we can view the rules in a context-free
grammar as trees. For instance, $\text{S}\to\text{NP}\;\text{VP}$
corresponds to the tree $[_\text{S}\;\text{NP}\;\text{VP}]$.
Generating a sentence then corresponds to putting the right trees
together, using a composition operator "$\circ$" (called *label
substitution*) which replaces the left-most non-terminal in its first
argument with its second argument. For instance,
$$
    [_\text{S}\;\text{NP}\;\text{VP}]
    \circ
    [_\text{NP}\;\text{mary}]
    \circ
    [_\text{VP}\;\text{laughs}]
    \mapsto
    [_\text{S}\;[_\text{NP}\;\text{mary}]\;[_\text{VP}\;\text{laughs}]]
$$
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
remainder of this essay, I will assume that DOP grammars are derived
using the simpler, deterministic procedure.


## Categorial Grammar

Over the years, categorial grammar (CG[^cg]) has come to be
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
backward-chaining search, the above interpretation is *true*: One uses
proof search to find a proof *given* a sequent, and in NL, such a
sequent invariably contains a tree structure for the
sentence. However, using *forward-chaining* proof search, one derives
all possible sentences given a list of words. Therefore,
forward-chaining proof search with NL will actually give you *more*
than with L. In L, you obtain a grammaticality judgement, whereas in
NL you obtain a grammaticality judgement *and* a parse tree.

There is a second component to categorial grammar, which is arguably
its true strength: *derivational semantics*. Because categorial
grammars are sound, logical systems, it is possible to interpret
grammaticality proofs in higher order logic, and obtain compositional
semantics in this manner.

In summary, there are two main branches of categorial grammar as a
*grammar formalism*: the branch based on the Lambek calculus, and the
branch based on the non-associative Lambek calculus. Both of them are
logical grammar formalisms with derivational semantics.


# Similarities and Differences

In this section, we will discuss the possibilities for cooperation
between parts or the whole of DOP and CG. However, before we delve
into the myriad of ways DOP could (or could not) be applied to CG and
vice versa, it may be worthwhile to consider what the two formalisms
have in common. We will do this now.

## Similarities between DOP and CG

Obviously, in the ways that they are used, DOP and CG are rather
dissimilar. There are, however, two noticable exceptions to
this. First, there is a strong similarity between the notions of trees
and label substitution in TSG on the one hand, and sequents and cut in
CG on the other. We can define a mapping $X^*$ which interprets
labelled binary trees as formulas or structures:
$$
    [_A\;X\;Y]^* = X \bullet Y
    \qquad
    w^* = w
$$
And we can extend this mapping to generate sequents by taking the root
label to be the output type. We write the resulting mapping $\overline{X}$:
$$
    \overline{[_A\;X\;Y]} = [_A\;X\;Y]^* \vdash A
$$
This does assume that the TSG only contains binary trees. However, in
practice this should not be a problematic restriction to overcome,
either by training the TSG in such a way that it will consist solely
of binary trees, or perhaps by extending the CG formalism to include
arbitrary products.

If we apply the above translation to our earlier example of label
substitution, we get the following:
$$
    \text{NP}\bullet\text{VP}\vdash\text{S}
    \quad\circ\quad
    \text{mary}\vdash\text{NP}
    \quad\circ\quad
    \text{laughs}\vdash\text{VP}
    \quad\mapsto\quad
    \text{mary}\bullet\text{laughs}\vdash\text{S}
$$
The link with cut is obvious. However, on the CG side of things, this
notion contains additional derivational structure---represented below
by the vertical dots---which is absent in DOP.
\begin{prooftree}
    \AXC{$\vdots$} \noLine \UIC{$\text{NP}\bullet\text{VP}\vdash\text{S}$}
    \AXC{$\vdots$} \noLine \UIC{$\text{mary}\vdash\text{NP}$}
    \RightLabel{cut} \BIC{$\text{mary}\bullet\text{VP}\vdash\text{S}$}
    \AXC{$\vdots$} \noLine \UIC{$\text{laughs}\vdash\text{VP}$}
    \RightLabel{cut} \BIC{$\text{mary}\bullet\text{laughs}\vdash\text{S}$}
\end{prooftree}
Therefore, it remains to be seen how useful this similarity is in practice.

The second similarity stems from the fact that in CG, a grammaticality
judgement is a proof, and a proof is a *tree structure*. This means
that, if we had a corpus of CG proofs, we could theoretically train a
DOP model based on this corpus. In this case, label substitution would
be the actual label substitution operator, and the labels would be
sequents. However, this suggestion begs the questions of whether CG
derivations have the same useful subderivation structure which we find
in parse trees. It is quite likely that this will vary greatly between
different categorial grammars, and between various styles---sequent
calculus, natural deduction, etc. One problem for such subderivation
structure is the fact that proofs generally either have a great deal
of spurious ambiguity, or a normal form. Therefore, it is in no way
guaranteed that the same derivation will always have the same
structure, or that "label substitution" will preserve this structure.
Therefore, it remains to be seen whether or not training a DOP model
on "subderivations" is a good idea.

### Is "subderivation" a useful concept?

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
    \AXC{$A \bullet (B \bullet {\updownarrow}C)$}
    \doubleLine
    \UIC{${\updownarrow}C \bullet (A \bullet B)$}
    \DisplayProof
    \quad
    \AXC{$A \bullet ({\updownarrow}B \bullet C)$}
    \doubleLine
    \UIC{${\updownarrow}B \bullet (A \bullet C)$}
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
    \AXC{$A\bullet\Gamma[\varnothing]$}
    \doubleLine
    \UIC{$\Gamma[{\updownarrow}A]$}
    \DisplayProof
$$
then you have a different problem, namely that the context $\Gamma$
will be different for each application of the rule. Therefore, such
subderivations, even if they consist of a single rule application,
are also unlikely to be picked up by a DOP model.

It seems, therefore, that this sort of application of DOP to CG will
futile. The patterns that you would need to learn are not easily as
simple as subtrees.

There is a tendency in CG to *link* two related sentences
derivationally---e.g. the derivation of "The person who I saw walking
down the street seemed tired" may include the derivation of "I saw the
person walking down the street". This ensure that the meanings of the
two sentences are (compositionally) related. Such linking is clearly
absent from DOP models of language, not only because, in its
foundations, DOP models are only concerned with syntax, but also
because, when a DOP model *is* enriched with syntax, the relation in
meaning is entirely coincidental.


## What does DOP have to offer to CG?

The DOP model proposes "to directly use corpus fragments as a grammar"
[@bod2008]. Here, we immediately run into the problem that there *are*
no large corpuses available for CGs (since CG-research tends to focus
on rule-crafting rather than corpus-building) and there are definitely
no *hand-annotated golden standards* such as the Penn Treebank---there
is hardly a canonical logical system. The only CG formalism which has
fairly large corpuses available is CCG, and this is one of the few CG
formalisms which *does not admit cut*. In addition, if we were to use
a *generated* golden standard, that would imply that we already have a
CG which can generate that corpus. It would be doubtful whether the
DOP parsing algorithm would offer much in the way of an improvement
over the CG algorithm.

There is another problem with the use of corpuses of CG derivations,
which has to do with the tendency of CGs to *fit*---an ideal
categorial grammar does not overgenerate, and in practice, many CGs
have the tendency to *undergenerate*. This means that if we have a
corpus of derivations, we have a set of logical rules which perfectly
analyse and generate the syntactic phenomena in the corpus. Therefore,
building a DOP model out of these derivations will add very litte.

However, there is one thing a DOP model constructed on the basis of a
corpus of CG derivations gives us: a *probability measure*.


## What does CG have to offer to DOP?

Semantics. In previous work, Bod has "shown how discourse and
semantics can be incorporated into DOP if we have corpora containing
discourse structure and semantic annotations" [@bod2008;@bod1998].
He refers to work on the OVIS corpus, which has semantics that are
essentially application-only. Using such an approach would limit our
CG to the (application-only) AB fragment. We could get quite far with
such an approach: @kiselyov2014 have demonstrated how to elegantly
handle scope-taking in-situ, and using extensible effects we should be
able to analyse many non-compositional semantic phenomena without
leaving the application-only fragment.
However, we would run into problems with movement. While these would
be taken care of *syntactically* by the DOP framework, there is no
mechanism which assigns them the correct semantics.
Additionally, for this to work, we would need a corpus annotated
with function-application structure---so, in essence, the OVIS
corpus---which is quite a lot to ask for an approach that aims to be
example-based. Furthermore, it's not entirely obvious how to
generalise such an approach to be *unsupervised*. Therefore, this
might be a viable option in the development of domain-specific
grammars, but for general grammars we should expect it to be
infeasible. And, since our grammar will be application-only, there is
no value added by DOP, since an AB grammar will be equally successful,
and much less expensive to run.


# Learning substructural systems with DOP

There is one other interesting direction we could take with
DOP and CG, leaning more towards DOP. As outlined in the previous
section, if we could even conceive of a golden standard corpus of CG
derivations, it is likely that we would already be in the possesion of
some set of CG rules which perfectly generate the subset of the
language used in the corpus.
Futhermore, if we were to apply DOP to such a corpus, there is no
guarantee that the subderivations we would extract from it would be in
any way meaningful or useful.

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
     procedure outlined in \autoref{similarities-between-dop-and-cg},
     and search for a proof in linear logic;
  5. select those proofs which have the lowest cost.

Using this procedure, we should obtain a derivational DOP model. The
question is, how good would this model be? First, let us discuss some
properties that we require of the linear logic. The fragment of linear
logic that we will target is MALL (or propoisitional mutiplicative
additive linear logic). Furthermore, this system must be *focused*;
that is to say, it must have a normal-form so that we can search for
proofs free of spurious ambiguity. Fortunately, linear logic has
exactly such a system [@andreoli1992;@andreoli2001;@laurent2004]. Of
course, once we make the permutation rules explicit, this property
falls away. Therefore, I suggest that we use *two* linear logic
systems: a focused system for proof search, and a system with explicit
permutation for cost analysis.

<!--
  1. We start out with a system for propositional multiplicative,
     additive linear logic (commonly known as MALL). It is important
     that this system has several properties:

       - it must be *focused* to ensure that there is no spurious
         ambiguity;
       - it must have explicit structural rules---i.e. it must have an
         explicit version of exchange, which is broken down into
         commutativity and associativity of the product;
       - it must be extended with a second implication, in the style
         of the Lambek calculi.

     It will become clear soon why these last two properties are
     important.

  2. We define a cost measure on proofs. The simplest way is to assign
     costs to each of the inference rules, and sum over them. The main
     idea is to *penalize* the use of structural rules such as
     associativity and commutativity. One simple approach would be to
     assign these the cost of $1$, and all other rules the cost of
     $0$. This defines a preference metric on proofs which prefers
     proofs with fewer uses of exchange.
-->

[^cg]: Personally, I pronounce this "CatGram". There are two reasons
     why I do this. Firstly, there are too many things that are
     abbreviated CG (e.g. categorial grammar, constraint grammar,
     construction grammar) and while CatGram by all rights could claim
     first dibs on the abbreviation, that wouldn't really solve
     anything. Secondly, it sounds adorable.

# References
