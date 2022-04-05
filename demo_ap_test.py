import os
import tempfile
import json
import base64

import pytest

from demo_app import create_app
from demo_app.db import init_db

USER_DATA = {
        'username':'Pekka',
        'password':'09874',
        'firstname':'Tarmo',
        'lastname':'Pentti',
        'phone':'0403719643'
    }

@pytest.fixture
def client():
    db_fd, db_path = tempfile.mkstemp()
    app = create_app({'TESTING':True, 'DATABASE':db_path})

    with app.test_client() as client:
        with app.app_context():
            init_db()
        yield client

    os.close(db_fd)
    os.unlink(db_path)

def setUp(client):
    response = client.post('/api/users', json=USER_DATA, headers={'Content-Type':'application/json'})
    assert response.status_code==201

def get_token(client, username, password):
    auth_string = "{}:{}".format(username, password)
    credentials = base64.b64encode(f'{auth_string}'.encode()).decode('utf-8')
    response = client.get("/api/auth/token", headers={"Authorization": f"Basic {credentials}", "Content-Type":"application/json"})
    assert response.status_code==200
    data=json.loads(response.data)
    token = data['token']
    return token

def test_register_user(client):
    setUp(client)

def test_get_all_registered_users(client):
    setUp(client)

    token = get_token(client, USER_DATA['username'], USER_DATA['password'])
    response = client.get('/api/users', headers={"Token": f"{token}", "Content-Type": "application/json"})
    assert response.status_code == 200
    assert b'payload' in response.data

    data = json.loads(response.data)
    assert len(data['payload'])==1
    assert data['payload'][0] == USER_DATA['username']

def test_get_unique_user_personal_information(client):
    setUp(client)

    token = get_token(client, USER_DATA['username'], USER_DATA['password'])

    response = client.get(f"/api/users/{USER_DATA['username']}", headers={"Token": f"{token}", "Content-Type":"application/json"})
    assert response.status_code==200

def test_update_unique_user(client):
    setUp(client)

    token = get_token(client, USER_DATA['username'], USER_DATA['password'])

    response = client.put(f"/api/users/{USER_DATA['username']}", json=dict(firstname="Antti"), headers={"Token": f"{token}", "Content-Type":"application/json"})
    assert response.status_code == 201
