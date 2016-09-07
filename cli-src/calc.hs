import Calculator.Eval
import Calculator.Parsing
import Calculator.Syntax

main :: IO ()
main =
   do line <- getLine
      case parseExp line of
         Left error -> print error
         Right exp ->
            case eval exp of
               Nothing -> putStrLn "arithmetic error"
               Just i -> print i

-- vim: set et sw=3 tw=78:
