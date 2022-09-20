from atexit import register
import base64
import json
import unittest
import tempfile

from demo_app import create_app
from demo_app.db import init_db
from http import HTTPStatus
from flask import current_app

class GetDataSourceTestCase(unittest.TestCase):
    def setUp(self):
        db_fd, db_path = tempfile.mkstemp()
        self.app = create_app({'TESTING': True, 'DATABASE': db_path})
        self.appctx = self.app.app_context()
        self.appctx.push()
        init_db()
        self.client = self.app.test_client()

    def tearDown(self):
        self.appctx.pop()
        self.app = None
        self.appctx = None
        self.client = None

    def test_app(self):
        assert self.app is not None
        assert current_app == self.app

    
    def register_user(self, payload):
        return self.client.post('/api/users', json=payload,  headers={'Content-Type': 'application/json'})

    def test_register_user(self):

        respoonse = self.register_user({
                                'username': 'sampleTest',
                                'password': 'jsonpwd',
                                'firstname': 'TestName',
                                'lastname': 'TestLastName',
                                'phone': '098747478'
                            })
        assert respoonse.status_code == HTTPStatus.CREATED

    def authenticate(self, username, password):
        get_credentials = "{}:{}".format(username, password)
        auth_credentials = base64.b64encode(f'{get_credentials}'.encode()).decode('utf-8')
        
        return self.client.get("api/auth/token", headers={
                                                            "Content-Type": "application/json",
                                                            "Authorization": f"Basic {auth_credentials}"
                                                        })

    def test_get_users(self):
        self.register_user({
            'username': 'sample1',
            'password': 'jsonpwd',
            'firstname': 'sampleName',
            'lastname': 'SampleLastName',
            'phone': '9837478'
        })
        self.register_user({
            'username': 'sample2',
            'password': 'jsonpwd2',
            'firstname': 'sampleName2',
            'lastname': 'SampleLastName2',
            'phone': '98374782'
        })
        self.register_user({
            'username': 'sample3',
            'password': 'jsonpwd3',
            'firstname': 'sampleName3',
            'lastname': 'SampleLastName3',
            'phone': '98374782'
        })

        get_resp = self.client.get('/api/users')
        assert get_resp.status_code ==  HTTPStatus.OK
        load_json = json.loads(get_resp.data)
        assert len(load_json['payload']) == 3
        assert load_json['payload'][0] == 'sample1'
        assert load_json['payload'][1] == 'sample2'
        assert load_json['payload'][2] == 'sample3'


    def test_get_single_user(self):
        self.register_user({
            'username': 'sampleTest',
            'password': 'jsonpwd',
            'firstname': 'sampleNameTest',
            'lastname': 'SampleLastNameTest',
            'phone': '983747822'
        })

        auth_resp = self.authenticate('sampleTest', 'jsonpwd')
        token_resp = json.loads(auth_resp.data)
        token = token_resp['token']

        get_resp = self.client.get('/api/users/{}'.format('sampleTest'), headers={
                                                        "Content-Type": "application/json",
                                                        "Token":     f"{token}"})
        responase_body = json.loads(get_resp.data)

        assert get_resp.status_code ==  HTTPStatus.OK
        assert responase_body['payload']['phone'] == "983747822"
        assert responase_body['payload']['lastname'] == "SampleLastNameTest"


    def test_put_user(self):
        self.register_user({
            'username': 'sampleT',
            'password': 'jsonpwd',
            'firstname': 'sampleName',
            'lastname': 'SampleLast',
            'phone': '983747845'
        })

        auth_resp = self.authenticate('sampleT', 'jsonpwd')
        token_resp = json.loads(auth_resp.data)
        token = token_resp['token']

        get_resp = self.client.put('/api/users/{}'.format('sampleT'), headers={
                                                        "Content-Type": "application/json",
                                                        "Token":     f"{token}"},
                                                        json={
                                                            "phone": "1234533",
                                                            "lastname": "signantHealth"
                                                        })

        assert get_resp.status_code == HTTPStatus.CREATED

        get_resp = self.client.get('/api/users/{}'.format('sampleT'), headers={
                                                        "Content-Type": "application/json",
                                                        "Token":     f"{token}"})
        responase_body = json.loads(get_resp.data)
        assert responase_body['payload']['phone'] == "1234533"
        assert responase_body['payload']['lastname'] == "signantHealth"
        
    
    if __name__ == "__main__":
        unittest.main()