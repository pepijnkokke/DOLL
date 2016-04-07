---
title  : "What can Data-Oriented Parsing and Categorial Grammar offer each other?"
author : Pepijn Kokke
date   : April 6th, 2016
---

# Introduction

I'm honestly more of a cat person. Frankly, I don't like dogs at
all. There. I thought I should say that before we go any further into
this. Well, with that out of the way: In this essay, I will have a
look into the possible applications of data-oriented parsing (DOP) to
categorial grammars (CatGram, or CG for short). But before that, I
will quickly review DOP and CG.


## What is Data-Oriented Parsing?

In the most general sense, DOP is a methodology for deriving
probabilistic rule-based grammars from corpora. Most commonly, DOP
is used to derive a probabilistic tree substitution grammar (PTSG)
from a treebank. The PTSG formalism is an extension over probabilistic
context-free grammars (PCFG). In short, we can view the rules in a
context-free grammar (CFG) as trees. For instance,
$\text{S}\to\text{NP}\;\text{VP}$ corresponds to the tree
$[_\text{S}\;\text{NP}\;\text{VP}]$. Generating a sentence then
corresponds to the composition of trees, using a composition operator
"$\circ$" (called *label substitution*) which replaces the left-most
non-terminal in its first argument with its second argument. For
instance,
$$
    [_\text{S}\;\text{NP}\;\text{VP}]
    \circ
    [_\text{NP}\;\text{mary}]
    \circ
    [_\text{VP}\;\text{laughs}]
    \mapsto
    [_\text{S}\;\text{mary}\;\text{laughs}]
$$
Because of the structure of rules in CFG, rules will always correspond
to trees of depth one, i.e. consisting of a single node. Tree
substitution grammar (TSG) simply drops this restriction, and allows
arbitrary trees as rules. PTSG  then weighs each of these trees with
a probability, similar to PCFG.

The derivation of a grammar using the DOP methodology is done in two
steps:

  1. take all subtrees of all the parse trees in the treebank as rules;

  2. compute the probability of each rule by counting the frequency of
     the associated subtree in the treebank.

Since taking *all* subtrees is practically infeasible, there is a
large body of work on statistical methods which aid the derivation of
approximate DOP grammars. However, since such methods approximate the
simple, deterministic process outlined above, and the exact manner in
which DOP grammars are constructed will be irrelevant, for the
remainder of this essay, I will assume that DOP grammars are derived
using the simpler, deterministic procedure.


## What is Categorial Grammar?

Over the years, categorial grammar has come to be different things. In
the form of the Lambek calculus [L;@lambek1958], categorial grammar
was purely a grammar formalism---a logical method to decide whether or
not a list of words formed a grammatical sentence. However, the
presence of associativity in the Lambek calculus turned out to be too
permissive, leading to the formulation of the non-associative Lambek
calculus [NL;@lambek1961]. Ostensibly, this changed the formalism---it
had become a logical method to decide whether or not a *tree* of words
formed a grammatical sentence. However, this interpretation is
misleading. L and NL both support *two* methods of proof search:
forward-chaining and backward-chaining. As backward-chaining proof
search is incredibly simple to implement, most researchers gravitate
towards it---and using backward-chaining search, the above
interpretation is *true*: One uses proof search to find a proof
*given* a sequent, and in NL, such a sequent invariably contains a
tree structure for the sentence. However, using *forward-chaining*
proof search, one derives all possible sentences given a list of
words. Therefore, forward-chaining proof search with NL will actually
give you *more* than with L. In L, you obtain a grammaticality
judgement, whereas in NL you obtain a grammaticality judgement *and* a
parse tree.

There is a second component to categorial grammar, which is arguably
its true strength: *derivational semantics*. Because categorial
grammars are sound, logical systems, it is possible to interpret
grammaticality proofs in higher order logic, and obtain compositional
semantics in this manner.

In summary, there are two main branches of categorial grammar as a
*grammar formalism*: the branch based on the Lambek calculus, and the
branch based on the non-associative Lambek calculus. Both of them are
logical grammar formalisms with derivational semantics.


## Similarities between DOP and CG

There is a strong similarity between the notions of trees and label
substitution in TSG on the one hand, and sequents and cut in CG on the
other---however, the second notion contains additional derivational
structure which is absent in the first.

There is a tendency in CG to *link* two related sentences
derivationally---e.g. the derivation of "The person who I saw walking
down the street looked tired" may include the derivation of "I saw the
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
formalisms which *does not admit cut*.

There is another problem with the use of corpuses of CG derivations,
which has to do with the tendency of CGs to *fit*---an ideal
categorial grammar does not overgenerate. This means that if we have a
corpus of derivations, we have a set of logical rules which perfectly
analyse and generate the syntactic phenomena in the corpus. Therefore,
building a DOP model out of these derivations will add very litte.

However, there is one thing a DOP model constructed on the basis of a
corpus of CG derivations gives us: a probability measure.

"The main motivation behind DOP is to integrate rule-based and
exemplar-based aspects of natural language" [@bod2008]. Certainly, the
promise being able to "take into account both the rule-based nature of
linguistic productivity and the exemplar-based nature of idiomatic
phrases, multi-word units and other idiosyncracies in language"
[@bod2008] is a seductive one, though there are certainly other
approaches to problems as idiom detection.

In previous work, Bod has "shown how discourse and semantics can be
incorporated into DOP if we have corpora containing discourse
structure and semantic annotations" [@bod2008;@bod1998]. He refers to
work on the OVIS corpus, which has semantics that are essentially
application-only.
Using such an approach would limit our CG to the (application-only) AB
fragment. We can analyse a lot of interesting phenomena with just the
AB fragment, as @kiselyov2014 have demonstrated how to elegantly
handle scope-taking in-situ. Additionally, various instances of
movement, usually taken care of by licensed structural rules, would
now be taken care of by the DOP framework.
However, for this to work, we *would* need a corpus annotated with
function-application structure---so, in essence, the OVIS
corpus---which is quite a lot to ask for an approach that aims to be
example-based. Furthermore, it's not entirely obvious how to
generalise such an approach to be *unsupervised*. Therefore, this
might be a viable option in the development of domain-specific
grammars.


---

## What does CG have to offer to DOP?

Semantics. There is one other interesting direction we could take with
DOP and CG, leaning more towards DOP. As outlined in the previous
section, if we could even conceive of a golden standard corpus of CG
derivations, we would have to be in the possesion of CG rules which
already perfectly generate the subset of the language used in the corpus.

However, let's assume that we don't have such a CG: could we start out
with a CG that drastically overgenerates, such as linear logic, and
use DOP to extract common subderivations such that in the end we get a
*derivational* DOP model?


#### What is the meaning of a subderivation metric?

For any subderivation metric to make sense, the CG will have to have a
rather strict normal-form. Depending on the properties of this
normal-form, we may have to move away from TSG and into TAG.


---
