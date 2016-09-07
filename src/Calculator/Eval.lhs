> module Calculator.Eval where

Evaluating an expression is quite straightforward. Note that the result is a
'Maybe' because evaluation may fail with a division-by-zero error.

> import Calculator.Syntax
> import Control.Monad (guard)

> -- | Evaluates an expression.
> eval :: Expression -> Maybe Int
> eval (Integer i) = return i
> eval (Operation Addition lhs rhs) = do
>     lhsValue <- eval lhs
>     rhsValue <- eval rhs
>     return (lhsValue + rhsValue)
> eval (Operation Subtraction lhs rhs) = do
>     lhsValue <- eval lhs
>     rhsValue <- eval rhs
>     return (lhsValue - rhsValue)
> eval (Operation Multiplication lhs rhs) = do
>     lhsValue <- eval lhs
>     rhsValue <- eval rhs
>     return (lhsValue * rhsValue)
> eval (Operation Division lhs rhs) = do
>     lhsValue <- eval lhs
>     rhsValue <- eval rhs
>     guard (rhsValue /= 0)
>     return (lhsValue `quot` rhsValue)

> -- vim: set et sw=4 tw=78:
