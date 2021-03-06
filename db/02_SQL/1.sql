with t(id,gen, rest) as
   (
    select id, null, genres from movies where id = 81132
    union all
    select id, case
                 when instr(rest,'|') = 0 then rest
                 else substr(rest,1,instr(rest,'|')-1)
               end,
               case
                 when instr(rest,'|')=0 then null
                 else substr(rest,instr(rest,'|')+1)
               end
    from t
    where rest is not null
   )
select * from t;


with t(id,gen, rest) as
   (select id, null, genres from movies
    union all
    select id, case
                 when instr(rest,'|') = 0 then rest
                 else substr(rest,1,instr(rest,'|')-1)
               end,
               case
                 when instr(rest,'|')=0 then null
                 else substr(rest,instr(rest,'|')+1)
               end
    from t
    where rest is not null
    order by id)
 select * from t;




with t(id,gen, rest) as
   (
    select id, null, genres from movies
    union all
    select id, case
                 when instr(rest,'|') = 0 then rest
                 else substr(rest,1,instr(rest,'|')-1)
               end,
               case
                 when instr(rest,'|')=0 then null
                 else substr(rest,instr(rest,'|')+1)
               end
    from t
    where rest is not null
    order by id
   )
 select gen as 'Genres', count(id) as 'Number' from t
 where gen is not null
 group by gen;
