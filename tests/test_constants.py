from fixture import TestFixture

import math

class TestInvalidRPN(TestFixture):

    def test_e_identity(self):
        self.assert_evals_to("e", math.e)

    def test_2e(self):
        self.assert_evals_to("e 2 *", 2 * math.e)

    def test_pi_identity(self):
        self.assert_evals_to("pi", math.pi)

    def test_2pi(self):
        self.assert_evals_to("pi 2 *", 2 * math.pi)
