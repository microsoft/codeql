private import iac

query predicate iacComments(Comment c) { any() }

query predicate getText(Comment c, string text) { text = c.getText() }

query predicate hasHashDelimiter(Comment c) { c.hasHashDelimiter() }
