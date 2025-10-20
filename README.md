# SimpleJSON

A lightweight and elegant JSON processing library written in Haskell, featuring a sophisticated pretty-printing system with multiple rendering modes and customizable formatting options.

---

## ✨ Features

- **JSON Data Structure**: Type-safe representation of JSON values with pattern matching support
- **Safe Getter Functions**: Extract values from JSON with `Maybe` type safety
- **Advanced Pretty-Printing System**:
  - `compact` - Minified single-line output
  - `pretty` - Width-aware intelligent formatting
  - `oneLine` - Clean single-line representation
  - `prettyIndent` - Customizable indentation levels
- **Escape Sequence Handling**: Proper support for special characters, Unicode, and astral planes
- **Modular Design**: Cleanly separated modules for JSON, pretty-printing, and rendering

---

## 📋 Project Structure
```
SimpleJSON/
├── SimpleJSON.hs      # Core JSON data types and getter functions
├── Prettify.hs        # Pretty-printing engine and Doc type
├── PrettyJSON.hs      # JSON to Doc rendering
└── Main.hs            # Comprehensive test suite
```

---

## 💡 Usage Examples

### Creating JSON Values
```haskell
import SimpleJSON
import PrettyJSON
import Prettify

-- Simple values
let str = JString "Hello, World!"
let num = JNumber 42.5
let bool = JBool True
let null_val = JNull

-- Arrays
let arr = JArray [JNumber 1, JNumber 2, JNumber 3]

-- Objects
let obj = JObject 
    [ ("name", JString "Alice")
    , ("age", JNumber 30)
    , ("active", JBool True)
    ]
```

### Extracting Values
```haskell
-- Safe extraction with Maybe
getString (JString "test")     -- Just "test"
getInt (JNumber 42.5)          -- Just 42
getDouble (JNumber 42.5)       -- Just 42.5
getBool (JBool True)           -- Just True
getArray (JArray [...])        -- Just [...]
getObject (JObject [...])      -- Just [...]
isNull JNull                   -- True
```

### Rendering JSON
```haskell
let json = JObject [("foo", JNumber 1), ("bar", JBool False)]

-- Compact (minified)
compact (renderJValue json)
-- Output: {"foo": 1, "bar": false}

-- Pretty (intelligent line breaking)
pretty 80 (renderJValue json)

-- One-liner
oneLine (renderJValue json)

-- Custom indentation (4 spaces)
prettyIndent 80 4 (renderJValue json)
```

---

## 📚 API Reference

### SimpleJSON.hs

#### Data Type
```haskell
data JValue = JString String
            | JNumber Double
            | JBool Bool
            | JNull
            | JObject [(String, JValue)]
            | JArray [JValue]
```

#### Getter Functions
- `getString :: JValue -> Maybe String` - Extract string value
- `getInt :: JValue -> Maybe Int` - Extract integer (truncated from Double)
- `getDouble :: JValue -> Maybe Double` - Extract floating-point value
- `getBool :: JValue -> Maybe Bool` - Extract boolean value
- `getObject :: JValue -> Maybe [(String, JValue)]` - Extract object pairs
- `getArray :: JValue -> Maybe [JValue]` - Extract array elements
- `isNull :: JValue -> Bool` - Check if value is null

### Prettify.hs

#### Rendering Functions
- `compact :: Doc -> String` - Single-line minified output
- `pretty :: Int -> Doc -> String` - Width-aware intelligent formatting
- `oneLine :: Doc -> String` - Clean single-line rendering
- `prettyIndent :: Int -> Int -> Doc -> String` - Custom indentation support

#### Utility Functions
- `empty :: Doc` - Empty document
- `char :: Char -> Doc` - Single character
- `text :: String -> Doc` - String content
- `line :: Doc` - Line break
- `hcat :: [Doc] -> Doc` - Horizontal concatenation
- `fsep :: [Doc] -> Doc` - Paragraph-like separation

---

## 🏗️ Architecture

### SimpleJSON Module
Defines the core JSON data structure and safe extraction functions using the `Maybe` monad for error handling.

### Prettify Module
Implements a document rendering system based on the `Doc` type, supporting multiple formatting strategies:
- **Doc Type**: Represents renderable documents with alternatives
- **Union**: Allows choosing between different rendering styles
- **Flatten**: Converts line breaks to spaces for compact output

### PrettyJSON Module
Bridges JSON and Prettify by implementing `renderJValue` to convert JSON values into prettily-formatted documents.

---

## 🎯 Key Highlights

✅ **Type Safety**: All JSON extraction uses `Maybe` to handle invalid cases  
✅ **Flexible Formatting**: Multiple rendering modes for different use cases  
✅ **Unicode Support**: Proper handling of special characters and astral planes  
✅ **Modular Design**: Clear separation of concerns across three modules  
✅ **Production Ready**: Clean code following Haskell best practices


## 👤 Author

**Gabriel Thiago Tavares Ribeiro -->Gabriel-T-P<--**

Repository: https://github.com/Gabriel-T-P/SimpleJSON

---
