--Day41
CREATE TABLE t1(c1 INT);

CREATE TABLE t2(c2 VARCHAR);

INSERT INTO t1
VALUES
(4),
(6),
(7),
(9),
(3),
(9);

INSERT INTO t2
VALUES
(1),
(5),
(9),
(2),
(2),
(11);

--Output of the below query
SELECT t1.c1
FROM t1
Left JOIN t2 ON t1.c1 = CAST(t2.c2 AS INT);

--output
3
4
6
7
9
9
