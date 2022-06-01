from flask import Flask, request, jsonify, make_response
from flask_sqlalchemy import SQLAlchemy
import uuid
from werkzeug.security import generate_password_hash, check_password_hash
import jwt
from datetime import datetime, timedelta
from functools import wraps

from userDbConfig import UserInfo


app = Flask(__name__)
app.config['SECRET_KEY'] = 'HIDDEN'

app.config['SQLALCHEMY_DATABASE_URI'] = 'HIDDEN'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True

db = SQLAlchemy(app)


def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = None
        if 'x-access-token' in request.headers:
            token = request.headers['x-access-token']
        if not token:
            return jsonify({'message': 'Token is missing !'}), 401

        try:
            data = jwt.decode(token, app.config['SECRET_KEY'])
            current_user = UserInfo.query \
                .filter_by(userId=data['userId']) \
                .first()
        except:
            return jsonify({
                'message': 'Token is invalid !!'
            }), 401
        return f(current_user, *args, **kwargs)

    return decorated


@app.route('/user', methods=['GET'])
@token_required
def get_all_users(current_user):
    users = UserInfo.query.all()
    output = []
    for user in users:
        output.append({
            'userId': user.userId,
            'lastName': user.lastName,
            'firstName': user.firstName,
            'phoneNumber': user.phoneNumber,
            'email': user.email
        })

    return jsonify({'users': output})


@app.route('/login', methods=['POST'])
def login():
    auth = request.form

    if not auth or not auth.get('email') or not auth.get('password'):
        # returns 401 if any email or / and password is missing
        return make_response(
            'Could not verify',
            401,
            {'WWW-Authenticate': 'Basic realm ="Login required !!"'}
        )

    user = UserInfo.query \
        .filter_by(email=auth.get('email')) \
        .first()

    if not user:
        return make_response(
            'Could not verify',
            401,
            {'WWW-Authenticate': 'Basic realm ="User does not exist !"'}
        )

    if check_password_hash(user.password, auth.get('password')):
        # JWT Token
        token = jwt.encode({
            'userId': user.userId,
            'exp': datetime.utcnow() + timedelta(minutes=30)
        }, app.config['SECRET_KEY'])

        return make_response(jsonify({'token': token.decode('UTF-8')}), 201)
    return make_response(
        'Could not verify',
        403,
        {'WWW-Authenticate': 'Basic realm ="Wrong Password !"'}
    )


# signup
@app.route('/signup', methods=['POST'])
def signup():
    data = request.form

    firstName, lastName, email, password, phoneNumber = data.get('firstName'), data.get('lastName'), data.get(
        'email'), data.get('password'), data.get('phoneNumber')

    user = UserInfo.query \
        .filter_by(email=email) \
        .first()
    if not user:
        # database ORM object
        user = UserInfo(
            userId=uuid.uuid4(),
            firstName=firstName,
            lastName=lastName,
            email=email,
            password=generate_password_hash(password)
        )
        db.session.add(user)
        db.session.commit()

        return make_response('Successfully registered.', 201)
    else:
        return make_response('User already exists. Please Log in.', 202)


if __name__ == "__main__":
    app.run(debug=True)
