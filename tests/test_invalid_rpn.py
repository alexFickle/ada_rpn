from fixture import TestFixture

class TestInvalidRPN(TestFixture):

    def test_unknown_symbol(self):
        self.assert_errors("t")

    def test_missing_argument(self):
        self.assert_errors("1 +")

    def test_too_many_arguments(self):
        self.assert_errors("1 1 1 +")
