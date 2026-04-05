WITH RECURSIVE employee_hierarchy AS (
    SELECT
        e.employeeid,
        e.name,
        e.managerid,
        e.departmentid,
        e.roleid
    FROM employees e
    WHERE e.employeeid = 1

    UNION ALL

    SELECT
        e.employeeid,
        e.name,
        e.managerid,
        e.departmentid,
        e.roleid
    FROM employees e
             JOIN employee_hierarchy eh
                  ON e.managerid = eh.employeeid
),
               project_agg AS (
                   SELECT
                       e.employeeid,
                       STRING_AGG(DISTINCT p.projectname, ', ' ORDER BY p.projectname) AS projectnames
                   FROM employees e
                            LEFT JOIN projects p
                                      ON p.departmentid = e.departmentid
                   GROUP BY e.employeeid
               ),
               task_agg AS (
                   SELECT
                       t.assignedto AS employeeid,
                       STRING_AGG(t.taskname, ', ' ORDER BY t.taskname) AS tasknames,
                       COUNT(t.taskid) AS totaltasks
                   FROM tasks t
                   GROUP BY t.assignedto
               ),
               subordinates AS (
                   SELECT
                       e.managerid AS employeeid,
                       COUNT(*) AS totalsubordinates
                   FROM employees e
                   WHERE e.managerid IS NOT NULL
                   GROUP BY e.managerid
               )
SELECT
    eh.employeeid AS "EmployeeID",
    eh.name AS "EmployeeName",
    eh.managerid AS "ManagerID",
    d.departmentname AS "DepartmentName",
    r.rolename AS "RoleName",
    pa.projectnames AS "ProjectNames",
    ta.tasknames AS "TaskNames",
    COALESCE(ta.totaltasks, 0) AS "TotalTasks",
    COALESCE(s.totalsubordinates, 0) AS "TotalSubordinates"
FROM employee_hierarchy eh
         LEFT JOIN departments d
                   ON d.departmentid = eh.departmentid
         LEFT JOIN roles r
                   ON r.roleid = eh.roleid
         LEFT JOIN project_agg pa
                   ON pa.employeeid = eh.employeeid
         LEFT JOIN task_agg ta
                   ON ta.employeeid = eh.employeeid
         LEFT JOIN subordinates s
                   ON s.employeeid = eh.employeeid
ORDER BY eh.name;