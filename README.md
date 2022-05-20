# Syntax Highlighter

## How to run our program

#### Start it from the Terminal

```
iex situacionProblema.exs
```

#### Read the JSON file and create de HTML file

```
Evidencia.parseJSON("path of the json file","path of the html file")
```

## JSON tokens

- Object-Keys: They are strings that come before a colon (:). This token makes it easy to acces values in our JSON.
  - Example -> "movie": 14 -> "movie" is the object key
- String: Its a group of characters that's inside quotaion marks
  - Example -> "movie:": "The Avengers" -> "The Avengers is the string"
- Number: It's a integer, exponential number and float
  - Example -> 340, 340.65, 340.4E+5 is a number
- Puntuation: It takes into consideration colons(:), comas(,), curly braces({}), brackets([])
  - Colons: Used after declaring an object key
  - Comas: Used to separate object keys or values inside of an array
  - Curly Braces: Used to initiate the JSON file and to create objects
  - Brackets: Used to create arrays

Bonus:

- Whitesapces: It is not a token, but our program reads every whitespace so the result in the HTML is formatted equally as the one in the JSON file.

## Regular Expressions

- Object Keys: ^(".\*?")(:) -> It detects every set of characters inside of wuotation marks and it has to end with a colo. Also It only matches if the beginning of the line matches this conditions.
- String: ^".\*?" -> It only matches the beginning of the line with any set of characters inside wuotation marks.
- Numbers: ^[-+]?\d*\.?\d+[eE]?[-+]?\d* -> It only matches when the beginning of the line has any of the numbers described in the JSON tokens section.
- Whitespaces: ^\s+ -> It only matches in the beginning of the line for one or more spaces.
- Puntuation: ^[{}\[\]:,] -> It matches in the beginning of a line where one of this characters ({}[]:,) is found
- Bool: ^true|^false -> It searchs for false or true in the beginning of the line
- Null: ^null -> It searchs for null in the beginning of the line.

## Reflexion

## Complejidad del Algoritmo
