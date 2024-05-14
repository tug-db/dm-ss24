EXPLAIN SELECT DISTINCT b.Title
FROM Book b 
JOIN Rating r ON b.ISBN = r.ISBN
JOIN Users u ON r.UID = u.UID
JOIN Country c ON u.ISO_3166 = c.ISO_3166
WHERE b.Language <> 'en' AND r.Rating > 8 AND c.ISO_3166 IN ('US', 'GB', 'CA', 'AU');

-- "QUERY PLAN"
-- "Unique  (cost=1678.78..1678.91 rows=25 width=35)"
-- "  ->  Sort  (cost=1678.78..1678.85 rows=25 width=35)"
-- "        Sort Key: b.title"                                                                          == Selecting the Titles from the Book table
-- "        ->  Hash Join  (cost=43.74..1678.20 rows=25 width=35)"
-- "              Hash Cond: (u.iso_3166 = c.iso_3166)"                                                 == Joining the ISO_3166 from Countries
-- "              ->  Nested Loop  (cost=41.90..1675.41 rows=335 width=38)"
-- "                    ->  Hash Join  (cost=41.48..430.85 rows=335 width=39)"      
-- "                          Hash Cond: ((r.isbn)::text = (b.isbn)::text)"                             == Joining the Ratings according to the ISBN
-- "                          ->  Seq Scan on rating r  (cost=0.00..380.94 rows=3206 width=15)"
-- "                                Filter: (rating > 8)"                                               == Selecting Ratings with rating > 8
-- "                          ->  Hash  (cost=39.35..39.35 rows=170 width=46)"
-- "                                ->  Seq Scan on book b  (cost=0.00..39.35 rows=170 width=46)"
-- "                                      Filter: ((language)::text <> 'en'::text)"                     == Selecting books which are not in English
-- "                    ->  Index Scan using users_pkey on users u  (cost=0.42..3.72 rows=1 width=7)"
-- "                          Index Cond: (uid = r.uid)"                                                == Joining the Users accoring to UID
-- "              ->  Hash  (cost=1.79..1.79 rows=4 width=3)"
-- "                    ->  Seq Scan on country c  (cost=0.00..1.79 rows=4 width=3)"
-- "                          Filter: (iso_3166 = ANY ('{US,GB,CA,AU}'::bpchar[]))"                     == Selecting according to the countries