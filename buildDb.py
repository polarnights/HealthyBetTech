from datetime import datetime
from config import db
from userDbConfig import UserInitSchema, UserInfo
from userDbAccess import setUser

# Fake people for testing
userSchemaInitialized = [
    {
        "firstName": "Tester",
        "lastName": "MegaTester",
        "phoneNumber": "88005553535",
        "email": "mailme1@icloud.com",
    },
    {
        "firstName": "cornerCaseSameLastName",
        "lastName": "MegaTester",
        "phoneNumber": "88005553536",
        "email": "mailme2@icloud.com",
    },
    {
        "firstName": "invalidnam3",
        "lastName": "some    tabs in lastname",
        "phoneNumber": "88015553537",
        "email": "mailme3@icloud.com",
    },
    {
        "firstName": "cornerCaseInvalidEmail",
        "lastName": "oklastName",
        "phoneNumber": "88015553538",
        "email": "mailme4@_icloud.32sm",
    },
]

db.create_all()

for user in userSchemaInitialized:
    userDb = UserInfo(
        lastName=user.get("lastName"),
        firstName=user.get("firstName"),
        email=user.get("email"),
        phoneNumber=user.get("phoneNumber"),
        )

    # Checker on validness : userDbAccess.setUser(user)
    db.session.add(user)

db.session.commit()
