import requests

def test_healthcheck_placeholder(base_url):
    resp = requests.get(f"{base_url}/swagger-ui/index.html")
    assert resp.status_code in (200, 302)
