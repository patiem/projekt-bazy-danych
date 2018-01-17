from random import randint, random, randrange
from datetime import timedelta, datetime
from copy import copy


class DataGenerator(object):
    _DATE_FORMAT = '%Y-%m-%d'
    _DATETIME_FORMAT = '%Y-%m-%d %H:00'

    DAYS_BETWEEN_CONFS = (10, 20)
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
        print "EXEC dbo.create_conference " + DataGenerator._list_args(args)
        return DataGenerator.conferences

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
        print "EXEC dbo.create_workshop_for_conference " + DataGenerator._list_args(args)
        return DataGenerator.workshops

    @staticmethod
    def _generate_client():
        DataGenerator.clients += 1
        is_company = bool(randint(1, 100) % 2)
        args = (
            DataGenerator._CompanyGenerator.get_company(),
            DataGenerator._NameGenerator.get_email(),
            int(is_company),
        )
        print "EXEC dbo.create_client " + DataGenerator._list_args(args)
        return DataGenerator.clients

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
        print "EXEC dbo.create_participant_for_client " + DataGenerator._list_args(args)
        return DataGenerator.participants

    @staticmethod
    def _generate_conf_booking(conf_id, participant_id, start_date, end_date):
        print "EXEC dbo.register_for_conference {}, {}, {}, {}".format(conf_id, participant_id, start_date, end_date)

    @staticmethod
    def _generate_workshop_booking(workshop_id, participant_id):
        print "EXEC dbo.register_for_workshop {}, {}".format(workshop_id, participant_id)

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

        for price in prices:
            print "EXEC dbo.create_price_threshold_for_conference {}, {}, {}, {}".format(
                conf_id, start_date.strftime(DataGenerator._DATE_FORMAT), price, student_discount
            )
            start_date += _timedelta / steps

    @staticmethod
    def get_random_date(start_date, end_date):
        delta = end_date - start_date
        int_delta = (delta.days * 24) + delta.hours
        random_hour = randrange(int_delta)
        return (start_date + timedelta(hours=random_hour))

    @classmethod
    def generate(cls, global_start_date=datetime.now() - timedelta(weeks=156), global_end_date=datetime.now()):
        start_date = copy(global_start_date)
        while start_date < global_end_date:
            _length = randint(DataGenerator.CONF_LENGTH[0], DataGenerator.CONF_LENGTH[1])
            end_date = start_date + timedelta(days=_length - 1)
            conf_id = DataGenerator._generate_conf(start_date, end_date)
            for i in range(_length):
                number_of_workshops = randint(DataGenerator.WORKSHOPS_PER_DAY[0], DataGenerator.WORKSHOPS_PER_DAY[1])
                for __ in range(number_of_workshops):
                    hour = randint(5, 23)
                    workshop_id = DataGenerator._generate_workshop(conf_id, (start_date + timedelta(days=i)).replace(hour=hour))


            days_to_skip = randint(DataGenerator.DAYS_BETWEEN_CONFS[0], DataGenerator.DAYS_BETWEEN_CONFS[1])
            start_date += timedelta(days=days_to_skip)