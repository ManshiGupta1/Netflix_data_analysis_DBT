
WITH stg_genome_score AS (

    SELECT *
    FROM {{ ref('stg_genome_score') }}

)

SELECT
    movie_id,
    tag_id,
    ROUND(relevance, 4) AS relevance_score
FROM stg_genome_score
WHERE relevance > 0
