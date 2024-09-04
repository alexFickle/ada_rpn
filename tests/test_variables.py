from fixture import TestFixture

class TestVariables(TestFixture):

    def test_underscore_unbound(self):
        self.assert_errors("_")

    def test_underscore_usages(self):
        self.assert_evals_to("2", 2)
        self.assert_evals_to("_ 3 +", 5)
        self.assert_evals_to("_ 3 +", 8)

    def test_binding(self):
        self.assert_evals_to("x := 2 3 *", 6)
        self.assert_evals_to("x", 6)

    def test_binding_preserves_underscore(self):
        self.assert_evals_to("10", 10)
        self.assert_evals_to("x := 5", 5)
        self.assert_evals_to("x _ +", 15)

    def test_binding_space_handling(self):
        self.assert_evals_to("x := 5", 5)
        self.assert_evals_to(" x := 6", 6)
        self.assert_evals_to("x := 7 ", 7)
        self.assert_evals_to("x  := 8", 8)
        self.assert_evals_to(" x  :=  9 ", 9)
