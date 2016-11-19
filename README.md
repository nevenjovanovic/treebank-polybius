# Exploring Polybius's syntax with dependency trees

[Neven Jovanović](orcid.org/0000-0002-9119-399X), Department of Classical Philology, Faculty of Humanities and Social Sciences, 
University of Zagreb

![Greek vase detail](referat/2016-jovanovic-polybius/img/polybius-vase.jpg)

## Introduction

In Croatia there is relatively little research on Greek and Latin syntax. Views of classicists are traditionally shaped by school grammars such as, for the Greek, [Musić (1887)](http://www.bibsonomy.org/bibtex/2b2ead1c31826bd64b2ce72e2c81ebda1/filologanoga) and [Dukat (1983)](http://www.bibsonomy.org/bibtex/29b4c41cc65c361e7dc185270f2530ca4/filologanoga). Intended as reference books for young Croatian learners, to be supplemented by teacher's intervention and students' understanding of their first language, these works have effectively suppressed different approaches (attempted in e. g. [Macun 1853](http://www.bibsonomy.org/bibtex/20a208a5a02003fd2c84a928713e3960c/filologanoga)).  At the same time, both Musić and Dukat display unexpected blind spots, especially in syntax, where little attention has been given to the parts of the sentence (for example, adverbials are almost completely omitted).

On the other hand, contemporary global initiatives led by the [Perseus Project (Tufts University)](http://www.perseus.tufts.edu/hopper/) and the [Open Philology Project (University of Leipzig)](http://www.dh.uni-leipzig.de/wo/open-philology-project/) have brought all classicists a valuable resource for analyzing Greek and Latin syntax from a wholly different linguistic perspective, the one of computational analysis and dependency grammar. The [Ancient Greek and Latin Dependency Treebank (AGLDT)](https://perseusdl.github.io/treebank_data/) is an ongoing project of digital syntactical annotation of ancient texts according to a dependency grammar model following the [Prague Dependency Treebank](https://ufal.mff.cuni.cz/pdt2.0/) principles; in the AGLDT, each sentence “tree” consists of “nodes” connected hierarchically and marked by grammatical relation labels on the basis of their relationship with their governor nodes. Currently the AGLDT collection holds several thousand sentences annotated by over 200 people; it is published as Open Data, which means that anybody can not only use it, but also enhance it, or adapt it to any purpose.

To illustrate possibilities of the AGLDT, which at the moment happens to contain large parts of [Polybius's Histories](http://www.perseids.org/tools/arethusa/app/#/perseids?chunk=1&doc=27694), I will provide an overview of the structure of his sentences in the Book 1. Such an investigation fittingly complements previous interpretations of Polybius' language and linguistic choices, the topics for which, as has been stated recently ([Langslow 2012](http://www.bibsonomy.org/bibtex/283c6fd3b1984fa8969cb6079f8ce00d5/filologanoga)), “further research is needed”.


## How to use

This repository contains scripts needed to build a XML database of Polybius's Book 1 with treebank and morphology annotations, and to analyse the database.

### Prerequisites

Some working knowledge of command line, Git, XML, XQuery, and BaseX.

+ [Git](https://git-scm.com/), a free and open source distributed version control system
+ [BaseX](http://basex.org/), a (freely available) XML Database engine and XPath/XQuery 3.1 Processor 
### Building the database

Install the software as necessary (Git and BaseX).

Using Git, clone this repository.  From BaseX, run the [scripts/create-polybius-db.bxs](scripts/create-polybius-db.bxs). The script will pull the latest version of the Polybius treebank XML document from the [Ancient Greek and Latin Dependency Treebank (AGLDT)](https://perseusdl.github.io/treebank_data/) Github repository.

### Exploring the database

+ How many sentences and words are there in Polybius's Book 1?
+ Which functions are there in the sentences of Polybius's Book 1?
+ How many occurrences of each function is there?
+ What is the maximum and minimum number of children nodes contained by each function?
+ What do Polybius's predicates consist of?
+ What do Polybius's subjects consist of?

## Tests

The scripts for this analysis were coded using the [Test-Driven Development](https://en.wikipedia.org/wiki/Test-driven_development) process and the [BaseX Unit test module](http://docs.basex.org/wiki/Unit_Module). Test for the scripts are in the [scripts/testing](scripts/testing) directory. You may want to run the tests to see whether everything works as intended.

## Transforming flat sentence structure into nested trees

Dependencies that we want to analyse are easier to access if the original XML treebank is transformed from a "flat" structure (one sentence with many word nodes as children) into a "tree" (each governor-node word contains all word-nodes dependent on it). This transformation is achieved with the [scripts/transform-flat-into-tree.xq](scripts/transform-flat-into-tree.xq) script.

# License

[CC-BY](LICENSE.md)
