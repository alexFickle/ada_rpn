from fixture import TestFixture

class TestVariables(TestFixture):

    def test_underscore_unbound(self):
        self.assert_errors("_")

    def test_underscore_usages(self):
        self.assert_evals_to("2", 2)
        self.assert_evals_to("_ 3 +", 5)
        self.assert_evals_to("_ 3 +", 8)
