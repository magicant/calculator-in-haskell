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

Using the 'mulDiv' parser, we can parse multiplication/division expressions.

> -- | Parses an expression made up of two sub-expressions joined by a
> -- multiplication or division operator.
> --
> -- >>> parse mulDivExp "" "12*34/56+78"
> -- Right ((12 * 34) / 56)
> -- >>> parse mulDivExp "" "98/76*54-32"
> -- Right ((98 / 76) * 54)
> --
> -- Missing a left-hand-side operand is an error:
> --
> -- >>> parse mulDivExp "" "*34/56+78"
> -- Left (line 1, column 1):
> -- unexpected "*"
> -- expecting digit
> -- >>> parse mulDivExp "" "/76*54-32"
> -- Left (line 1, column 1):
> -- unexpected "/"
> -- expecting digit
> --
> -- Missing a right-hand-side operand is also an error:
> --
> -- >>> parse mulDivExp "" "12*/56"
> -- Left (line 1, column 4):
> -- unexpected "/"
> -- expecting digit
> mulDivExp :: Parsec String () Expression
> mulDivExp = chainl1 integer (fmap Operation mulDiv)

Parsing addition/subtraction expression is the same.

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
>
> -- | Parses an expression made up of two sub-expressions joined by an
> -- addition or subtraction operator.
> --
> -- >>> parse addSubExp "" "12+34-56"
> -- Right ((12 + 34) - 56)
> -- >>> parse addSubExp "" "89-67+45"
> -- Right ((89 - 67) + 45)
> --
> -- The left-hand-side is a multiplication/division expression.
> --
> -- >>> parse addSubExp "" "12*34+56"
> -- Right ((12 * 34) + 56)
> --
> -- The right-hand-side is the same.
> --
> -- >>> parse addSubExp "" "98-76/54"
> -- Right (98 - (76 / 54))
> --
> -- Missing a left- or right-hand-side operand is an error:
> --
> -- >>> parse addSubExp "" "+1"
> -- Left (line 1, column 1):
> -- unexpected "+"
> -- expecting digit
> -- >>> parse addSubExp "" "1+-2"
> -- Left (line 1, column 3):
> -- unexpected "-"
> -- expecting digit
> addSubExp :: Parsec String () Expression
> addSubExp = chainl1 mulDivExp (fmap Operation addSub)

> -- vim: set et sw=4 tw=78:
