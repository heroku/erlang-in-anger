f(Init), f(Loop), f(Stats), f(ShowStats),
Init = fun(Delay) ->
  Ref = erlang:start_timer(Delay, self(), '#delay'),
  {{input,In},{output,Out}} = erlang:statistics(io),
  PrevGC = erlang:statistics(garbage_collection),
  {{Delay,Ref}, {In,Out}, PrevGC}
end,
Loop = fun(Self,F,N,{{D,R},{OldIn,OldOut},{OldGCs,OldWords,_}}) ->
  receive
    {timeout,R,'#delay'} ->
        %% Gauges
        ProcC = erlang:system_info(process_count),
        RunQ = erlang:statistics(run_queue),
        {_,LogQ} = process_info(whereis(error_logger),
                                message_queue_len),
        %% Mem (Gauges)
        Mem = erlang:memory(),
        Tot = proplists:get_value(total, Mem),
        ProcM = proplists:get_value(processes_used,Mem),
        Atom = proplists:get_value(atom_used,Mem),
        Bin = proplists:get_value(binary, Mem),
        Ets = proplists:get_value(ets, Mem),
        %% Incremental
        {{input,In},{output,Out}} = erlang:statistics(io),
        GC={GCs,Words,_} = erlang:statistics(garbage_collection),
        BytesIn = In-OldIn,
        BytesOut = Out-OldOut,
        GCCount = GCs-OldGCs,
        GCWords = Words-OldWords,
        {_, Reds} = erlang:statistics(reductions),
        [F({[{process_count,ProcC}, {run_queue,RunQ},
             {error_logger_queue_len,LogQ}, {memory_total,Tot},
             {memory_procs,ProcM}, {memory_atoms,Atom},
             {memory_bin,Bin}, {memory_ets,Ets}],
            [{bytes_in,BytesIn}, {bytes_out,BytesOut},
             {gc_count,GCCount}, {gc_words_reclaimed,GCWords},
             {reductions,Reds}]})
         | if N-1 =< 0 -> [];
              N-1 > 0 ->
                Ref = erlang:start_timer(D, self(), '#delay'),
                Self(Self,F,N-1,{{D,Ref},{In,Out},GC})
           end]
  end
end,
Stats = fun(F,N,Delay) -> Loop(Loop,F,N,Init(Delay)) end,
ShowStats = fun(N,D) ->
              Stats(fun(X) -> io:format("~p~n",[X]) end,N,D),
              ok
            end.
%% ShowStats(NumberOfIterations, DelayBetweenSamples)
%% Stats(fun(X) -> X end, Number, Delay) to return them.
