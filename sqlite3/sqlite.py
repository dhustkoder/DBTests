#!/bin/python

import os.path
import sys
import sqlite3


def connect(db_path):
    conn = sqlite3.connect(db_path)
    print("connection success!")
    return conn


def execute_and_fetch(conn, command):
    cursor = conn.cursor()
    cursor.execute(command)
    fetch = cursor.fetchall()
    cursor.close()
    return fetch;



def list(conn, rows, table):
        result = execute_and_fetch(conn, "SELECT " + rows + " FROM " + table)
        for row in result:
            print(str(row))


def main():
    try:
        conn = None
        if len(sys.argv) < 3:
            raise Exception("usage: " + sys.argv[0] + " <db> <table>")
        elif not os.path.isfile(sys.argv[1]):
            raise Exception("\'" + sys.argv[1] + "\' is not a db file")
        conn = connect(sys.argv[1])
        list(conn, "*", sys.argv[2])
    
    except Exception as e:
        print(str(e))

    finally:
        if conn:
            print("closing connection!")
            conn.close()


main()
