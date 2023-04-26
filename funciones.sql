use grand_slam;

SET GLOBAL log_bin_trust_function_creators = 1;

create function suma(num1 int, num2 int) returns int
begin
    declare total int;
    set total =num1 + num2;
    return total;

end;

create function mayor(num1 int, num2 int) returns int
begin
    IF num1 > num2 THEN return num1;
        ELSEIF num1 < num2 THEN return num2;
        ELSE return 0;
    END IF;

end;

/***
  Calcula el impuesto a un premio
 */

-- drop function impto;

create function impto(valor double) returns double
begin
    if valor <= 10 then return valor * 0.05;
        elseif valor <= 20 then return valor * 0.07;
        elseif valor <= 30 then return valor * 0.08;
        elseif valor <= 50 then return valor * 0.09;
        else return valor * 0.1;
    end if;
end;


select suma(5, 5), mayor(4, 4), impto(40);