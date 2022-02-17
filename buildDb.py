from datetime import datetime
from config import db
from userDbConfig import Person, Note

# Data to initialize database with
PEOPLE = [
    {
        "firstName": "Doug",
        "lastName": "Farrell",
        "coins": 123,
        "level": 3,
        "status": "I love shisha",
        "notes": [
            (1, "2019-01-06 22:17:54"),
            (2,  "2019-01-08 22:17:54"),
            (5, "2019-03-06 22:17:54"),
        ],
    },
    {
        "firstName": "Kent",
        "lastName": "Brockman",
        "coins": 124,
        "level": 4,
        "status": "I love shisha too",
        "notes": [
            (8, "2019-01-07 22:17:54",),
            (11, "2019-02-06 22:17:54",),
        ],
    },
    {
        "firstName": "Bunny",
        "lastName": "Easter",
        "coins": 125,
        "level": 5,
        "status": "I hate shisha",
        "notes": [
            (6, "2019-01-07 22:47:54"),
            (1, "2019-04-06 22:17:54"),
        ],
    },
]

# Create the database
db.create_all()

# iterate over the PEOPLE structure and populate the database
for person in PEOPLE:

    p = Person(
        lastName=person.get("lastName"),
        firstName=person.get("firstName"),
        coins=person.get("coins"),
        level=person.get("level"),
        status=person.get("status")
        )

    # Add the notes for the person
    for note in person.get("notes"):
        achieve_id, time_from = note
        p.notes.append(
            Note(
                achieve_id=achieve_id,
                time_from=datetime.strptime(time_from, "%Y-%m-%d %H:%M:%S"),
            )
        )
    db.session.add(p)

db.session.commit()
