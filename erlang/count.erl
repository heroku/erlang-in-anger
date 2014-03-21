f(Count).
Count = fun(AttrName, NumProcs) ->
 Attrs = fun(Name) ->
     Attrs = [Name, current_function, initial_call],
     [{Pid, Attr, {Curr, Init}}
      || Pid <- processes() -- [self()],
         [{_,Attr},{_,Curr},{_,Init}] <- [process_info(Pid,Attrs)]]
 end,

 lists:sublist(lists:usort(
        fun({_,A,_},{_,B,_}) -> A > B end,
        Attrs(AttrName)
    ), NumProcs)
end.
