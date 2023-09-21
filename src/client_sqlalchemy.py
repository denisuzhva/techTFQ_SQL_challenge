import sqlalchemy
from sqlalchemy.orm import Session
from sqlalchemy import create_engine
from sqlalchemy import exc

import pandas as pd
from dotenv import load_dotenv
import os

import argparse
from pprint import pprint


def command_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('-q', '--query', required=True,
                        help='Path to query file')
    args = parser.parse_args()
    return args


def fetch_result(query: str, commit: bool = False) -> list:
    """
    Connects to the database, executes the given query, and returns the result.

    Args:
        query: The SQL query to execute.
        commit: If True, commit the transaction after executing the query.

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

        with Session(engine) as session:
            with engine.connect() as db_conn:
                df = pd.read_sql_query(sql=query, con=db_conn)
            session.commit()

    except (Exception, exc.SQLAlchemyError) as error:
        print("Error fetching data from PostgreSQL table", error)
        return None

    return df


if __name__ == "__main__":
    args = command_args()
    with open(args.query, 'r') as query_f:
        query = query_f.read()
    data = fetch_result(query, commit=True)
    pprint(data)
