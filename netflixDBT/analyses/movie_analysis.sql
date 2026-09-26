WITH ratings_summary AS(
    SELECT
        movie_id,
        AVG(rating) AS average_rating,
        count(*) AS total_ratings
    FROM {{ ref('fct_ratings')}}
    GROUP BY movie_id
    HAVING COUNT(*) > 100 
)

SELECT 
    m.movie_title,
    rs.average_rating,
    rs.total_ratings
FROM ratings_summary rs
JOIN {{ref('dim_movies')}} m ON m.movie_id = rs.movie_id
ORDER BY rs.average_rating DESC
LIMIT 20;

SELECT 
    genre,
    AVG(rating) AS average_rating,
    COUNT(DISTINCT movie_id) AS total_movies
FROM {{ ref('dim_movies_with_tags')}} m
JOIN {{ ref('fct_ratings')}} r ON m.movie_id = r.movie_id
CROSS JOIN UNNEST(m.genre_array) AS genre
GROUP BY genre
ORDER BY average_rating DESC;

SELECT
    user_id,
    COUNT(*) AS number_of_ratings,
    AVG(rating) AS average_rating_given
FROM {{ ref('fct_ratings')}}
GROUP BY user_id
ORDER BY number_of_ratings DESC
LIMIT 20;