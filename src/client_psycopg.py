import psycopg2
from dotenv import load_dotenv
import os

import psycopg2
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
        conn = psycopg2.connect(dbname=dbname, user=user,
                                password=password, host=host, port=port)
        cur = conn.cursor()
        cur.execute(query)
        if commit:
            conn.commit()
        result = cur.fetchall()
        colnames = [desc[0] for desc in cur.description]

    except (Exception, psycopg2.Error) as error:
        print("Error fetching data from PostgreSQL table", error)

    finally:
        if conn:
            cur.close()
            conn.close()

    return result, colnames


if __name__ == "__main__":
    args = command_args()
    with open(args.query, 'r') as query_f:
        query = query_f.read()
    result, colnames = fetch_result(query, commit=True)
    print(colnames)
    pprint(result)
