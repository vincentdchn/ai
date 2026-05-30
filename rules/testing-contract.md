# Testing Contract

Testing conventions are in `project.yaml` -> `testing`.

- Every implementation in adapters_dir and domain_dir has a corresponding test
- Mock classes follow testing.mock_pattern and live in testing.mock_dir
- Mocks implement the port interface explicitly (no duck-typing)
- Integration tests check testing.integration_guard env var before running
- Never run integration tests unconditionally
- Adapter classes must explicitly `implements` their port interface (no duck-typing)

If no project.yaml exists, infer testing patterns from existing test files.
