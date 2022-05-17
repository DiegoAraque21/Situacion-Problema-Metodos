# Actividad Integradora: Resaltador de Sintaxis
#
# Diego Araque
# 2022 - 05 - 20

defmodule Evidencia do
  def parseJSON(in_filename, out_filename) do
    html =
      in_filename
      |> File.stream!()
      |> Enum.map(&readLine/1)
  end

  def readLine(line, htmlLine) do
    if line = "" do

    else if ()

    end
  end

  def getPuntuation() do
    Regex.run()
  end

  def getObjectKey() do
    Regex.run()
  end

  def getString() do
    Regex.run()
  end

  def getNum() do
    Regex.run()
  end

  def getSpace() do
    Regex.run()
  end

  def getArray() do
    Regex.run()
  end
end
