
WITH ratings AS (

    SELECT DISTINCT user_id
    FROM {{ ref('stg_ratings') }}

),

tags AS (

    SELECT DISTINCT user_id
    FROM {{ ref('stg_tags') }}

)

SELECT user_id
FROM ratings

UNION

SELECT user_id
FROM tags

