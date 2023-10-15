/* CRIA UM SCHEMA PARA AS TABELAS QUE SERÃO INCLUÍDAS NO BANCO */
create schema azure_company;

/* CONSULTA OS SCHEMAS EXISTENTES NO BANCO */
select * from sys.schemas

-- restrição atribuida a um domínio
-- create domain D_num as int check(D_num> 0 and D_num< 21);

/* CRIA A TABELA EMPLOYEE */

CREATE TABLE azure_company.employee(
	Fname varchar(15) not null,
    Minit char,
    Lname varchar(15) not null,
    Ssn char(9) not null, 
    Bdate date,
    Address varchar(30),
    Sex char,
    Salary decimal(10,2),
    Super_ssn char(9),
    Dno int not null,
    constraint chk_salary_employee check (Salary> 2000.0),
    constraint pk_employee primary key (Ssn)
);

alter table azure_company.employee 
	add constraint fk_employee 
	foreign key(Super_ssn) references azure_company.employee(Ssn)
    on delete no action
	on update no action;

/* CRIA A TABELA DEPARTMENT */

create table azure_company.department(
	Dname varchar(15) not null,
    Dnumber int not null,
    Mgr_ssn char(9) not null,
    Mgr_start_date date, 
    Dept_create_date date,
    constraint chk_date_dep check (Dept_create_date < Mgr_start_date),
    constraint pk_dep primary key (Dnumber),
    constraint unique_name_dep unique(Dname),
    foreign key (Mgr_ssn) references azure_company.employee(Ssn)
);

-- 'def', 'company_constraints', 'departament_ibfk_1', 'company_constraints', 'departament', 'FOREIGN KEY', 'YES'
-- modificar uma constraint: drop e add

-- alter table azure_company.departament drop departament_ibfk_1;
alter table azure_company.department 
		add constraint fk_dep foreign key(Mgr_ssn) references azure_company.employee(Ssn)
        on update cascade;
--desc departament;

/* CRIA A TABELA DEPT_LOCATIONS */

create table azure_company.dept_locations(
	Dnumber int not null,
	Dlocation varchar(15) not null,
    constraint pk_dept_locations primary key (Dnumber, Dlocation),
    constraint fk_dept_locations foreign key (Dnumber) references azure_company.department (Dnumber)
);

alter table azure_company.dept_locations drop fk_dept_locations;

alter table azure_company.dept_locations 
	add constraint fk_dept_locations foreign key (Dnumber) references azure_company.department(Dnumber)
	on delete cascade
    on update cascade;

---
/* CRIA A TABELA PROJECTS */
create table azure_company.projects(
	Pname varchar(15) not null,
	Pnumber int not null,
    Plocation varchar(15),
    Dnum int not null,
    primary key (Pnumber),
    constraint unique_project unique (Pname),
    constraint fk_project foreign key (Dnum) references azure_company.department(Dnumber)
);

/* CRIA A TABELA WORKS_ON */
create table azure_company.works_on(
	Essn char(9) not null,
    Pno int not null,
    Hours decimal(3,1) not null,
    primary key (Essn, Pno),
    constraint fk_employee_works_on foreign key (Essn) references azure_company.employee(Ssn),
    constraint fk_project_works_on foreign key (Pno) references azure_company.projects(Pnumber)
);
/* CRIA A TABELA DEPENDENT */
create table azure_company.dependent(
	Essn char(9) not null,
    Dependent_name varchar(15) not null,
    Sex char,
    Bdate date,
    Relationship varchar(8),
    primary key (Essn, Dependent_name),
    constraint fk_dependent foreign key (Essn) references azure_company.employee(Ssn)
);


/* CONSULTA AS INFORMAÇÕES DE CONSTRAINT DAS TABELAS DO SCHEMA CRIADO */
select * from information_schema.table_constraints
	where constraint_schema = 'azure_company';

select * from sys.tables