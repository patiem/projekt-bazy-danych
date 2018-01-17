from random import randint, random, randrange
from datetime import timedelta, datetime


class DataGenerator(object):
    _DATE_FORMAT = '%Y-%m-%d'
    _DATETIME_FORMAT = '%Y-%m-%d %H:00'

    CONFS_PER_MONTH = (2, 3)
    CONF_LENGTH = (1, 4)
    WORKSHOPS_PER_DAY = (2, 4)
    PRICES_PER_CONF = (2, 4)
    PPL_PER_CONF = (160, 240)
    PPL_PER_WORKSHOP = (30, 70)

    clients = 0
    participants = 0
    conferences = 0
    workshops = 0
    conference_registrations = 0
    workshop_registrations = 0

    class _NameGenerator(object):
        first_names = (
            'David', 'Paul', 'Christopher', 'Thomas', 'John', 'Mark',
            'James', 'Stephen', 'Andrew', 'Jack', 'Michael', 'Daniel',
            'Peter', 'Richard', 'Matthew', 'Robert', 'Ryan', 'Joshua',
            'Alan', 'Ian', 'Simon', 'Luke', 'Samuel', 'Jordan', 'Anthony',
            'Adam', 'Lee', 'Alexander', 'William', 'Kevin', 'Darren',
            'Benjamin', 'Philip', 'Gary', 'Joseph', 'Brian', 'Steven',
            'Liam', 'Keith', 'Martin', 'Jason', 'Jonathan', 'Jake',
            'Graham', 'Nicholas', 'Craig', 'George', 'Colin', 'Neil',
            'Lewis', 'Nigel', 'Oliver', 'Timothy', 'Stuart', 'Kenneth',
        )

        last_names = (
            'Savage', 'Winter', 'Metcalfe', 'Harper', 'Burgess', 'Bailey',
            'Potts', 'Boyle', 'Brown', 'Jennings', 'Payne', 'Day',
            'Holland', 'Higgins', 'Rhodes', 'Hancock', 'Howells',
            'Fowler', 'Sims', 'Thomas', 'Parker', 'Bentley', 'Barnett',
            'Manning', 'Collier', 'Holloway', 'Hartley', 'George',
            'Tomlinson', 'Howard', 'Long', 'Farmer', 'Collins', 'Rice',
            'Townsend', 'Rees', 'Bruce', 'Hammond', 'Ford', 'Tucker',
            'Wallis', 'Hamilton', 'Ferguson', 'Hooper', 'Francis', 'Reeves',
            'Barlow', 'Short', 'Cunningham', 'Hopkins', 'Nicholson', 'Archer',
            'Green', 'Glover', 'Gibson', 'Spencer', 'Warner', 'Webb',
        )

        @classmethod
        def get_first_name(cls):
            i = randint(0, len(cls.first_names)-1)
            return cls.first_names[i]

        @classmethod
        def get_last_name(cls):
            i = randint(0, len(cls.last_names)-1)
            return cls.last_names[i]

        @classmethod
        def get_email(cls):
            i = randint(0, len(cls.last_names) - 1)
            return cls.last_names[i].lower() + str(i) + '@example.com'

        @classmethod
        def get_student_id(cls):
            i = randint(100000, 999999)
            return i if i % 3 else "NULL"

    class _ConfNameGenerator(object):
        formats = (
            "All about %(topic)s",
            "Using %(topic)s in practice",
            "What is %(topic)s?",
            "Cryptic %(topic)s explained",
            "Practical %(topic)s uncovered",
            "Leveraging %(topic)s for scalability",
            "The ultimate intro to %(topic)s",
        )

        topics = (
            "404", "411", "anime", "button",
            "bandwidth", "biobreak", "brain", "dump", "cached",
            "out", "cookies", "cryptic", "dead-tree", "version",
            "deep", "dive", "defrag", "delete", "time",
            "eye", "candy", "Film", "11", "Google",
            "spot", "huge", "pipes", "interface", "just-in-time",
            "JIT", "legacy", "media", "McLuhanism", "meatspace",
            "mommy-save", "morph", "morphing", "multitasking",
            "navigate", "opt-out", "PDFing", "photoshopped", "PING",
            "ping", "plug-and-play", "plugged-in", "radar",
            "screen", "rant-and-rave", "robot", "scaleable",
            "scalability", "shelfware", "showstopper", "spammin'",
            "surf", "surfing", "thread", "TMI", "unplugged",
            "user", "yoyo", "mode",
        )

        @classmethod
        def get_conf_name(cls):
            i = randint(0, max(len(cls.formats), len(cls.topics))-1)
            topic = cls.topics[i % len(cls.topics)]
            format = cls.formats[i % len(cls.formats)]

            return format % {
                'topic': topic,
            }

    class _CompanyGenerator(object):
        formats = (
            '%(last_name1)s %(suffix)s',
            '%(last_name1)s-%(last_name2)s',
            '%(last_name1)s, %(last_name2)s and %(last_name2)s'
        )

        suffixes = ('Inc', 'and Sons', 'LLC', 'Group', 'Ltd')

        @classmethod
        def get_company(cls):
            i = randint(0, max(len(cls.suffixes), len(cls.formats))-1)
            suffix = cls.suffixes[i % len(cls.suffixes)]
            ctx = {
                'last_name1': DataGenerator._NameGenerator.get_last_name(),
                'last_name2': DataGenerator._NameGenerator.get_last_name(),
                'last_name3': DataGenerator._NameGenerator.get_last_name(),
                'suffix': suffix,
            }
            return cls.formats[i % len(cls.formats)] % ctx

    @staticmethod
    def _list_args(args):
        str_args = map(lambda x: str(x), args)
        return ", ".join(str_args)

    @staticmethod
    def _generate_conf(start_date, end_date):
        DataGenerator.conferences += 1
        args = (
            "'" + DataGenerator._ConfNameGenerator.get_conf_name() + "'",
            randint(DataGenerator.PPL_PER_CONF[0], DataGenerator.PPL_PER_CONF[1]),
            start_date.strftime(DataGenerator._DATE_FORMAT),
            end_date.strftime(DataGenerator._DATE_FORMAT),
        )
        return "EXEC dbo.create_conference " + DataGenerator._list_args(args)

    @staticmethod
    def _generate_workshop(conf_id, start_datetime):
        DataGenerator.workshops += 1
        length = randint(1, 5)
        args = (
            conf_id,
            randint(DataGenerator.PPL_PER_WORKSHOP[0], DataGenerator.PPL_PER_WORKSHOP[1]),
            start_datetime.strftime(DataGenerator._DATETIME_FORMAT),
            (start_datetime + timedelta(hours=length)).strftime(DataGenerator._DATETIME_FORMAT),
            randint(20, 40),
        )
        return "EXEC dbo.create_workshop_for_conference " + DataGenerator._list_args(args)

    @staticmethod
    def _generate_client():
        DataGenerator.clients += 1
        is_company = bool(randint(1, 100) % 2)
        args = (
            DataGenerator._CompanyGenerator.get_company(),
            DataGenerator._NameGenerator.get_email(),
            int(is_company),
        )
        return "EXEC dbo.create_client " + DataGenerator._list_args(args)

    @staticmethod
    def _generate_participant(client_id, is_company):
        DataGenerator.participants += 1
        empty_info = not bool(randint(1, 100) % 5) and is_company
        args = (
            client_id,
            'NULL' if empty_info else DataGenerator._NameGenerator.get_first_name(),
            'NULL' if empty_info else DataGenerator._NameGenerator.get_last_name(),
            'NULL' if empty_info else DataGenerator._NameGenerator.get_email(),
            'NULL' if empty_info else DataGenerator._NameGenerator.get_student_id(),
        )
        return "EXEC dbo.create_participant_for_client " + DataGenerator._list_args(args)

    @staticmethod
    def _generate_conf_booking(conf_id, participant_id, start_date, end_date):
        return "EXEC dbo.register_for_conference {}, {}, {}, {}".format(conf_id, participant_id, start_date, end_date)

    @staticmethod
    def _generate_workshop_booking(workshop_id, participant_id):
        return "EXEC dbo.register_for_workshop {}, {}".format(workshop_id, participant_id)

    @staticmethod
    def _generate_price_thresholds(conf_id, start_date, end_date):
        _timedelta = (end_date - start_date)
        steps = randint(
            DataGenerator.PRICES_PER_CONF[0], DataGenerator.PRICES_PER_CONF[1]
        )

        prices = sorted([
            randint(50, 150) for i in range(steps)
        ])
        student_discount = str(round(random(), 2))

        ret = ''
        for price in prices:
            ret += "EXEC dbo.create_price_threshold_for_conference {}, {}, {}, {}\n".format(
                conf_id, start_date.strftime(DataGenerator._DATE_FORMAT), price, student_discount
            )
            start_date += _timedelta / steps

        return ret

    @staticmethod
    def get_random_date(start_date, end_date):
        delta = end_date - start_date
        int_delta = (delta.days * 24) + delta.hours
        random_hour = randrange(int_delta)
        return (start_date + timedelta(hours=random_hour))

    @classmethod
    def generate(cls):
        #TODO beautify
        start_date = datetime.now() - timedelta(years=3)
        end_date = datetime.now()
        for i in range(60):
            _start_date = DataGenerator.get_random_date(start_date, end_date)
            _end_date = DataGenerator.get_random_date(_start_date, _start_date + timedelta(days=20))
            DataGenerator._generate_conf(_end_date, DataGenerator.get_random_date(_end_date, _end_date + timedelta(days=5)))
            DataGenerator._generate_price_thresholds(_start_date, _end_date)

            conf_participants = []
            for __ in range(100):
                participant_id = randint(0, DataGenerator.participants)
                DataGenerator._generate_conf_booking(i, participant_id)
                conf_participants.append(participant_id)

            for __ in range(4):
                DataGenerator._generate_workshop(i, _end_date, DataGenerator.get_random_date(_end_date, _end_date + timedelta(days=5)))
