from airflow import DAG
from airflow.models import Variable
from airflow.operators.generic_transfer import GenericTransfer
from airflow.providers.mysql.operators.mysql import MySqlOperator


SOURCE_DS=Variable.get('SOURCE_DS')
TARGET_DS=Variable.get('TARGET_DS')
TABLES_LIST=Variable.get('TABLES_LIST')

with DAG(
    dag_id='transfer',   
) as dag:
    tables = TABLES_LIST.split(',')
    operators = []
    for table in tables:
        opeator = GenericTransfer(
            task_id='transfer_' + table,
            sql=f'SELECT * FROM {table}',
            source_conn_id=SOURCE_DS,
            destination_conn_id=TARGET_DS,
            preoperator=f'truncate {table}',
            destination_table=table
        )
    execute_query = MySqlOperator(
        task_id="build_total",
        sql="""
INSERT INTO UserTotal (user_id, total_orders, total_purchased, favourite_category_id)
SELECT 
    u.user_id,
    (select count(*) from Orders o where o.user_id = u.user_id ) AS total_orders,
    (select sum(total_amount) from Orders o where o.user_id = u.user_id ) AS total_purchased,
    (
        SELECT 
            pc.category_id 
        FROM 
            Orders o 
            JOIN OrderDetails od ON o.order_id = od.order_id 
            JOIN Products p ON od.product_id = p.product_id 
            JOIN ProductCategories pc ON p.category_id = pc.category_id
        WHERE 
            u.user_id = o.user_id
        GROUP BY 
            pc.category_id
        ORDER BY 
            SUM(od.quantity * p.price) DESC
        LIMIT 1
    ) AS favourite_category_id
FROM 
    Users u
GROUP BY 
    u.user_id;
        """,
        mysql_conn_id="mysql-target",
        dag=dag
    )
    for operator in operators:
        operator >> execute_query
