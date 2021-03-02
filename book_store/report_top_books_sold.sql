SELECT s.book_id,
       book_name,
       translated,
       first_name || ' ' || last_name AS author_name,
       COUNT(s.book_id) AS sold
       
FROM sales s
LEFT JOIN book b ON b.book_id = s.book_id 
LEFT JOIN author a ON a.author_id = b.author_id

GROUP BY s.book_id,
         book_name,
         translated,
         first_name || ' ' || last_name
         
ORDER BY sold DESC 
    FETCH NEXT 10 ROWS ONLY ;
