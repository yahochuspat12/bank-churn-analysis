-- 1. Общая статистика
SELECT 
    COUNT(*) AS total_clients,
    SUM(churn) AS total_churned,
    ROUND(AVG(churn) * 100, 2) AS churn_rate
FROM clients;

-- 2. Отток по странам
SELECT 
    country,
    COUNT(*) AS total,
    SUM(churn) AS churned,
    ROUND(AVG(churn) * 100, 2) AS churn_rate
FROM clients
GROUP BY country
ORDER BY churn_rate DESC;

-- 3. Отток по количеству продуктов
SELECT 
    products_number,
    COUNT(*) AS total,
    ROUND(AVG(churn) * 100, 2) AS churn_rate
FROM clients
GROUP BY products_number
ORDER BY products_number;

-- 4. Отток по возрастным группам
SELECT 
    CASE 
        WHEN age < 30 THEN '18-29'
        WHEN age < 40 THEN '30-39'
        WHEN age < 50 THEN '40-49'
        WHEN age < 60 THEN '50-59'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS total,
    ROUND(AVG(churn) * 100, 2) AS churn_rate
FROM clients
GROUP BY age_group
ORDER BY age_group;

-- 5. Топ-10 клиентов по балансу
SELECT 
    customer_id, age, balance, products_number, churn
FROM clients
ORDER BY balance DESC
LIMIT 10;

-- 6. Оконная функция
SELECT 
    customer_id,
    country,
    balance,
    RANK() OVER (PARTITION BY country ORDER BY balance DESC) AS rank_in_country
FROM clients
LIMIT 20;