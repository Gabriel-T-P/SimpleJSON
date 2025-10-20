module Main (main) where

import SimpleJSON
import PrettyJSON
import Prettify
import Prelude hiding ((<>))

main :: IO ()
main = do
  putStrLn "=== Testes SimpleJSON ==="
  testSimpleJSON
  
  putStrLn "\n=== Testes PrettyJSON ==="
  testPrettyJSON
  
  putStrLn "\n=== Testes de Renderização ==="
  testRenderization

testSimpleJSON :: IO ()
testSimpleJSON = do
  putStrLn "\n--- getString ---"
  let str = JString "Hello, World!"
  print (getString str)  -- Just "Hello, World!"
  print (getString (JNumber 42))  -- Nothing
  
  putStrLn "\n--- getInt ---"
  let num = JNumber 42.5
  print (getInt num)  -- Just 42 (truncated)
  print (getInt (JString "not a number"))  -- Nothing
  
  putStrLn "\n--- getDouble ---"
  print (getDouble num)  -- Just 42.5
  print (getDouble (JBool True))  -- Nothing
  
  putStrLn "\n--- getBool ---"
  let bool = JBool True
  print (getBool bool)  -- Just True
  print (getBool (JNumber 1))  -- Nothing
  
  putStrLn "\n--- getObject ---"
  let obj = JObject [("name", JString "Alice"), ("age", JNumber 30)]
  print (getObject obj)
  -- Just [("name",JString "Alice"),("age",JNumber 30)]
  
  putStrLn "\n--- getArray ---"
  let arr = JArray [JNumber 1, JNumber 2, JNumber 3]
  print (getArray arr)  -- Just [JNumber 1.0, JNumber 2.0, JNumber 3.0]
  
  putStrLn "\n--- isNull ---"
  print (isNull JNull)  -- True
  print (isNull (JNumber 0))  -- False

testPrettyJSON :: IO ()
testPrettyJSON = do
  putStrLn "\n--- Tipos Primitivos ---"
  putStrLn $ "Boolean True:  " ++ compact (renderJValue (JBool True))
  putStrLn $ "Boolean False: " ++ compact (renderJValue (JBool False))
  putStrLn $ "Null:          " ++ compact (renderJValue JNull)
  putStrLn $ "Number:        " ++ compact (renderJValue (JNumber 42.5))
  putStrLn $ "String:        " ++ compact (renderJValue (JString "Hello"))
  
  putStrLn "\n--- Array ---"
  let arr = JArray [JNumber 1, JNumber 2, JNumber 3]
  putStrLn $ "Array: " ++ compact (renderJValue arr)
  
  putStrLn "\n--- Objeto Simples ---"
  let obj = JObject [("foo", JNumber 1), ("bar", JBool False)]
  putStrLn $ compact (renderJValue obj)
  
  putStrLn "\n--- Objeto Complexo ---"
  let complex = JObject
        [ ("name", JString "Alice")
        , ("age", JNumber 30)
        , ("active", JBool True)
        , ("scores", JArray [JNumber 95, JNumber 87, JNumber 92])
        ]
  putStrLn $ compact (renderJValue complex)

testRenderization :: IO ()
testRenderization = do
  let complexJSON = JObject
        [ ("usuario", JObject
            [ ("nome", JString "João Silva")
            , ("idade", JNumber 25)
            , ("emails", JArray
                [ JString "joao@example.com"
                , JString "silva@example.com"
                ])
            ])
        , ("ativo", JBool True)
        , ("saldo", JNumber 1500.50)
        ]
  
  putStrLn "\n--- Renderização Compacta ---"
  putStrLn $ compact (renderJValue complexJSON)
  
  putStrLn "\n--- Renderização com Pretty (80 caracteres) ---"
  putStrLn $ pretty 80 (renderJValue complexJSON)
  
  putStrLn "\n--- Renderização com Pretty (40 caracteres) ---"
  putStrLn $ pretty 40 (renderJValue complexJSON)
  
  putStrLn "\n--- Strings com Caracteres Especiais ---"
  let special = JObject
        [ ("texto", JString "Linha 1\nLinha 2\tTabulação")
        , ("caminho", JString "C:\\Users\\teste")
        ]
  putStrLn $ compact (renderJValue special)