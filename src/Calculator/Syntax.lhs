> module Calculator.Syntax where

The syntax of this simple calculator just supports integer literals and the
four basic arithmetic operations. We first define the type of the operations.

> data Operator = Addition | Subtraction | Multiplication | Division

It is obvious how to show the operators.

> instance Show Operator where
>     show Addition       = "+"
>     show Subtraction    = "-"
>     show Multiplication = "*"
>     show Division       = "/"

The syntax of the whole expression is defined on the basis of the Operator.

> data Expression = Integer Int | Operation Operator Expression Expression

When showing an expression, we parenthesize every operation. That may result
in redundant parentheses, but the result is always correct.

> instance Show Expression where
>     show (Integer i)            = show i
>     show (Operation op lhs rhs) =
>         "(" ++ show lhs ++ " " ++ show op ++ " " ++ show rhs ++ ")"

> -- vim: set et sw=4 tw=78:
