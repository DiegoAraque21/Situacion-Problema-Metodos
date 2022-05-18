# Actividad Integradora: Resaltador de Sintaxis
#
# Diego Araque and Francisco Salcedo
# 2022 - 05 - 20

defmodule Evidencia do
  def parseJSON(in_filename, out_filename) do
    html =
      in_filename
      |> File.stream!()
      |> Enum.map(&readLine/1)
  end

  def readLine(line), do: do_readLine(line, "")
  defp do_readLine("", htmlLine), do: htmlLine
  defp do_readLine(line, htmlLine) do
    tuple = getObjectKey(line, htmlLine)
    do_readLine(elem(tuple, 0), elem(tuple, 1))
  end
  defp do_readLine(line, htmlLine) do
    tuple = getString(line, htmlLine)
    do_readLine(elem(tuple, 0), elem(tuple, 1))
  end
  defp do_readLine(line, htmlLine) do
    tuple = getNum(line, htmlLine)
    do_readLine(elem(tuple, 0), elem(tuple, 1))
  end
  defp do_readLine(line, htmlLine) do
    tuple = getBool(line, htmlLine)
    do_readLine(elem(tuple, 0), elem(tuple, 1))
  end
  defp do_readLine(line, htmlLine) do
    tuple = getWhitespaces(line, htmlLine)
    do_readLine(elem(tuple, 0), elem(tuple, 1))
  end

  def getPuntuation() do
    Regex.replace()
  end

  def getObjectKey(line, htmlLine) do
    lineTemp = line
    [completeLine, objectKey, puntuation] = Regex.run(~r/^(".*?")(:)/, line)
    line = elem(String.split_at(lineTemp, String.length(completeLine)),1)
    htmlLine = "<span class=\"objectKey\">#{objectKey}</span><span class=\"puntuation\">#{puntuation}</span>"
  end

  def getString(line, htmlLine) do
    Regex.run()
  end

  def getNum(line, htmlLine) do
    Regex.run()
  end

  def getBool(line, htmlLine) do
    Regex.run()
  end

  def getWhitespaces(line, htmlLine) do
    Regex.run()
  end

  def getNull(line, htmlLine) do
    Regex.run()
  end
end
