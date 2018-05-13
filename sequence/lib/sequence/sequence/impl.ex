defmodule Sequence.Impl do
  @moduledoc false

  def next(number), do: number + 1

  def increment(number, delta), do: number + delta
end
