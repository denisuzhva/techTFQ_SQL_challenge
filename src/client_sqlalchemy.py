from sqlalchemy import create_engine
from sqlalchemy import exc
from sqlalchemy import text

import pandas as pd
from dotenv import load_dotenv
import os

import argparse
from pprint import pprint


def command_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('-D', '--dir', required=True,
                        help='Path to query files')
    parser.add_argument('-q', '--query', required=True,
                        help='Query file')
    args = parser.parse_args()
    return args


def fetch_result(table_query: str, main_query: str) -> list:
    """
    Connects to the database, creates a table, 
    executes the main query over the table, and returns the result.

    Args:
        table_query: SQL query for table creation.
        main_query: The main SQL query to execute.

    Returns:
        A list of tuples representing the result of the query.
    """
    load_dotenv()

    host = os.getenv("SERVER")
    port = os.getenv("PORT")
    user = os.getenv("USER")
    dbname = user
    password = os.getenv("PASSWORD")

    try:
        engine = create_engine(
            "{dialect}+{driver}://{username}:{password}@{host}:{port}/{database}".format(
                dialect="postgresql",
                driver="psycopg2",
                username=user,
                password=password,
                host=host,
                port=port,
                database=dbname
            )
        )

        with engine.connect() as db_conn:
            db_conn.execute(text(table_query))
            df = pd.read_sql_query(sql=text(main_query), con=db_conn)

    except (Exception, exc.SQLAlchemyError) as error:
        print("Error fetching data from PostgreSQL table", error)
        return None

    return df


if __name__ == "__main__":
    args = command_args()
    with open(args.dir + 'make_table.sql', 'r') as query_f:
        table_query = query_f.read()
    with open(args.dir + args.query, 'r') as query_f:
        main_query = query_f.read()
    data = fetch_result(table_query, main_query)
    pprint(data)
