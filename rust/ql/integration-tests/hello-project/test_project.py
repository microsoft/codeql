import pytest


@pytest.mark.ql_test("steps.ql", expected=".cargo.expected")
def test_cargo(codeql, rust, cargo, check_source_archive, rust_check_diagnostics):
    codeql.database.create()

@pytest.mark.ql_test("steps.ql", expected=".rust-project.expected")
def test_rust_project(codeql, rust, rust_project, check_source_archive, rust_check_diagnostics):
    codeql.database.create()

@pytest.mark.ql_test(None)
# parametrizing `rust_edition` allows us to skip the default parametrization over all editions
@pytest.mark.parametrize("rust_edition", [2024])
def test_do_not_print_env(codeql, rust, rust_edition, cargo, check_env_not_dumped, rust_check_diagnostics):
    codeql.database.create(_env={
        "CODEQL_EXTRACTOR_RUST_VERBOSE": "2",
    })

@pytest.mark.ql_test("steps.ql", expected=".cargo.expected")
@pytest.mark.parametrize(("rust_edition", "compression", "suffix"), [
    pytest.param(2024, "none", [], id="none"),
    pytest.param(2024, "gzip", [".gz"], id="gzip"),
    pytest.param(2024, "zstd", [".zst"], id="zstd"),
])
def test_compression(codeql, rust, rust_edition, compression, suffix, cargo, rust_check_diagnostics, cwd):
    codeql.database.create(
        _env={
            "CODEQL_EXTRACTOR_RUST_OPTION_TRAP_COMPRESSION": compression,
        }
    )
    trap_files = [*(cwd / "test-db" / "trap").rglob("*.trap*")]
    assert trap_files, "No trap files found"
    expected_suffixes = [".trap"] + suffix

    def is_of_expected_format(file):
        return file.name == "metadata.trap.gz" or \
            file.suffixes[-len(expected_suffixes):] == expected_suffixes

    files_with_wrong_format = [
        f for f in trap_files if not is_of_expected_format(f)
    ]
    assert not files_with_wrong_format, f"Found trap files with wrong format"
