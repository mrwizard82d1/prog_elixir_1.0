defmodule TwoEchoes do
  @moduledoc false

  def fred_echo do
    receive do
      {sender, :fred} ->
        send sender, :fred
    end
    fred_echo()
  end

  def betty_echo do
    receive do
      {sender, :betty} ->
        send sender, :betty
    end
    betty_echo()
  end

  def send_to(pid, msg) do
    send pid, msg
  end

  def make_send_msg_to_each(pid1, pid2) do
    fn([msg1, msg2]) ->
      send pid1, {self(), msg1}
      send pid2, {self(), msg2}
      [msg1, msg2]
    end
  end

  defp await(0, accum), do: accum
  defp await(n, accum) do
    new_accum = receive do
      msg -> [msg | accum]
    end
    await(n - 1, new_accum)
  end

  def await(n) do
    Enum.reverse(await(n, []))
  end

  def partial_sequence(seq, fun) do
    case Enum.find_index(seq, fun) do
      nil ->
        "No betty found."
      n ->
        ["Betty found at #{n}.",
          seq
          |> Enum.drop(n - 2)
          |> Enum.take(5)]
    end
  end
end

fred_pid = spawn(TwoEchoes, :fred_echo, [])
betty_pid = spawn(TwoEchoes, :betty_echo, [])

send_msg_to_each = TwoEchoes.make_send_msg_to_each(fred_pid, betty_pid)

msgs = [:fred, :betty]
# count = 20 # No 'betty' found at 20
count = 40 # Betty found randomly in 40
Stream.cycle([msgs])
|> Stream.map(send_msg_to_each)
|> Enum.take(count)
# |> IO.inspect

chunk = TwoEchoes.await(length(msgs) * count)
|> Enum.take(count)

IO.inspect TwoEchoes.partial_sequence(chunk, &(&1 == :betty))
