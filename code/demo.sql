drop table emp_vanoug;

create table emp_vanoug
as select * from emp;

alter table emp_vanoug add constraint pkg_emp_vanoug primary key (empno);

drop sequence sn_gen;

create sequence sn_gen minvalue 8000 increment by 1 start with 8000 cache 20 noorder  nocycle ;

create or replace trigger trg_emp_vanoug
before insert on emp_vanoug
for each row
begin
  :new.empno := nvl(:new.empno, sn_gen.nextval);
end;
/

-- Create dashboard for HR Manager


-- Create IR / form for Employees
*** COPY THIS QUERY ***

select
  e.empno,
  e.ename,
  e.job,
  mgr.ename mgr,
  e.hiredate,
  e.sal,
  e.comm,
  d.dname
from emp_vanoug e, emp_vanoug mgr, dept d
where 1=1
  and e.mgr = mgr.empno(+)
  and e.deptno = d.deptno(+)

;


-- Create chart to show how much each emp makes

-- Save report

-- Create department view (control break)

-- Craete department (sum sal)

-- Pivot
-- Problem: Want to find the average salary for each job in each dept
-- Pivot: Dname
-- Row: Job
-- Avg: Sal - Format Mask

-- Save

-- Login as Frank (FF / Safari)


-- Back to main report




-- ***** DASHBOARD *****

-- New List (Departments)
select null,
       initcap(dname) label,
       null target,
       null is_current,
null image,
null image_attribute,
null image_alt_attribute,
count(1) attribute1
from  dept d, emp_vanoug e
where d.deptno = e.deptno(+)
group by d.dname
order by dname

;


-- P1 List Region
-- Attr > Lis Temp > Badge


-- New Chart (how much does each dept cost)

select null link,
  initcap(dname) label,
  sum(e.sal) value
from  dept d, emp_vanoug e
where d.deptno = e.deptno(+)
group by d.dname
;

-- H/W: 500
 -- Scheme: Look 4



-- See visual graph of all emps and how much they cost
-- D3 plugin
WITH
nodes AS ( --> START YOUR NODES QUERY HERE
  SELECT XMLELEMENT( "nodes", xmlattributes(
         empno        AS id
       , ename        AS label
       , sal          AS sizevalue
       , d.deptno     AS colorvalue
       , d.dname      AS colorlabel    -- optional, used for the graph legend
     --, 'http://...' AS link          -- optional
     --, 'some text'  AS infostring    -- optional, rendered as tooltip
     --, 'false'      AS labelcircular -- optional, overwrites the global labelsCircular
     --, 'http://...' AS image         -- optional, background image for a node instead of a fill color
     --, 'true'       AS "fixed"       -- optional | fixed, x and y are native D3 attributes
     --, 100          AS "x"           -- optional | they must be lowercase
     --, 100          AS "y"           -- optional | you can predefine a layout with these attributes
         ) ) AS xml_nodes
    FROM emp_vanoug e join dept d on e.deptno = d.deptno --< STOP YOUR NODES QUERY HERE
),
links AS ( --> START YOUR LINKS QUERY HERE
  SELECT XMLELEMENT( "links", xmlattributes(
         empno          AS fromid
       , NVL(mgr,empno) AS toid
     --, 'dashed'       AS style       -- optional, can be solid (default), dotted or dashed
     --, 'red'          AS color       -- optional, must be a HTML color code like green or #00ff00
     --, 'some text'    AS infostring  -- optional, rendered as tooltip
         ) ) AS xml_links
    FROM emp_vanoug --< STOP YOUR LINKS QUERY HERE
)
SELECT XMLSERIALIZE( DOCUMENT( XMLELEMENT( "data",
        ( SELECT XMLAGG( xml_nodes ) FROM nodes ),
        ( SELECT XMLAGG( xml_links ) FROM links ) ) ) INDENT ) AS single_clob_result
  FROM DUAL

;


-- *** CREATE DATA LOAD ****
Rule: HireDate: to_date(:HIREDATE, 'YYYY-MM-DD')

- Change Enclosed by (null)
- Delim: ,

-- Change icons in list (end)
