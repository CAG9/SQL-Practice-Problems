with sub_total as (
SELECT coll.contest_id, sum(ss.total_submissions) as sum_ts, sum(ss.total_accepted_submissions)
as sum_tas
FROM Colleges AS COLL
INNER JOIN Challenges AS CHALL ON COLL.college_id = CHALL.college_id
INNER JOIN submission_stats as ss on chall.challenge_id = ss.challenge_id
group by coll.contest_id
), view_total as (
SELECT coll.contest_id, sum(vs.total_views) as sum_tv, sum(vs.total_unique_views )
as sum_tuv
FROM Colleges AS COLL
INNER JOIN Challenges AS CHALL ON COLL.college_id = CHALL.college_id
INNER JOIN View_Stats as vs on chall.challenge_id = vs.challenge_id
group by coll.contest_id
)
select con.contest_id, con.hacker_id, con.name, sum_ts, sum_tas, sum_tv, sum_tuv
from Contests as con
inner join sub_total as st on con.contest_id = st.contest_id
inner join view_total as vt on con.contest_id = vt.contest_id
