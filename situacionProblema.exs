# Actividad Integradora: Resaltador de Sintaxis
#
# Diego Araque and Francisco Salcedo
# 2022 - 05 - 20

defmodule Evidencia do

  # If the parseJsonConcurrently function is called with no argument
  # all of the files in the JSON folder will be parsed
  def getJsonFolder() do
    ["JSON/example_0.json", "JSON/example_1.json", "JSON/example_2.json",
    "JSON/example_3.json","JSON/example_4.json","JSON/example_5.json",
    "JSON/example_6.json", "JSON/example_7.json","JSON/example_8.json",
    "JSON/example_9.json", "JSON/example_10.json", "JSON/example_11.json",
    "JSON/example_12.json"]
  end

  # Concurrently parse all the files in the JSON folder or the ones given by the user
  def parseJsonConcurrently(files \\ getJsonFolder()) do
    files
    |> Enum.map(&Task.start(fn ->
      parseJSON(&1, String.replace(String.replace(&1,".json",".html"),"JSON/","HTML/")) end))
  end

  # Function that parses the .json file
  def parseJSON(in_filename, out_filename) do
    html =
      in_filename
      |> File.stream!()
      |> Enum.map(&readLine/1)
      |> Enum.join("")
    html = """
    <!DOCTYPE html>
    <html>
      <head>
      <title>JSON Code</title>
      <link rel="stylesheet" href="token_colors.css" />
      </head>
      <body>
        <h1>#{NaiveDateTime.local_now}</h1>
        <pre>
    #{html}
        </pre>
      </body>
    </html>
    """
    File.write(out_filename, html)
  end

  # Reads each line and parses it until there's no more
  # chracters in the line
  def readLine(line), do: do_readLine(line, "")
  defp do_readLine("", htmlLine), do: htmlLine
  defp do_readLine(line, ""), do: do_readWhitespaces(line, "")
  defp do_readLine(line, htmlLine), do: do_readWhitespaces(line, htmlLine)
  defp do_readWhitespaces(line, htmlLine) do
    if !Regex.run(~r/^\s+/, line) do
      do_readObjectKey(line,htmlLine)
    else
      tuple = getWhitespaces(line, htmlLine)
      do_readLine(elem(tuple, 0), elem(tuple, 1))
    end
  end
  defp do_readObjectKey(line, htmlLine) do
    if !Regex.run(~r/^"[-\w:]+"(?=:)/, line) do
      do_readString(line,htmlLine)
    else
      tuple = getObjectKey(line, htmlLine)
      do_readLine(elem(tuple, 0), elem(tuple, 1))
    end
  end
  defp do_readString(line, htmlLine) do
    if !Regex.run(~r/^".*?"(?![:])/, line) do
      do_readPuntuation(line, htmlLine)
    else
      tuple = getString(line, htmlLine)
      do_readLine(elem(tuple, 0), elem(tuple, 1))
    end
  end
  defp do_readPuntuation(line, htmlLine) do
    if !Regex.run(~r/^[{}\[\]:,]/, line) do
      do_readNum(line, htmlLine)
    else
      tuple = getPuntuation(line, htmlLine)
      do_readLine(elem(tuple, 0), elem(tuple, 1))
    end
  end
  defp do_readNum(line, htmlLine) do
    if !Regex.run(~r/^[-+]?\d*\.?\d+[eE]?[-+]?\d*/,line) do
      do_readBool(line,htmlLine)
    else
      tuple = getNum(line, htmlLine)
      do_readLine(elem(tuple, 0), elem(tuple, 1))
    end
  end
  defp do_readBool(line, htmlLine) do
    if !Regex.run(~r/^true|^false/,line) do
      do_readNull(line,htmlLine)
    else
      tuple = getBool(line, htmlLine)
      do_readLine(elem(tuple, 0), elem(tuple, 1))
    end
  end
  defp do_readNull(line, htmlLine) do
    tuple = getNull(line, htmlLine)
    do_readLine(elem(tuple, 0), elem(tuple, 1))
  end

  # Helper Functions that identify each valid section
  # through regular expressions and return a tupple
  # that it's used in our private functions
  def getPuntuation(line, htmlLine) do
    lineTemp = line
    [puntuation] = Regex.run(~r/^[{}\[\]:,]/, line)
    line = elem(String.split_at(lineTemp, String.length(puntuation)),1)
    tags = "<span class=\"punctuation\">#{puntuation}</span>"
    htmlLine = "#{htmlLine}#{tags}"
    {line, htmlLine}
  end

  def getObjectKey(line, htmlLine) do
    lineTemp = line
    [completeLine] = Regex.run(~r/^"[-\w:]+"(?=:)/, line)
    line = elem(String.split_at(lineTemp, String.length(completeLine)),1)
    tags = "<span class=\"object-key\">#{completeLine}</span>"
    htmlLine = "#{htmlLine}#{tags}"
    {line, htmlLine}
  end

  def getString(line, htmlLine) do
    lineTemp = line
    [string] = Regex.run(~r/^".*?"(?![:])/, line)
    line = elem(String.split_at(lineTemp, String.length(string)),1)
    tags = "<span class=\"string\">#{string}</span>"
    htmlLine = "#{htmlLine}#{tags}"
    {line, htmlLine}
  end

  def getNum(line, htmlLine) do
    lineTemp = line
    [number] = Regex.run(~r/^[-+]?\d*\.?\d+[eE]?[-+]?\d*/,line)
    line = elem(String.split_at(lineTemp, String.length(number)),1)
    tags = "<span class=\"number\">#{number}</span>"
    htmlLine = "#{htmlLine}#{tags}"
    {line, htmlLine}
  end

  def getBool(line, htmlLine) do
    lineTemp = line
    [boolean] = Regex.run(~r/^true|^false/,line)
    line = elem(String.split_at(lineTemp, String.length(boolean)),1)
    tags = "<span class=\"reserved-word\">#{boolean}</span>"
    htmlLine = "#{htmlLine}#{tags}"
    {line, htmlLine}
  end

  def getNull(line, htmlLine) do
    lineTemp = line
    [nullVal] = Regex.run(~r/^null/,line)
    line = elem(String.split_at(lineTemp, String.length(nullVal)),1)
    tags = "<span class=\"reserved-word\">#{nullVal}</span>"
    htmlLine = "#{htmlLine}#{tags}"
    {line, htmlLine}
  end

  def getWhitespaces(line, htmlLine) do
    lineTemp = line
    [whitespaces] = Regex.run(~r/^\s+/, line)
    line = elem(String.split_at(lineTemp, String.length(whitespaces)),1)
    htmlLine = "#{htmlLine}#{whitespaces}"
    {line, htmlLine}
  end

  # This function lets us calculate the time the function lasts until
  # everything is completed
  def calculateTime(function) do
    function
    |> :timer.tc
    |> elem(0)
    |> Kernel./(1_000_000)
  end

end
