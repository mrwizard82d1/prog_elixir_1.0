defmodule Chain do
  @moduledoc false

  def counter(next_pid) do
    receive do
      n -> send next_pid, n + 1
    end
  end

  def create_processes(n) do
    code_to_run = fn(_, send_to) ->
      spawn(Chain, :counter, [send_to])
    end

    # Creates a connected chain of processes: each process created is connected to the created process immediately
    # preceeding it (in order of creation). That is, the first process, the shell invokes `reduce` passing it its PID
    # and the function, `code_to_run`. The function `code_to_run` returns the PID of the *newly created* process. In
    # the next iteration of reduce, the second argument, the accumulator, is the PID of that newly created process.
    last_counter = Enum.reduce(1..n, self(), code_to_run)

    # Start by sending the last counter process a zero (0). This process will then send a message to its predecessor
    # containing the *incremented* count. This sending process continues until the value `n` is sent to the the
    # initiating process (the shell).
    send(last_counter, 0)

    # The initiating process (the shell) awaits the final answer.
    receive do
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    :timer.tc(Chain, :create_processes, [n])
    |> IO.inspect
  end
end
