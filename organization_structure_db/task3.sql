WITH RECURSIVE subordinate_tree AS (
    SELECT
        e.employeeid AS manager_id,
        e.employeeid AS subordinate_id
    FROM employees e
    WHERE e.roleid = 1

    UNION ALL

    SELECT
        st.manager_id,
        e.employeeid AS subordinate_id
    FROM subordinate_tree st
             JOIN employees e
                  ON e.managerid = st.subordinate_id
),
               total_subordinates AS (
                   SELECT
                       manager_id AS employeeid,
                       COUNT(*) - 1 AS totalsubordinates
                   FROM subordinate_tree
                   GROUP BY manager_id
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
                       STRING_AGG(t.taskname, ', ' ORDER BY t.taskname) AS tasknames
                   FROM tasks t
                   GROUP BY t.assignedto
               )
SELECT
    e.employeeid AS "EmployeeID",
    e.name AS "EmployeeName",
    e.managerid AS "ManagerID",
    d.departmentname AS "DepartmentName",
    r.rolename AS "RoleName",
    pa.projectnames AS "ProjectNames",
    ta.tasknames AS "TaskNames",
    ts.totalsubordinates AS "TotalSubordinates"
FROM employees e
         JOIN roles r
              ON r.roleid = e.roleid
         JOIN total_subordinates ts
              ON ts.employeeid = e.employeeid
         LEFT JOIN departments d
                   ON d.departmentid = e.departmentid
         LEFT JOIN project_agg pa
                   ON pa.employeeid = e.employeeid
         LEFT JOIN task_agg ta
                   ON ta.employeeid = e.employeeid
WHERE r.rolename = 'Менеджер'
  AND ts.totalsubordinates > 0
ORDER BY e.name;