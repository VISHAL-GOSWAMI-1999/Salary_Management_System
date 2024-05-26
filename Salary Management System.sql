create database salary_mangement ;

use salary_mangement;

create table Employee(EID int primary key auto_increment, EName varchar(50), Gender varchar(1), Email varchar(255), JoinDate date );

create table Salary(SID int primary key auto_increment, Basic float, Allowance float);

create table Employee_Salary(EID int , SID int , foreign key (EID) references Employee(EID) , foreign key (SID) references Salary(SID));

create table Leave_(LID int primary key auto_increment , EID int , L_month int , L_days int ,reason varchar(255),foreign key (EID) references Employee(EID));

create table Transection(TID int primary key auto_increment, EID int , Amount float, T_Date date, S_month varchar(3), foreign key (EID) references Employee(EID));

create table Fund(FID int primary key auto_increment, Fund_amount float);

create table Fund_Audit(NewFund float, OldFund float, T_Date date);

create table EmpSalary_Audit(EID int primary key auto_increment, NewSID int, OldSID int, ChangingDate date );

select * from employee;

select * from employee_salary;

select * from empsalary_audit;

select * from fund;

select * from fund_audit;

select * from leave_;

select * from salary;

select * from transection ; 

delimiter //
create procedure view_detail_salary(in eids int)
begin 
     select employee.EID,employee.ename,employee.gender,employee.email, employee.joining_date,salary.basic,
     salary.allowance, transection.t_date, transection.s_month,transection.amount,transection.tid
     from salary 
     join Employee_salary on salary.SID = Employee_salary.SID
     join transection on Employee_salary.EID = transection.EID 
     join employee on employee.EID=transection.EID
     where EID = eids;
end // delimiter ;

call view_detail_salary();


 
select basic , allowance , generate_salary(basic) from salary ;

delimiter //
create procedure transect_salary(in EIDs int  , in Salary_month varchar(3) )
begin 
     update transection set amount = generate_salary(salary.basic),s_month=Salary_month,t_date=now(),EID=EIDs where EID = EIDS ;
end; 
// delimiter ;     

call transect_salary(eid,s_month);

delimiter //
create procedure add_fund( in fid int,in amount float )
begin
     update fund set fund_amount=fund_amount+amount where Fid=fid;
end ;
// delimiter 

call add_fund()    

delimiter //
create procedure add_leave(in EID int ,in s_month int , in l_days int  ,in reason varchar(255) )
begin 
     update leave_ set EID = EID , L_month = s_month , L_days=L_days+l_days, reason = reason where eid=eid;
end //
delimiter ;  

call add_leave() ;


drop procedure transectsalary;
delimiter //
create procedure TransectSalary(in fid int,in Eid int,in amount float, in month varchar(3) )  
begin
     declare valid int;
     set valid = checkvalid(EID,Month);
     if valid =1 then
     call update_fund( fid , amount);
     else
          select "invalid payment";
     end if ;
end; // delimiter ;   

call transectsalary();

delimiter //
create procedure update_fund(in fid int ,in amount float)
begin
     update fund set amount = amount-amount where FID = fid ;
end; 
//
delimiter ;     

delimiter //
create function generate_salary(EID int , month varchar(3) )
returns float 
deterministic 
reads sql data
begin 
     declare result float;
     set result =basic+ basic;
     return result ;
end //
delimiter ;

delimiter //
create function checkvalid( eid int ,  month varchar(3))
returns int 
deterministic 
reads sql data
begin 
     declare result int ;
     select count(*)
     into result 
     from transection where eid=eid and s_month=month ;
     if result>0 then 
          return 2;
     else
          return 1;
     end if ;
end //
delimiter ;      


delimiter //
create procedure AddEmployee(in Name varchar(50),in gender varchar(1),in  email varchar(255),in joiningDate date,in SID int)
begin 
     insert into employee(ename,gender,email,joindate)
     values(name, gender,email,joiningdate);
end;
// delimiter ;    

call addemployee()

delimiter //
 create procedure ChangeEmpPost(in EID int ,  in SID int )
 begin 
      update employee_salary set sid=sid where eid=eid;
end;
// delimiter ;       
 
call ChangeEmpPost()

DELIMITER //
