"""
Configuring users in db, then returning a json
Usage by:
- init all users by UserInfo
- init a single user by UserId
- change single user data by UserId
- remove single user data by UserId
"""

from flask import make_response, abort
from config import db
from userDbConfig import UserInfo, UserInitSchema
from email_validator import validate_email, EmailNotValidError

"""
initAllUsers():
    Params: none
    Return: json data
    Brief: Initialize people by UserInitSchema, then return a json-ish data
"""
def initAllUsers():
    userList = UserInfo.query.order_by(UserInfo.lastName).all()
    userInitSchema = UserInitSchema(many=True)
    data = userInitSchema.dump(userList)
    return data

"""
initByUserId():
    Params: userId (string)
    Return: json data
    Brief: Initialize person by UserInitSchema, then return a json-ish data
"""
def initByUserId(userId):
    user = (
        UserInfo.query.filter(UserInfo.user_id == userId)
        .one_or_none()
    )

    if user is not None:
        userSchema = UserInitSchema()
        data = userSchema.dump(user)
        return data
    else:
        abort(404, f"Person not found for Id: {userId}")

"""
setUser():
    Params: userInfo variable
    Return: json data in case of success
    Brief: Verify the given info and insert a user in db
"""
def setUser(user):
    lastName=user.get("lastName"),
    firstName=user.get("firstName"),
    userInDb = (
        UserInfo.query.filter(UserInfo.firstName == firstName)
        .filter(UserInfo.lastName == lastName)
        .one_or_none()
    )

    if userInDb is None:
        if not lastName.isalpha() or not firstName.isalpha():
            # First or last name contains digits or special symbols
            abort(404, f"Invalid name. Please use only latin letters ")
        try:
            valid = validate_email(user.get("email"))
            email = valid.email
        except EmailNotValidError as e:
            # We've got an invalid email
            abort(404, f"Email is not valid. Please verify it on typos.")

        schema = UserInitSchema()
        newUser = schema.load(user, session=db.session)
        db.session.add(newUser)
        db.session.commit()
        data = schema.dump(newUser)

        return data, 201
    else:
        abort(409, f"Person {firstName} {lastName} exists already")

"""
changeByUserId():
    Params: userInfo variable & userId to change
    Return: json data in case of success
    Brief: Verify the given info and replace a user in db
"""
def changeByUserId(userId, user):
    userInDb = UserInfo.query.filter(
        UserInfo.userId == userId
    ).one_or_none()

    if userInDb is not None:
        schema = UserInitSchema()
        newSchema = schema.load(user, session=db.session)
        newSchema.userId = userInDb.userId
        db.session.merge(newSchema)
        db.session.commit()
        data = schema.dump(user)

        return data, 200
    else:
        abort(404, f"Person not found for Id: {userId}")

"""
removeByUserId():
    Params: userId to remove
    Return: json data in case of success
    Brief: Verify user exits and remove it from db
"""
def removeByUserId(userId):
    user = UserInfo.query.filter(UserInfo.userId == userId).one_or_none()

    if user is not None:
        db.session.delete(user)
        db.session.commit()
        return make_response(f"Person {userId} deleted", 200)
    else:
        abort(404, f"Person not found for Id: {userId}")
