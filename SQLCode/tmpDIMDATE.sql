with DateCTE as (
    select 
        cast('2009-05-04' as date) as fulldate
    union all
    select 
        dateadd(day, 1, fulldate)
    from 
        datecte
    where 
        dateadd(day, 1, fulldate) <= getdate()
)
select 
    convert(int, format(fulldate, 'yyyyMMdd')) as DateKey, 
    FullDate,                                            
    year(fulldate) as Year,                              
    datepart(quarter, fulldate) as Quarter,              
    concat('Q', datepart(quarter, fulldate)) as QuarterName,
    month(fulldate) as Month,                            
    datename(month, fulldate) as MonthName,              
    datepart(week, fulldate) as WeekOfYear,                  
    day(fulldate) as DayOfMonth,                              
    datepart(weekday, fulldate) as DayOfWeek,           
    datename(weekday, fulldate) as DayName,             
    case 
        when datepart(weekday, fulldate) in (1, 7) then 1 
        else 0 
    end as IsWeekend,                                    
    datefromparts(year(fulldate), month(fulldate), 1) as FirstDayOfMonth,
    eomonth(fulldate) as LastDayOfMonth 
into tmpDIMDATE
from 
    DateCTE
option (maxrecursion 0); 

