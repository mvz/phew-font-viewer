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

## License

Copyright (c) 2012, 2015-2024 Matijs van Zuijlen

Phew is free software; you can redistribute it and/or modify it under the terms
of the GNU General Public License as published by the Free Software Foundation,
either version 3 of the License, or (at your option) any later version.

This application is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this application. If not, see <http://www.gnu.org/licenses/>.
