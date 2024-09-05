import unittest
import subprocess
import math

_test_binary: str | None = None

def set_test_binary(binary: str):
    global _test_binary
    _test_binary = binary

class TestFixture(unittest.TestCase):

    def setUp(self) -> None:
        if _test_binary is None:
            raise RuntimeError("fixture.set_test_binary() must be called before testing starts")
        self.__process = subprocess.Popen([_test_binary], stdin=subprocess.PIPE, stdout=subprocess.PIPE, text=True)
        # ignore the startup line
        self.__read_line()

    def tearDown(self) -> None:
        self.__process.kill()

    def __write_line(self, line: str) -> None:
        self.__process.stdin.write(line + '\n')
        self.__process.stdin.flush()

    def __read_line(self) -> str:
        # TODO: timeout logic, currently can block forever
        return self.__process.stdout.readline()[:-1]

    def run_command(self, command: str) -> str:
        self.__write_line(command)
        return self.__read_line()

    def assert_errors(self, command: str):
        """
        Asserts that the given command errors.
        """
        response = self.run_command(command)
        self.assertTrue(
            response.startswith("error"),
            f"expected command to error, read: {response!r}"
        )
    
    def __assert_result_eq_int(self, result: str, expected_value: int):
        result_value = int(result)
        self.assertEqual(result_value, expected_value)

    def __assert_result_eq_float(self, result: str, expected_value: float):
        if expected_value == math.inf:
            self.assertTrue(result.startswith("+Inf"), f"expected +Inf, result: {result!r}")
        elif expected_value == -math.inf:
            self.assertTrue(result.startswith("-Inf"), f"expected -Inf, result: {result!r}")
        elif math.isnan(expected_value):
            self.assertTrue(result.startswith("NaN"), f"expected NaN, result: {result!r}")
        else:
            self.assertTrue('.' in result, f"expected floating point result: {result!r}")
            self.assertTrue('E' in result, f"expected floating point result: {result!r}")
            result_value = float(result)
            self.assertAlmostEqual(result_value, expected_value)

    def assert_evals_to(self, command: str, expected_value: int | float) -> None:
        """
        Asserts that the given command results to an expected type and value.
        """
        response = self.run_command(command)
        self.assertFalse(
            response.startswith("error"),
            f"expected command to run successfully, read: {response!r}"
        )
        result = response.strip()

        if isinstance(expected_value, int):
            self.__assert_result_eq_int(result, expected_value)
        elif isinstance(expected_value, float):
            self.__assert_result_eq_float(result, expected_value)
        else:
            raise TypeError(f"unexpected type for expected_value: {expected_value!r}")
