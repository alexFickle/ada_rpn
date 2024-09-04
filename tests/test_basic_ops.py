from fixture import TestFixture

import math

class TestBasicOps(TestFixture):

    def test_identity(self):
        self.assert_evals_to("5", 5)

    def test_identity_float(self):
        self.assert_evals_to("5.0", 5.0)

    def test_add(self):
        self.assert_evals_to("1 2 +", 3)

    def test_add_float(self):
        self.assert_evals_to("1.0 5 +", 6.0)
        self.assert_evals_to("1 5.0 +", 6.0)
        self.assert_evals_to("1.0 5.0 +", 6.0)

    def test_sub(self):
        self.assert_evals_to("2 7 -", -5)

    def test_sub_float(self):
        self.assert_evals_to('2.0 7 -', -5.0)
        self.assert_evals_to('2 7.0 -', -5.0)
        self.assert_evals_to('2.0 7.0 -', -5.0)

    def test_mult(self):
        self.assert_evals_to("2 3 *", 6)

    def test_mult_float(self):
        self.assert_evals_to("2.0 3 *", 6.0)
        self.assert_evals_to("2 3.0 *", 6.0)
        self.assert_evals_to("2.0 3.0 *", 6.0)

    def test_div(self):
        self.assert_evals_to("8 2 //", 4)
        self.assert_evals_to("8.0 2 //", 4)
        self.assert_evals_to("8 2.0 //", 4)
        self.assert_evals_to("8.0 2.0 //", 4)

    def test_div_by_zero(self):
        self.assert_errors("8 0 //")
        self.assert_errors("-8 0 //")
        self.assert_errors("0 0 //")

    def test_div_float(self):
        self.assert_evals_to("8 2 /", 4.0)
        self.assert_evals_to("8.0 2 /", 4.0)
        self.assert_evals_to("8 2.0 /", 4.0)
        self.assert_evals_to("8.0 2.0 /", 4.0)

    def test_div_by_zero_float(self):
        self.assert_evals_to("8 0 /", math.inf)
        self.assert_evals_to("-8 0 /", -math.inf)
        self.assert_evals_to("0 0 /", math.nan)

    def test_pow(self):
        self.assert_evals_to("2 3 **", 8)

    def test_pow_sqrt(self):
        self.assert_evals_to("2 0.5 **", 2 ** 0.5)

    def test_pow_invert(self):
        self.assert_evals_to("2 -1 **", 0.5)

    def test_pow_float(self):
        self.assert_evals_to("pi 2 **", math.pi ** 2)
