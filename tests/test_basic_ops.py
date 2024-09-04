from fixture import TestFixture

class TestBasicOps(TestFixture):

    def test_identity(self):
        self.assert_evals_to("5", 5)

    def test_add(self):
        self.assert_evals_to("1 2 +", 3)

    def test_sub(self):
        self.assert_evals_to("2 7 -", -5)

    def test_mult(self):
        self.assert_evals_to("2 3 *", 6)

    def test_div(self):
        self.assert_evals_to("8 2 /", 4)
