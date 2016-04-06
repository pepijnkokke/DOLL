---
title  : DogGram---Applications of Data-Oriented Parsing to Categorial Grammar
author : Pepijn Kokke
date   : April 6th, 2016
---

I'm honestly more of a cat person. Frankly, I don't like dogs at
all. There. I thought I should say that before we go any further into
this.

Initial observations:

  - There is a strong similarity between the notions of trees and
    label substitution in TSG on the one hand, and sequents and cut in
    CG on the other---however, the second notion contains additional
    derivational structure which is absent in the first;

  - There is a tendency in CG to *link* two relatiod sentences
    derivationally---e.g. the derivation of "The person who I saw
    walking down the street looked tired" may include the derivation
    of "I saw the person walking down the street". This ensure that
    the meanings of the two sentences are (compositionally) related.
    Such linking is clearly absent from DOP models of language, not
    only because, in its foundations, DOP models are only concerned
    with syntax, but also because, when a DOP model *is* enriched with
    syntax, the relation in meaning is entirely coincidental.


#### What does DOP have to offer to CG?

The DOP model proposes "to directly use corpus fragments as a grammar"
[@bod2008]. Here, we immediately run into the problem that there *are*
no large corpuses available for CGs---since CG focuses on
rule-crafting rather than corpus-building---and there are definitely
no *hand-annotated* corpuses or treebanks. The only CG formalism which
has fairly large corpuses available is CCG, and this is the only CG
formalism which *does not admit cut*.

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
