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

Parsing the multiplication and division operators is straightforward.

> -- | Parses the '*' and '/' operators.
> --
> -- >>> parse mulDiv "" "*/"
> -- Right *
> -- >>> parse mulDiv "" "/*"
> -- Right /
> -- >>> parse mulDiv "" "+-"
> -- Left (line 1, column 1):
> -- unexpected "+"
> -- expecting "*" or "/"
> mulDiv :: Parsec String () Operator
> mulDiv = (char '*' >> return Multiplication) <|>
>          (char '/' >> return Division)

Parsing the addition and subtraction operators is the same.

> -- | Parses the '+' and '-' operators.
> --
> -- >>> parse addSub "" "+-"
> -- Right +
> -- >>> parse addSub "" "-+"
> -- Right -
> -- >>> parse addSub "" "*/"
> -- Left (line 1, column 1):
> -- unexpected "*"
> -- expecting "+" or "-"
> addSub :: Parsec String () Operator
> addSub = (char '+' >> return Addition) <|> (char '-' >> return Subtraction)

> -- vim: set et sw=4 tw=78:
