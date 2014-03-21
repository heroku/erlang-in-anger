f(Window).
Window = fun(AttrName, Time, NumProcs) ->
 Attrs = fun(Name) ->
     Attrs = [Name, current_function, initial_call],
     [{Pid, {Attr, Curr, Init}}
      || Pid <- processes() -- [self()],
         [{_,Attr},{_,Curr},{_,Init}] <- [process_info(Pid,Attrs)]]
 end,
 F = fun() -> Attrs(AttrName) end,

 Fetch = fun(T) -> A = F(), timer:sleep(T), B = F(), {A,B} end,

 Build = fun({A,B}) ->
     D = dict:from_list(A),
     lists:foldl(fun({Pid,{Red,Cur,Init}}, Dict) ->
         dict:update(Pid, fun({RedOld,_,_}) ->
              {Red-RedOld,Cur,Init}
         end, {Red,Cur,Init}, Dict)
     end, D, B)
 end,

 lists:sublist(lists:usort(
     fun({_,{X,A1,A2}}, {_,{Y,B1,B2}}) -> X > Y end,
     dict:to_list(Build(Fetch(Time)))
 ),NumProcs)
end.

% Window(reductions, Time, NumProcs).
