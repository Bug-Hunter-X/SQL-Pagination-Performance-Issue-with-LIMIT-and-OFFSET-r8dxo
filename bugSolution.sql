The performance problem with `LIMIT` and `OFFSET` is often addressed by using techniques that avoid the need to skip a large number of rows.  One such solution is to use window functions.

For example, consider the following query using `ROW_NUMBER()`:

```sql
WITH RankedRows AS (
    SELECT *, ROW_NUMBER() OVER (ORDER BY id) as rn
    FROM large_table
)
SELECT * FROM RankedRows WHERE rn BETWEEN 1000001 AND 1000010;
```

This query avoids the `OFFSET` clause by assigning a row number and filtering based on that number.  Other techniques include using database-specific features like cursor-based pagination or indexing strategies that optimize for the specific pagination logic.