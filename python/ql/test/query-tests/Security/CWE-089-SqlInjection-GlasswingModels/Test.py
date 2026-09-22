import asyncio
import base64
import os
import sqlite3
from collections import defaultdict

import sqlglot
from autogen_core.tools import FunctionTool
from flask import request  # $ Source
from pydantic import BaseModel
from pyspark.sql import SparkSession


class SqlHelper:
    def execute_generated_query(self, sql_query: str):  # $ Source
        parsed_queries = sqlglot.parse(sql_query)
        updated_queries = []
        for parsed_query in parsed_queries:
            parsed_query.set("limit", 10)
            updated_queries.append(parsed_query.sql())

        sqlite3.connect("example.db").execute(";".join(updated_queries))  # $ Alert

    def describe_generated_query(self, sql_query: str):
        return len(sql_query)

    def execute_generated_query_directly(self, sql_query: str):  # $ Source
        sqlite3.connect("example.db").execute(sql_query)  # $ Alert

    async def query_execution_with_limit(self, sql_query: str):  # $ Source
        cleaned_query = await self.query_validation(sql_query)
        return await self.query_execution(cleaned_query)  # $ Alert

    async def query_validation(self, sql_query: str):
        parsed_queries = sqlglot.parse(sql_query)
        return ";".join(parsed_query.sql() for parsed_query in parsed_queries)

    async def query_execution(self, sql_query: str):
        return sql_query


helper = SqlHelper()
FunctionTool(helper.execute_generated_query, description="Run generated SQL")
FunctionTool(helper.describe_generated_query, description="Describe generated SQL")
FunctionTool(helper.execute_generated_query_directly, description="Run generated SQL directly")
FunctionTool(helper.query_execution_with_limit, description="Validate and run generated SQL")


def execute_function_tool_query(sql_query: str):  # $ Source
    sqlite3.connect("example.db").execute(sql_query)  # $ Alert


FunctionTool(execute_function_tool_query, description="Run generated SQL function")


class QuerySegment(BaseModel):
    data: str


class Query(BaseModel):
    segments: list[QuerySegment]


class QueryConfiguration(BaseModel):
    query: str


def execute_job(spark: SparkSession):
    encoded_config = os.environ.get("JOB_CONFIG")  # $ Source
    query_json = base64.b64decode(encoded_config).decode()
    query = Query.model_validate_json(query_json)
    spark.sql(query.segments[0].data)  # $ Alert


async def execute_query_segment(spark: SparkSession, segment: QuerySegment):
    spark.sql(segment.data)  # $ Alert


async def run_orchestrated_query(spark: SparkSession, query: Query):
    segments_by_step = defaultdict(list)
    for segment in query.segments:
        segments_by_step[0].append(segment)

    tasks = []
    for step in sorted(segments_by_step.keys()):
        segments = segments_by_step[step]
        for segment in segments:
            tasks.append(execute_query_segment(spark, segment))
    await asyncio.gather(*tasks)


async def execute_orchestrated_job(spark: SparkSession):
    encoded_config = os.environ.get("JOB_CONFIG")  # $ Source
    job_config = base64.b64decode(encoded_config).decode()
    config = QueryConfiguration.model_validate_json(job_config)
    query_json = base64.b64decode(config.query).decode()
    query = Query.model_validate_json(query_json)
    await run_orchestrated_query(spark, query)


def execute_direct_job_config():
    sqlite3.connect("example.db").execute(os.environ["JOB_CONFIG"])  # $ Alert


def execute_direct_pyspark_query(spark: SparkSession):
    spark.sql(request.args["query"])  # $ Alert


def execute_pydantic_query():
    query = Query.model_validate_json(request.args["query"])
    sqlite3.connect("example.db").execute(query.segments[0].data)  # $ Alert


def execute_sqlglot_query():
    parsed_query = sqlglot.parse_one(request.args["query"])
    sqlite3.connect("example.db").execute(parsed_query.sql())  # $ Alert


def execute_constant_job(spark: SparkSession):
    query = Query.model_validate_json('{"segments": [{"data": "SELECT 1"}]}')
    spark.sql(query.segments[0].data)
    spark.sql("SELECT 1")


def execute_constant_sqlglot_query():
    parsed_query = sqlglot.parse_one("SELECT 1")
    sqlite3.connect("example.db").execute(parsed_query.sql())
