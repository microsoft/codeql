
import os
import pytest

@pytest.fixture
def check_query_suite(codeql, cwd, expected_files, semmle_code_dir):
    def ret(query_suite):
        actual = codeql.resolve.queries(query_suite, _capture=True)
        actual = sorted(actual.splitlines())
        actual = [os.path.relpath(q, semmle_code_dir) for q in actual]
        actual_file_name = query_suite + '.actual'
        expected_files.add(actual_file_name)
        (cwd / actual_file_name).write_text('\n'.join(actual) + '\n')
    return ret

@pytest.fixture
def check_queries_not_included(codeql, cwd, expected_files, semmle_code_dir):
    def ret(lang_folder_name, query_suites):
        all_queries = codeql.resolve.queries(semmle_code_dir / 'ql' / lang_folder_name / 'ql' / 'src', _capture=True).splitlines()

        included_in_qls = set()
        for query_suite in query_suites:
            included_in_qls |= set(codeql.resolve.queries(query_suite, _capture=True).strip().splitlines())

        not_included = sorted(set(all_queries) - included_in_qls)
        not_included = [os.path.relpath(q, semmle_code_dir) for q in not_included]
        not_included_file_name = 'not_included_in_qls.actual'
        expected_files.add(not_included_file_name)
        (cwd / not_included_file_name).write_text('\n'.join(not_included) + '\n')
    return ret
