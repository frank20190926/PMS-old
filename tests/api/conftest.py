import os
import pytest

@pytest.fixture
def base_url():
    return os.getenv("PMS_BASE_URL", "http://localhost:8090")
