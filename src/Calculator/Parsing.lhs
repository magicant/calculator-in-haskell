> module Calculator.Parsing where

Our parser is made using the "parsec" parser combinator library.

> import Calculator.Syntax
> import Text.Parsec

An integer is a sequence of one or more digits.

> integer :: Parsec String () Expression
> integer = fmap (Integer . read) (many1 digit)
