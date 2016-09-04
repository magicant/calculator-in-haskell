> module Calculator.Parsing where

Our parser is made using the "parsec" parser combinator library.

> import Calculator.Syntax
> import Text.Parsec

An integer is a sequence of one or more digits.

> -- | Parses an integer.
> --
> -- >>> parse integer "" "123+345"
> -- Right 123
> -- >>> parse integer "" "+345"
> -- Left (line 1, column 1):
> -- unexpected "+"
> -- expecting digit
> integer :: Parsec String () Expression
> integer = fmap (Integer . read) (many1 digit)
