# Phew

Phew will be a font viewer.

## Goals

The primary use case that prompted the development of this program was
needing to figure out which of the installed fonts provided characters
for writing Japanese.

As a user, in order to determine which fonts to keep, I want to know
which fonts provide characters for a particular script, and compare them
using a sample text.

Many fonts provide characters for the latin script in addition to their
primary focus on some other scripts. For example, many CJK fonts also
provide latin letters, often of a lesser quality than fonts designed
specifically for latin. Therefore, I want to be able to exclude such
fonts when comparing latin fonts.

As a user, in order to determine which font to use for a particular
document, I want to know which fonts cover the characters I want to use,
and compare them. I should be able to manipulate the initial selection
by adding and removing fonts.

Tentatively, there would be a filtering system, and we would have two
lists of fonts that satisfy the filters, namely those that have been
selected (the default state), and those that have been rejected.
