from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.providers.microsoft.mssql.hooks.mssql import MsSqlHook

def load_data_in_batches_mssql_to_pgsql(stg_schema: str, stg_table: str, source_script_query_dir:str, chunk_size = 150) -> None:
    """Loading data in batches based on SELECT in mssql
        stg_schema -"""
    
    print("Opening connections...")
    mssql_hook = MsSqlHook(mssql_conn_id='source_mssql')
    postgres_hook = PostgresHook(postgres_conn_id='stg_postgres')

    mssql_conn = mssql_hook.get_conn()
    mssql_cursor = mssql_conn.cursor()

    postgres_conn = postgres_hook.get_conn()
    postgres_cursor = postgres_conn.cursor()

    print("Connected successfully and created cursors to source and staging")


    schema_query = f"""
        SELECT column_name
        FROM information_schema.columns
        WHERE table_schema = '{stg_schema}'
          AND table_name   = '{stg_table}'
        ORDER BY ordinal_position;
    """

    postgres_cursor.execute(schema_query)
    stg_column_names = postgres_cursor.fetchall()
    stg_column_names = [col[0] for col in stg_column_names]

    print("Acquired column names from staging table schema")

    
    with open(source_script_query_dir, 'r') as query:
        select_query = query.read()
    print("Running query:")        
    print(select_query)
    print("With params:", sql_params)
    mssql_cursor.execute(select_query, sql_params)

    print("Executed SELECT query on source")
    # Fetch data in chunks and insert into PostgreSQL
    while True:
        # Fetch a chunk of rows	LoadDateTime TIMESTAMP 
        rows = mssql_cursor.fetchmany(chunk_size)
        print("Returned number of rows is:", len(rows))
        if not rows:
            print("No more rows returned")
            break  # Exit loop if there are no more rows
        
        # Insert into PostgreSQL
        postgres_hook.insert_rows(
            table = stg_table,
            rows = rows,
            target_fields = stg_column_names,  # List column names here
            commit_every = chunk_size #Commit after each chunk
        )
    
    print("Closing connections...")
    # Close the MSSQL connection
    mssql_cursor.close()
    mssql_conn.close()
    print('Finished loading')
