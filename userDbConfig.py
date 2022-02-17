from datetime import datetime
from config import db
from marshmallow_sqlalchemy import SQLAlchemyAutoSchema

class UserInfo(db.Model):
    __tablename__ = "userInfo"

    userId = db.Column(db.Integer, primary_key=True)
    lastName = db.Column(db.String(50))
    firstName = db.Column(db.String(50))
    phoneNumber = db.Column(db.String(50))
    email = db.Column(db.String(50))
    timestamp = db.Column(
        db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow
    )


class UserInitSchema(SQLAlchemyAutoSchema):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)

    class Meta:
        model = UserInfo
        include_relationships = True
        load_instance = True
